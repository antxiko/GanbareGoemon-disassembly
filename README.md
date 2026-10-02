# Ganbare Goemon! — a commented disassembly

*(También disponible [en castellano](README.es.md).)*

A commented disassembly of ***Ganbare Goemon! Karakuri Dōchū***, Konami, 1987,
cartridge **RC-748** for the **MSX2**: a 128 KB MegaROM with Konami's mapper
without SCC, sixteen 8 KB banks.

**The website**: https://antxiko.github.io/GanbareGoemon-disassembly/

| | |
|---|---|
| explained | 100% (28,724 bytes of code, 102,348 of data) |
| commented | 42.5% of the instructions |
| routines | 1,678, none below 10% |
| reassembly | the ROM, byte for byte |
| pictures | drawn from the ROM and checked against openMSX |

## What is here

- The listing of the sixteen banks (`src/goemon_pNN.asm`), generated from the
  binary and the notes, which reassembles the exact ROM.
- The 49 areas of the seven stages, street by street, built from the
  cartridge's tables; the 21 interiors with their prices; the 42 secret
  passages.
- Goemon, Ebisumaru and the 30 enemy types, built from their tables.
- Six comparisons against openMSX dumps (`make coteja`).

## How to reproduce it

You need Python 3 (with Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
and **your own cartridge image** as `goemon.rom` at the root:

```
sha256  a436addc241d977ba38081463322e7e611d6bab4d10cd06305fe5a71f02a549c
make
```

The details, in [Getting started](docs/GETTING-STARTED.md).

## Notice

The game belongs to Konami; only the analysis, the comments and the tools are
here. The ROM is not distributed. See [LEGAL-NOTICE.md](LEGAL-NOTICE.md).
