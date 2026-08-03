# Changelog

All notable changes to this project are documented here.

## [Unreleased]

## [0.10.0] - 2026-08-03

### Added

- Created the `liblevenshtein-cli` package from the executable history of
  `liblevenshtein-rust`.
- Moved the `liblevenshtein` executable, REPL, filesystem grep pipeline,
  compression/archive readers, and PDF, DOCX, XLSX, EPUB, ODT, DjVu, and OCR
  integration into this application crate.
- Enabled the complete pure-Rust search stack by default; Tesseract OCR remains
  opt-in through `grep-pdf-ocr`.
- Added executable archives plus Debian, RPM, and Arch Linux package workflows.

### Changed

- The installed executable remains `liblevenshtein`; only its Cargo package
  and source repository change.
- Application modules are private. The package library exposes only
  `liblevenshtein_cli::run()` for the binary wrapper.

[Unreleased]: https://github.com/vinary-tree/liblevenshtein-rust-cli/compare/v0.10.0...HEAD
[0.10.0]: https://github.com/vinary-tree/liblevenshtein-rust-cli/releases/tag/v0.10.0
