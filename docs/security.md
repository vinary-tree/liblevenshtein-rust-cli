# Security and threat model

The CLI reads attacker-controllable files through compression, archive,
document, serialization, and optional optical character recognition (OCR)
parsers. It is a local process, not a network service, but callers may expose it
to network-originated content. In that deployment the process boundary is the
primary trust boundary.

## Input surfaces

| Surface | Risk | Built-in posture | Operator responsibility |
|---|---|---|---|
| Standard input | unbounded accumulated text | no CLI byte cap | bound the producer or the process |
| Compressed streams | decompression bombs | decoded bytes are capped by `--max-file-size` | retain a finite cap and time limit |
| Tar/zip entries | oversized entries, malformed metadata | entries are read for matching and not written to archive paths; decoded entry size is capped | run hostile parsers in a constrained process |
| PDF, DOCX, XLSX, EPUB, ODT | parser defects and resource exhaustion | opt-in feature families; decoded size cap | enable only required formats and update dependencies |
| OCR | native parser/engine defects, CPU and memory exhaustion | excluded from defaults; explicit feature and `--ocr` | install trusted native packages and sandbox hostile jobs |
| Dictionary files | malformed binary data and decompression | library serializers validate supported structure | authenticate artifacts and bound the process |
| `.llev` and `.llre` | parser/compiler resource use | finite-automaton matching avoids recursive backtracking | bound source size when accepting third-party patterns |

## Resource controls

The default decoded-size ceiling is 100 MiB per plain file or archive entry.
This is a content bound, not a complete job bound: an archive can contain many
entries, and OCR can consume substantial time without producing much text.
Combine `--max-file-size` with operating-system memory, CPU, wall-clock, and
process-count limits for untrusted batches. Standard input is accumulated
without that file-size bound, so constrain its producer or the process itself.

Archive entries are inspected in memory and are not extracted to paths supplied
by the archive, removing the usual archive path-traversal write primitive. This
does not make a malformed archive safe from defects in its parser. Document
extractors similarly process complex formats through third-party crates.

## Output and persistence

Do not direct concurrent CLI or REPL writers at the same dictionary file.
Maintain backups for valuable artifacts and restrict filesystem permissions on
configuration and dictionary paths. Terminal output may contain attacker-chosen
text; consumers should treat it as data and avoid evaluating it as shell input.

## Reporting

Report suspected vulnerabilities through the security advisory channel at
`https://github.com/vinary-tree/liblevenshtein-rust-cli`. Include the input
format, enabled features, exact command, version, and a minimized reproducer.

[← Documentation index](README.md)
