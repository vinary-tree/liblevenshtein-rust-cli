# Future release process

This page records the intended release order; it does not authorize publishing.
Version 0.10.0 remains unpublished while coordinated changes are in progress.

## Dependency order

1. Verify and publish any required `llattice` and `libdictenstein` versions.
2. Verify and publish `liblevenshtein` 0.10.0.
3. Verify `liblevenshtein-cli` 0.10.0 against the published library versions.
4. Only after reviewing the package contents, publish the CLI crate and create
   binary/package release artifacts.

CI always verifies packaging: it builds the normalized CLI crate archive
against the exact sibling sources, installs the archive into an isolated Cargo
root, and smoke-tests the installed executable. A future registry publication
still follows the dependency order above so registry consumers resolve the
same compatible library versions.

A manual release-workflow run rehearses binary and operating-system packages
against the sibling source checkouts and cannot publish. A future tag build
resolves the previously published library crates from the registry; only its
tag-gated jobs can publish the CLI crate or create the GitHub release.

## Pre-release evidence

Before a future tag, require clean results for formatting, default and
all-feature tests, strict Clippy, the diagram drift check, package inspection,
and an installed-binary smoke test. Confirm repository metadata points to
`https://github.com/vinary-tree/liblevenshtein-rust-cli` and review the release
workflow without triggering it.

Do not publish from a development checkout merely to make a package check pass.
The library-first order is part of the compatibility contract.

[← Documentation index](../README.md)
