# liblevenshtein CLI

Command-line, REPL, archive, compressed-file, and document-search tools powered
by the [liblevenshtein](https://github.com/vinary-tree/liblevenshtein-rust)
library.

This crate intentionally owns application-only dependencies such as `clap`,
`rustyline`, `zip`, `tar`, `quick-xml`, `pdf-extract`, `docx-rs`,
`calamine`, and the optional OCR stack. Applications can depend on
`liblevenshtein` without resolving those packages.

## Status and installation

Version 0.10.0 has not been published to crates.io yet. Until the coordinated
library and CLI release is ready, build from sibling checkouts as described
below. After publication, the package will be installable with
`cargo install liblevenshtein-cli`.

The executable remains `liblevenshtein`. Operations are selected with flags:

```bash
liblevenshtein --help
liblevenshtein --query --text "tset" --dict words.bin --max-distance 2
liblevenshtein --grep --pattern "fone" --files documents/report.pdf
liblevenshtein --repl
```

The default feature set includes compression, archives, PDF, DOCX, XLSX, EPUB,
and ODT support. OCR is opt-in because it requires native Tesseract and
Leptonica libraries:

```bash
cargo install liblevenshtein-cli --features grep-pdf-ocr
```

## Build from a checkout

Keep sibling checkouts together:

```text
workspace/
├── libdictenstein/
├── liblevenshtein-rust/
└── liblevenshtein-rust-cli/
```

Then:

```bash
cargo build
cargo test --all-features
```

See the [documentation index](docs/README.md) for the complete command syntax,
grep ingestion and security model, REPL reference, architecture, build, and
future release process.

## Feature groups

| Feature | Purpose |
|---|---|
| `grep-compression` | gzip, zstd, xz, and bzip2 |
| `grep-archives` | tar/zip traversal and archive path filters |
| `grep-documents` | PDF, DOCX, XLSX, EPUB, and ODT extraction |
| `grep-pdf-ocr` | OCR fallback using Tesseract/Leptonica |
| `parallel-grep` | parallel in-memory phonetic matching |
| `protobuf` | protobuf dictionary persistence |

The Rust library target exposes only `liblevenshtein_cli::run()` as the seam
used by the two-line executable wrapper. Its application modules are private
and are not a supported reusable API.

## License

Apache-2.0
