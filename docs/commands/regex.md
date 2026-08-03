# Phonetic rules and LLRE operations

The `.llev` domain-specific language (DSL) describes phonetic rewrite rules.
The Levenshtein-language regular-expression (LLRE) DSL describes regular
languages compiled to nondeterministic finite automata (NFAs). An NFA represents
multiple possible matching states without recursive backtracking.

Language syntax and theoretical details live with the reusable implementation:

- [`.llev` grammar](https://github.com/vinary-tree/liblevenshtein-rust/blob/master/docs/grammar/llev.ebnf)
- [LLRE guide](https://github.com/vinary-tree/liblevenshtein-rust/blob/master/docs/llre/README.md)
- [`.llre` grammar](https://github.com/vinary-tree/liblevenshtein-rust/blob/master/docs/grammar/llre.ebnf)

## Compile and apply phonetic rules

```bash
liblevenshtein --compile --input english.llev \
  --output english.llev.bin --verify
liblevenshtein --phonetic --text "telephone" --rules english.llev
liblevenshtein --phonetic --text "telephone" \
  --rules english.llev.bin --compiled
```

`--unicode` is enabled by default and selects character-level Unicode rules.
Without `--output`, compilation derives a binary path from the input. `--verify`
reloads the generated artifact before reporting success. `--compiled` forces
binary rule loading when extension-based detection is insufficient.

## Compile and match LLRE

```bash
liblevenshtein --compile-regex --input identifier.llre \
  --output identifier.llre.bin --verify
liblevenshtein --match-regex --rules identifier.llre \
  --text "sample_42"
liblevenshtein --match-regex --rules identifier.llre.bin \
  --compiled --text $'first\nsecond' --multiline --dotall
```

`--multiline` makes anchors recognize line boundaries. `--dotall` permits the
dot atom to match newlines. A `.bin` extension selects compiled loading
automatically; `--compiled` makes that choice explicit. The command reports both
general and full-string match results when they differ.

All operations on this page require `phonetic-rules` and `serialization`; the
default `cli` feature enables both.

[← Command-line reference](README.md)
