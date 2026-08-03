# Future release process

This page records the intended release order; it does not authorize publishing.
Version 0.10.0 remains unpublished while coordinated changes are in progress.

## Dependency order

1. Verify and publish any required `llattice` and `libdictenstein` versions.
2. Verify and publish `liblevenshtein` 0.10.0.
3. Replace development path resolution with registry resolution and package
   `liblevenshtein-cli` 0.10.0.
4. Only after reviewing the package contents, publish the CLI crate and create
   binary/package release artifacts.

The CLI cannot be packaged against crates.io until the exact compatible core
library version exists there. CI intentionally defers its packaging check while
that prerequisite is absent.

## Pre-release evidence

Before a future tag, require clean results for formatting, default and
all-feature tests, strict Clippy, the diagram drift check, package inspection,
and an installed-binary smoke test. Confirm repository metadata points to
`https://github.com/vinary-tree/liblevenshtein-rust-cli` and review the release
workflow without triggering it.

Do not publish from a development checkout merely to make a package check pass.
The library-first order is part of the compatibility contract.

[← Documentation index](../README.md)
