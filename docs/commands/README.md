# Command-line reference

`liblevenshtein` uses an **operation flag**, not a subcommand. Exactly one
operation flag is required per invocation. Shared options follow in any order.

```text
liblevenshtein <OPERATION> [OPTIONS] [TERMS]...
```

For the authoritative option list of the checked-out version, run:

```bash
cargo run -- --help
```

## Operations

| Operation | Short | Required operands | Purpose |
|---|---:|---|---|
| `--compile` | `-C` | `--input PATH` | Compile a `.llev` phonetic-rule file. |
| `--phonetic` | `-P` | `--text TEXT --rules PATH` | Transform text using phonetic rules. |
| `--query` | `-Q` | `--text TERM` | Query a serialized dictionary. |
| `--repl` | `-R` | none | Start the interactive REPL. |
| `--info` | `-I` | none | Inspect a serialized dictionary. |
| `--convert` | — | `--input PATH --output PATH` | Change backend and/or serialization format. |
| `--insert` | — | one or more positional `TERMS` | Add terms and save the dictionary. |
| `--delete` | `-D` | one or more positional `TERMS` | Remove terms and save the dictionary. |
| `--clear` | — | none | Confirm, then remove every term. |
| `--minimize` | `-M` | none | Compact a mutable backend when supported. |
| `--settings` | `-S` | none | Show or update persistent defaults. |
| `--config-mgmt` | — | `--show` or `--switch PATH` | Inspect or change the settings-file location. |
| `--compile-regex` | — | `--input PATH` | Compile a `.llre` file. |
| `--match-regex` | — | `--text TEXT --rules PATH` | Match text with source or compiled LLRE. |
| `--grep` | `-G` | `--pattern PATTERN` | Fuzzy-search files, archive entries, documents, or standard input. |

## Shared option vocabulary

| Option | Meaning |
|---|---|
| `--config PATH`, `-c PATH` | Use a configuration file for this invocation. |
| `--dict PATH`, `-d PATH` | Select a serialized dictionary. |
| `--backend NAME`, `-b NAME` | Select `path-map`, `double-array-trie`, `dynamic-dawg`, or `suffix-automaton`. |
| `--format NAME`, `-f NAME` | Select `bincode`, `protobuf`, `bincode-gz`, or `protobuf-gz`, subject to enabled features. |
| `--algorithm NAME`, `-a NAME` | Select the Levenshtein edit algorithm; the default is `standard`. |
| `--max-distance N`, `-m N` | Permit at most `N` edits; the default is `2`. |
| `--prefix`, `-p` | Treat the query as a dictionary prefix query. |
| `--show-distances`, `-s` | Print each query result's edit distance. |
| `--limit N`, `-l N` | Return at most `N` query results. |
| `--auto-sync` | Save after each REPL modification. |

Options that do not apply to the selected operation are parsed but ignored.
Prefer the smallest invocation that expresses the operation so scripts remain
easy to review.

## Exit behavior

A successful operation returns exit status `0`. Argument errors, unavailable
feature-dependent operations, failed parsing, and failed input/output return a
non-zero status and print an error to standard error. Human-readable operation
results are written to standard output.

[← Documentation index](../README.md)
