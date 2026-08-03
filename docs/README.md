# liblevenshtein CLI documentation

This documentation covers the `liblevenshtein-cli` application crate and the
installed `liblevenshtein` executable. The reusable automata, distance,
dictionary-integration, and phonetic APIs are documented in the
[`liblevenshtein` library repository](https://github.com/vinary-tree/liblevenshtein-rust).

## Start here

- [Command-line reference](commands/README.md) defines the operation-flag model
  and every top-level option.
- [Dictionary operations](commands/dictionaries.md) covers queries, mutation,
  conversion, backends, serialization formats, and persistent settings.
- [Grep](commands/grep.md) explains fuzzy phonetic matching across plain,
  compressed, archived, and document inputs.
- [Phonetic rules and LLRE](commands/regex.md) covers rule compilation,
  transformations, and the Levenshtein-language regular-expression (LLRE)
  operations.
- [REPL](repl.md) is the complete read-evaluate-print loop command reference.

## Design and operations

- [Architecture](development/architecture.md) explains the library/application
  boundary and end-to-end control flow.
- [Building](development/building.md) documents sibling checkouts, feature
  groups, native optical character recognition (OCR) prerequisites, and checks.
- [Releasing](development/releasing.md) records the future library-first release
  order. It does not authorize or perform a release.
- [Security](security.md) defines the untrusted-file threat model and resource
  controls for archive, decompression, document, and OCR processing.
- [Diagrams](diagrams/README.md) contains reproducible colored architecture and
  ingestion views.
- [CLI/REPL migration completion report](completion-reports/cli-repl-improvements-phases-1-3.md)
  preserves the implementation history that moved with the application.

## Terminology

- **CLI**: command-line interface; a single non-interactive invocation.
- **REPL**: read-evaluate-print loop; an interactive session that retains
  dictionary state.
- **OCR**: optical character recognition; conversion of page images into text.
- **Backend**: the dictionary data structure used for storage and traversal.
- **Serialization format**: the on-disk encoding of a dictionary.

[← Main README](../README.md)
