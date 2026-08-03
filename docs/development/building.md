# Building and verification

## Sibling checkout layout

Development manifests use local paths so coordinated unreleased changes can be
tested together:

```text
workspace/
├── llattice/
├── libdictenstein/
├── liblevenshtein-rust/
└── liblevenshtein-rust-cli/
```

From `liblevenshtein-rust-cli`:

```bash
cargo build --locked
cargo test --locked
cargo test --locked --all-features
cargo clippy --locked --all-features --all-targets -- -D warnings
cargo fmt --all --check
scripts/verify-package.sh
```

`scripts/verify-package.sh` builds the normalized crate archive against the
exact sibling library sources, installs that archive into a temporary Cargo
root, and smoke-tests the installed executable. It does not contact a publish
endpoint or alter either library manifest.

PathMap uses gxhash on x86_64, where AES and SSE2 must be enabled at compile
time. The committed Cargo configuration enables those two target features and
does not use `target-cpu=native`, so release artifacts do not inherit unrelated
instructions from the build host.

## Feature groups

| Feature | Purpose |
|---|---|
| `cli` | Executable, dictionary persistence, PathMap backend, and phonetic rules. |
| `grep-compression` | gzip, zstd, xz, and bzip2. |
| `grep-archives` | tar/zip traversal and glob filtering. |
| `grep-documents` | PDF, DOCX, XLSX, EPUB, and ODT extraction. |
| `grep-pdf-ocr` | Tesseract/Leptonica OCR fallback for image-based PDFs. |
| `parallel-grep` | Rayon-backed in-memory phonetic matching. |
| `protobuf` | Protocol Buffers dictionary persistence. |

The default set is `cli`, `compression`, `protobuf`, and `grep-full`.
`grep-full` includes pure-Rust ingestion and document support but not OCR.

## OCR prerequisites

All-feature builds require Tesseract and Leptonica development libraries. On a
Debian-family system:

```bash
sudo apt-get update
sudo apt-get install -y libleptonica-dev libtesseract-dev tesseract-ocr
cargo build --all-features
```

The CI image also installs `poppler-utils` and `djvulibre-bin` for document test
coverage. Package names differ by operating system; use the platform's trusted
package manager.

## Reproducible diagrams

PlantUML sources and committed SVGs live in `docs/diagrams`. Render and verify
them with:

```bash
docs/diagrams/render.sh
docs/diagrams/render.sh --check
```

[← Documentation index](../README.md)
