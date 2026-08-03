# Dictionary operations

A **backend** is the in-memory dictionary data structure. A **serialization
format** is its on-disk encoding. Keeping those choices separate permits, for
example, a `dynamic-dawg` encoded with `protobuf-gz` or a `path-map` encoded
with `bincode`.

## Query and inspection

```bash
liblevenshtein --query --text "tset" --dict words.bin \
  --max-distance 2 --show-distances --limit 20
liblevenshtein --info --dict words.bin
```

`--prefix` changes the acceptance condition from a whole-term match to a prefix
match. `--algorithm` selects the edit model exposed by the library. Results are
ranked by the shared command engine and optionally include edit distances.

## Mutation

```bash
liblevenshtein --insert --dict words.bin --backend path-map \
  --format bincode alpha beta gamma
liblevenshtein --delete --dict words.bin beta
liblevenshtein --minimize --dict words.bin
liblevenshtein --clear --dict words.bin
```

`--insert` creates a missing dictionary using the requested or configured
backend and format. `--delete` requires an existing dictionary. `--clear` is
interactive and changes the file only after an affirmative `y` or `yes`.
`--minimize` saves a compacted representation when the backend supports it; a
read-only or already-minimized backend produces a warning without rewriting it.

## Conversion

```bash
liblevenshtein --convert \
  --input words.bin --output words.pb.gz \
  --from-backend path-map --to-backend dynamic-dawg \
  --from-format bincode --to-format protobuf-gz
```

Input backend and format are auto-detected when possible. Supplying
`--from-backend` or `--from-format` resolves ambiguity. Output defaults to the
`path-map` backend and `bincode` format when `--to-backend` and `--to-format`
are omitted.

## Backends

| Value | Mutability and use |
|---|---|
| `path-map` | General mutable default with path-oriented traversal. |
| `double-array-trie` | Compact static trie; use for read-heavy dictionaries. |
| `dynamic-dawg` | Mutable directed acyclic word graph (DAWG); supports compaction. |
| `suffix-automaton` | Suffix-oriented index for substring/corpus workloads. |

## Formats

| Value | Feature requirement | Encoding |
|---|---|---|
| `bincode` | `serialization` | Bincode binary dictionary. |
| `protobuf` | `protobuf` | Protocol Buffers binary dictionary. |
| `bincode-gz` | `compression` | Gzip-wrapped Bincode. |
| `protobuf-gz` | `protobuf` and `compression` | Gzip-wrapped Protocol Buffers. |

These are binary persistence formats, not interchangeable newline word lists.
Treat files from an untrusted party as untrusted parser input; see
[Security](../security.md).

## Persistent defaults

```bash
liblevenshtein --settings
liblevenshtein --settings --set-dict words.bin \
  --set-backend path-map --set-format bincode \
  --set-algorithm standard --set-max-distance 2
liblevenshtein --settings --reset
liblevenshtein --config-mgmt --show
liblevenshtein --config-mgmt --switch ./team-config.toml
```

`--settings` controls dictionary/query defaults. `--config-mgmt` controls which
settings file is active. A per-invocation `--config PATH` selects a file without
changing the application-wide location.

[← Command-line reference](README.md)
