# Getting started

To reproduce this disassembly you need Python 3 (with Pillow for the
pictures), GNU make and [Pasmo](https://pasmo.speccy.org/). The cartridge
image **is not in this repository**: bring your own.

```
goemon.rom    131,072 bytes
sha256        a436addc241d977ba38081463322e7e611d6bab4d10cd06305fe5a71f02a549c
```

With the file at the root of the repository:

```
make            # listing, verification, consistency and tests
```

## What each step does

| command | what it does |
|---|---|
| `make comprueba` | checks the sha256 of the ROM |
| `make reconoce` | the header and the 49 writes to the mapper, with their bank |
| `make listado` | builds the sixteen `.asm` files from the binary, the notes and the seeds |
| `make verify` | reassembles each bank and the whole ROM, and compares the sha256 |
| `make sanity` | checks that no data is read as code and that no byte is left unassigned |
| `make test` | the tests |
| `make densidad` | how many instructions carry a comment, bank by bank |
| `make imagenes` | draws the PNGs in `docs/imagenes/` from the ROM |
| `make coteja` | checks the pictures against the openMSX dumps in `work/` |
| `make web` | builds the HTML pages and checks the links |

`make verify` is the one that decides: at the end it must print `OK: la ROM
entera reproducible byte a byte`.

`make coteja` needs the openMSX dumps, which are not in the repository. They
are made with the launchers in [In the emulator](IN-THE-EMULATOR.md); the
neighbour one also needs the Q\*bert and Game Master images.

## Where everything is

- `src/goemon_pNN.asm`: the listing, one per bank. **It is generated**: do not
  edit it by hand.
- `src/pNN.notes`: the labels (`L`), line comments (`C`), data ranges (`D`)
  and routine headers (`B`). This **is** edited.
- `tools/anota.py`: the routine names.
- `src/pNN.entries` and `src/pNN.nocode`: each bank's entry points and the
  tables that are not code, taken from tracing the whole cartridge
  (`make semillas`).
- `tools/`: the tracer, the listing generator and the tools that draw and
  compare.
- `docs/`: this website, in English at the root and in Spanish in `docs/es/`.
