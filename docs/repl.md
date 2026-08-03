# Interactive REPL

The read-evaluate-print loop (REPL) keeps a dictionary and query settings in
memory across commands. Start it with:

```bash
liblevenshtein --repl --dict words.bin --auto-sync
```

Paths and terms containing whitespace are not quoted by the current REPL parser;
it separates tokens on whitespace. Use paths and terms without spaces or the
equivalent one-shot CLI operation.

## Command syntax

| Command | Aliases | Meaning |
|---|---|---|
| `query TERM [DISTANCE] [--prefix] [--limit N]` | `q` | Run a fuzzy query. |
| `insert TERM...` | `add` | Insert one or more terms. |
| `delete TERM...` | `remove`, `rm` | Remove terms. |
| `contains TERM` | `has` | Test exact membership. |
| `load PATH [BACKEND]` | — | Replace state by loading a dictionary. |
| `save PATH` | — | Save the current dictionary. |
| `insert-from PATH` | `merge` | Insert newline-delimited terms. |
| `remove-from PATH` | `subtract` | Remove newline-delimited terms. |
| `replace-with PATH` | `replace` | Replace all terms from a file. |
| `backend NAME` | `use` | Migrate to another backend. |
| `algorithm NAME` | `algo` | Select the edit algorithm. |
| `distance N` | `dist` | Set the default maximum edit distance. |
| `prefix [on|off]` | — | Show or set prefix mode. |
| `show-distances [on|off]` | `show-dist` | Show or set distance output. |
| `limit N` | — | Set the result limit. |
| `format NAME` | `serialization` | Select the save format. |
| `auto-sync [on|off]` | `autosync`, `sync` | Show or set save-after-mutation. |
| `clear` | — | Remove all in-memory terms. |
| `compact` | `minimize` | Compact the current backend. |
| `dump [LIMIT]` | `list` | Print terms. |
| `stats` | `info` | Print dictionary statistics. |
| `settings` | `set`, `options`, `opts` | Print active settings. |
| `config [PATH]` | `configuration` | Show or change the configuration path. |
| `cache enable STRATEGY [MAX_SIZE]` | — | Enable the query cache. |
| `cache disable`, `cache stats`, `cache clear` | — | Manage the query cache. |
| `help [COMMAND]` | `?` | Show general or command-specific help. |
| `exit` | `quit` | Leave the REPL. |

Backend, format, and algorithm values match the one-shot CLI. Boolean settings
accept `on` and `off`; omitting the value reports or toggles according to the
command's help. Run `help COMMAND` inside the REPL for the checked-out version's
authoritative details.

## Persistence model

Without auto-sync, mutations change only the in-memory dictionary until `save`.
With auto-sync enabled and a known dictionary path, successful mutations are
saved immediately. Because an interrupted write can still lose application
state, keep backups of valuable dictionary artifacts and avoid concurrent
writers to the same path.

[← Documentation index](README.md)
