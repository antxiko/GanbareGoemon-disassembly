# The cartridge

| | |
|---|---|
| title | *Ganbare Goemon! Karakuri Dōchū* (Konami, 1987) |
| number | RC-748 |
| machine | MSX2 (V9938), SCREEN 5 |
| size | 131,072 bytes: 16 banks of 8 KB |
| mapper | Konami without SCC (Konami4) |
| sound | PSG, three channels |
| sha256 | `a436addc241d977ba38081463322e7e611d6bab4d10cd06305fe5a71f02a549c` |

The header is `AB` with INIT at 0x4097, and the interrupt comes in at 0x4045
through H.TIMI. At 0x4010 there is a second header, `CD`, which is the one the
Game Master looks for.

## The mapper

Bank 0 is **fixed** at 0x4000-0x5FFF. The other three slots are chosen by
writing the bank number to 0x6000, 0x8000 and 0xA000. There is not a single
write to 0x5000, 0x7000, 0x9000 or 0xB000, the registers of the SCC mapper:
that is why it is Konami4.

There are **49 writes** to the mapper (`tools/reconocimiento.py`): 8 to
0x6000, 10 to 0x8000 and 31 to 0xA000. Banks are loaded three at a time by
five routines, p00:4206, 4220, 4238, 4250 and 4268 (1-2-3, 4-5-6, 7-8-9,
10-11-12 and 13-14-15). With that, each bank has its slot and the listing
splits into sixteen modules, each with its own `org`:

| slot | banks |
|---|---|
| 0x4000 (fixed) | 0 |
| 0x6000 | 1, 4, 7, 10, 13 |
| 0x8000 | 2, 5, 8, 11, 14 |
| 0xA000 | 3, 6, 9, 12, 15 |

There is **one exception**: p01:7DEC puts bank 14 at 0xA000 to read the
objects of each cell, and the listing declares it (`tools/paginas.py`). Of the
31 writes to 0xA000, **21 are single ones**: routines that read a table and
change only that slot (to bank 6, 9, 12, 14 or 15). Twenty go back to the
1-2-3 trio when they finish. The other one, p01:7DA1, leaves early if the area
has no special exits: in 14 areas it leaves bank 9 in place until the next
return to the trio, with no visible effect (all 14 match openMSX). The
interrupt calls the sound with banks 10, 11 and 12 (p00:404F) and on the way
out puts them back from their copies in RAM (0xF0F1-0xF0F3).

## What is in each bank

| bank | code | what it holds |
|---|---|---|
| 0 | 6,703 B | start-up, the interrupt, the game states, the data readers (rle, patterns, letters, HMMC, palettes, labels), building and painting the screen, the status bar; the figures' colour lists |
| 1 | 7,439 B | the game: loading the area, the player and his collisions, the pause, the password, the endings; the Game Master and Q\*bert signatures, the demo script |
| 2 | 6,087 B | the figures (creating, moving, their sprites), the interiors and their prices (0x9371), the passages, the end of the stage and its texts |
| 3 | 7,181 B | each figure type, the purchases, the dice, the secret passages, the pause words and the keywords; Konami's mark |
| 4, 5 | — | the characters of the six graphics sets, in rle |
| 6 | — | the links of the 49 areas, the keyboard tables, the title picture |
| 7 | — | the patterns shared by every set and those of the status bar |
| 8 | — | the sprites of the 20 poses of Goemon and Ebisumaru |
| 9 | — | the exits of each area, the secret passages (0xA575 and 0xA86D), the palettes, the figure poses, each area's graphics set (0xB8EC) and the money of each type (0xB86D) |
| 10 | 1,314 B | the **sound**: 28 tunes and 32 effects, and the routine that plays them |
| 11 | — | figure patterns, the 9 instruments and the end of a score from bank 10 |
| 12 | — | 114 labels (0xA9C0), the figure (0xA830) and pose records, the ending sentences (0xBCD3) |
| 13 | — | the grids of the 49 areas, the screens and the blocks of each set |
| 14 | — | which figures appear in each cell (0x9BF0), the objects of each cell (0x981D), more blocks |
| 15 | — | the fixed objects (0xA08E), the passages of each area, the texts after clearing an area (0xBC16) |

In all, **28,724 bytes of code and 102,348 of data**: 100 % of the cartridge
accounted for (`make sanity`).

## The VRAM

The game runs in **SCREEN 5** (p00:4994), with 16 colours out of a palette of
512.

- **Page 1** is the store: each area uploads its 8 × 8, 4-bit characters
  there, and character k sits at x = (k % 32) × 8, y = (k / 32) × 8
  (p00:4976).
- **Page 0** is the screen. The cell is built at 0xD800 and painted from line
  0x20, one HMMM per character (p00:534E). The fixed objects are copied on
  top with LMMM and transparency (p02:90C0).

Sprites are **mode 2** (16 × 16, colour per line). Their patterns go to
0xF800. The table and the colours are rebuilt in RAM (0xEE00 and 0xEC80) and
p01:685F copies them on odd frames. That is why a dump can catch the copy from
one frame earlier, and the comparisons allow for it.

## The RAM that matters

| address | what it is |
|---|---|
| 0xC000 / 0xC001 | the game state and its step |
| 0xC002 | game flags (bit 7 player 2, bit 6 playing) |
| 0xC00B / 0xC00C | F1-F3 just pressed |
| 0xC257 | the score (BCD) |
| 0xC260 | the lives |
| 0xC265-0xC266 | the money, in BCD |
| 0xC270-0xC27D | the status-bar items |
| 0xC27F | continue allowed |
| 0xC280 / 0xC281 / 0xC288 | the area, the cell and the stage |
| 0xC289 | the area's graphics set |
| 0xC480 / 0xC481 | maximum life and life |
| 0xC4B0 | the timer (BCD) |
| 0xC600 | the 8 figures, 0x80 bytes each |
| 0xCDB1 | inside a secret passage |
| 0xEF00 | 0xFF if the neighbour is there |
| 0xEF80 | the secrets: bits 0-1 the words, 2-5 the keywords, 6 the menu |
