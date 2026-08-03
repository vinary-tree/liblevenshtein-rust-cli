#!/usr/bin/env bash
# Verify the publish-shaped CLI archive against coordinated sibling sources.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
core_path="${LIBLEVENSHTEIN_CORE_PATH:-$repo_root/../liblevenshtein-rust}"
dictionary_path="${LIBDICTENSTEIN_PATH:-$repo_root/../libdictenstein}"

for sibling in "$core_path" "$dictionary_path"; do
  if [ ! -f "$sibling/Cargo.toml" ]; then
    echo "verify-package.sh: missing sibling manifest: $sibling/Cargo.toml" >&2
    exit 1
  fi
done

core_path="$(cd "$core_path" && pwd -P)"
dictionary_path="$(cd "$dictionary_path" && pwd -P)"
patches=(
  --config "patch.crates-io.liblevenshtein.path=\"$core_path\""
  --config "patch.crates-io.libdictenstein.path=\"$dictionary_path\""
)

cd "$repo_root"
cargo package --locked "${patches[@]}"

version="$(python3 -c '
import json
import sys

metadata = json.load(sys.stdin)
packages = [package for package in metadata["packages"] if package["name"] == "liblevenshtein-cli"]
if len(packages) != 1:
    raise SystemExit(f"expected one liblevenshtein-cli package, found {len(packages)}")
print(packages[0]["version"])
' < <(cargo metadata --locked --no-deps --format-version 1))"
package_dir="$repo_root/target/package/liblevenshtein-cli-$version"
package_archive="$repo_root/target/package/liblevenshtein-cli-$version.crate"
if [ ! -f "$package_dir/Cargo.toml" ] || [ ! -f "$package_archive" ]; then
  echo "verify-package.sh: Cargo did not produce the normalized package" >&2
  exit 1
fi

install_root="$(mktemp -d "${TMPDIR:-/tmp}/liblevenshtein-cli-install.XXXXXX")"
cleanup() {
  if [[ -n "$install_root" && "$install_root" == */liblevenshtein-cli-install.* ]]; then
    rm -rf -- "$install_root"
  fi
}
trap cleanup EXIT

contents="$install_root/package-contents.txt"
tar -tzf "$package_archive" > "$contents"
if grep -Eq '/(\.config|\.github|packaging|scripts)/|/deny\.toml$' "$contents"; then
  echo "verify-package.sh: development-only files leaked into the crate archive" >&2
  grep -E '/(\.config|\.github|packaging|scripts)/|/deny\.toml$' "$contents" >&2
  exit 1
fi
if ! grep -Eq '/\.cargo/config\.toml$' "$contents"; then
  echo "verify-package.sh: required x86_64 target configuration is missing" >&2
  exit 1
fi

tar -xzf "$package_archive" -C "$install_root"
package_source="$install_root/liblevenshtein-cli-$version"
(
  cd "$package_source"
  cargo install --locked --path . --root "$install_root/cargo-root" "${patches[@]}"
)
"$install_root/cargo-root/bin/liblevenshtein" --version
"$install_root/cargo-root/bin/liblevenshtein" --help >/dev/null

echo "verify-package.sh: package, install, and executable smoke test passed."
