# The code

## Everything runs in the interrupt

INIT (0x4097) clears the game RAM (0xC000-0xF0EF), looks for the neighbour in
the other slots (p01:7EAB), switches to SCREEN 5 and hooks H.TIMI. From then
on the main program sits in a `jr` to itself (p00:40E5), and the whole game
runs in **p00:4045**, once per frame:

1. If the neighbour is there, first the STOP pause (p00:40E7, 0xEF01).
2. The sound, with banks 10, 11 and 12 in place (p10:6000). Then the game's
   banks come back from 0xF0F1-0xF0F3.
3. If the previous frame has finished (the semaphore at 0xC005), the **state
   machine** (p00:5DBB). Interrupts are enabled before it, so the sound does
   not wait for the game.

## The dispatcher

p00:408D is Konami's dispatcher: the table of destinations sits **right after
the `call`**. It pops the return address, which is the base of the table, and
jumps to destination number A. The listing marks each of those tables as data
and names their destinations.

## The game states

0xC000 is the state and 0xC001 its step (table at 0x5DCF):

| state | what it is |
|---|---|
| 0 | the Konami logo and the title |
| 1 | the title menu |
| 2 | the demo |
| 3 | the game starts |
| 4 | entering the area |
| 5 | playing |
| 6 | a life is lost |
| 7 | out of lives: continue or game over |
| 8 | area cleared: time to points and the next area |
| 9 | leaving the cell |
| 0x0A | the pause |
| 0x0B | stage cleared |
| 0x0C | the neighbour's menu |
| 0x0D | F2 in the pause: the password |
| 0x0E | the password screen |
| 0x0F | the end of the game |

In states 0 to 2, any key leads to the title (p01:62FE).

## The player

p01:6D38 runs the player for one frame: it reads the controls and dispatches
on his state (0xC490, table at 0x6D4C), where 0 is on the ground, 1 jumping
and 2 dying. The controls go to 0xC006/0xC007 and F1-F3 to 0xC00B/0xC00C
(p00:49D2). p01:781F says whether the player can stand somewhere: it returns
carry if he **cannot**.

## One cell

On entering a cell, p01:66F6 does, in order:

1. its links and its special exits;
2. clears the figures;
3. builds the screen at 0xD800 (p00:51ED) and paints it (p00:534E);
4. on top, the fixed objects (p02:90C0);
5. puts the player at the entry point;
6. uploads the patterns of the cell's figures (p00:5413);
7. paints the status bar and sets the colours.

## The figures

There are 8 figures at 0xC600, 0x80 bytes each: type (ix+0), step (ix+1), y
(ix+3), x (ix+5), pose (ix+0x0A)… p02:8334 creates one in the first free
slot. Each type has two entries in its tables: the start-up one (p02:8427) and
the per-frame one (p02:871C), which in turn dispatches on the figure's step.
Its sprites come from the pose (0xB6D2) and its colours from the lists at
0x554E.

## The secret passages

p00:5969 builds the area's passage at 0xD800, one byte per cell and 28 per
row, from a grid of bits (1 wall, 0 path) with some marks on top (p00:5A10).
While inside, 0xCDB1 is not zero, and each frame goes to p02:9881: walking
(p03:B8C3), picking up whatever is there (p03:BC5C), the map (p03:BAF1) or the
exit (p03:BD06).

## The sound

It all lives in bank 10, and the interrupt calls it every frame. There are
**28 tunes** (0x6592, six bytes each: one pointer per PSG channel) and **32
effects** (0x6550). p10:61F1 reads the scores: notes, rests, tempo, octave,
jumps and commands 0xD0-0xFF (p10:6341). The pitch of each note comes from the
lowest octave (0x6303). The 9 instruments and the end of one score are in
bank 11. There is a half-made tune 0x9C, whose first pointer is the silence,
and right behind it effect 0x20 already begins (0x663A).

## How the listing is made

- `tools/bancos.py` traces **the whole cartridge** keeping track of which bank
  is in each slot. From that come the calls that cross the mapper
  (`src/pNN.entries`) and the dispatcher tables (`src/pNN.nocode`).
- `tools/z80trace.py` follows the flow of each bank from those entries.
- `tools/bloques.py` declares the data by walking it as the bank 0 readers do
  (rle, patterns, letters, HMMC, palettes, labels).
- `src/pNN.notes` keeps the labels, comments and data ranges, anchored to
  addresses. `tools/mkasm.py` merges them with the trace and writes
  `src/goemon_pNN.asm`.
- `make verify` reassembles the sixteen banks with Pasmo and the whole ROM,
  and compares the sha256.
- `make sanity` checks that no data is read as code and that not a single
  byte is left unassigned.

Density: **42.5%** of the 14,355 instructions carry a comment, and all 1,678
routines are above 10 % (`make densidad`).
