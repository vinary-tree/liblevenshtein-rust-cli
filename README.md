# liblevenshtein CLI

Command-line, REPL, archive, compressed-file, and document-search tools powered
by the [liblevenshtein](https://github.com/universal-automata/liblevenshtein-rust)
library.

This crate intentionally owns application-only dependencies such as `clap`,
`rustyline`, `zip`, `tar`, `quick-xml`, `pdf-extract`, `docx-rs`,
`calamine`, and the optional OCR stack. Applications can depend on
`liblevenshtein` without resolving those packages.

## Install

```bash
cargo install liblevenshtein-cli
```

The installed executable remains `liblevenshtein`:

```bash
liblevenshtein --help
liblevenshtein query "tset" --dict words.txt --max-distance 2
liblevenshtein grep "fone" documents/
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
