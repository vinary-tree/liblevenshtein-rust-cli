#!/usr/bin/env bash
# Render PlantUML sources to committed, byte-reproducible sibling SVG files.
set -euo pipefail

diagram_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

render_one() {
  local source="$1" output_dir="$2"
  JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:-} -Djava.awt.headless=true" \
    plantuml -tsvg -nometadata -o "$output_dir" "$source"
}

mapfile -t sources < <(find "$diagram_dir" -maxdepth 1 -name '*.puml' -type f | sort)
[ "${#sources[@]}" -gt 0 ] || { echo "render.sh: no PlantUML sources" >&2; exit 1; }
command -v plantuml >/dev/null 2>&1 || { echo "render.sh: plantuml is required" >&2; exit 1; }

if [ "${1:-}" = "--check" ]; then
  temporary_dir="$(mktemp -d)"
  trap 'rm -rf "$temporary_dir"' EXIT
  drift=0
  for source in "${sources[@]}"; do
    render_one "$source" "$temporary_dir"
    expected="${source%.puml}.svg"
    actual="$temporary_dir/$(basename "${source%.puml}.svg")"
    if [ ! -f "$expected" ] || ! diff -q "$expected" "$actual" >/dev/null; then
      echo "render.sh: diagram drift: $expected" >&2
      drift=1
    fi
  done
  [ "$drift" -eq 0 ] || exit 1
  echo "render.sh: all ${#sources[@]} SVG(s) are in sync."
else
  for source in "${sources[@]}"; do
    render_one "$source" "$diagram_dir"
    echo "render.sh: rendered ${source#$diagram_dir/}"
  done
fi
