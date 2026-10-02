# Findings

What turned up while taking the cartridge apart. Each item gives the address
where it can be checked and says whether it was seen in openMSX or only read
in the code.

## With Q\*bert or the Game Master next to it, a menu to pick the stage

At start-up, p01:7EAB looks at the other slot. If it finds Q\*bert or the Game
Master, it sets 0xEF00 to 0xFF and the title screen shows an extra menu
(p01:7F1A) to choose the stage and the lives. Checked in openMSX with both
cartridges; the menu is drawn from the ROM and matches the dump with not a
single pixel different.

## Four keywords on the password screen

p03:BE4E compares what was typed with four 9-letter texts (0xBE8A):

| Keyword | What it does |
|---|---|
| くるくるてんてん | player 2 plays |
| きみちやんげんき | maximum life 0x20 instead of 0x10 |
| あけみさんのさいふ | 2000 ryo |
| つづきがしたい | continue is allowed |

All four checked in openMSX. One of the game's own hints (text 32:
«かくしこまんど きみちゃんげんき») already gives away the second one.

## Two words in the pause

During the pause (F1) five letters can be typed (p03:BDF6). Each key gives a
letter from the table in bank 6 (0xADEC, or 0xAE34 with the keyboard in kana
mode).

- **おやぶん** inside a secret passage sets bit 0 of 0xEF80 and gives its
  map (0xC27A).
- **すきやねん** outside it sets bit 1. With it, touching types 8 and 0x21
  gives 10 ryo on top of the 1000 points (p01:79D1).

Checked in openMSX by typing them: both bits and 0xC27A (the passage forced in
RAM). The 10 ryo are read in the code.

## Changing the option six times on the title screen

p01:634F counts in 0xEF81 how many times the menu option is changed. If it is
6 or 7 when the game starts, p00:5EB6 sets bit 6 of 0xEF80 (p03:BEDD). Checked
in openMSX. What that bit does is read in the code: with item 0x0A, the passage
map marks the exit with an arrow (p03:BBCD).

## F2 shows the password, F5 continues

- **F2 in the pause** shows the password for the current place (p01:6B5F).
  F2 again removes it, and it only works once per pause (0xC28C).
- **F5 out of lives:** if "continue" has been earned (0xC27F), the game
  carries on (p00:5F8E) with score and money set to zero. "Continue" is
  earned with the keyword つづきがしたい or by exchanging item 3 at the
  exchange house (p03:B047, read in the code).

F2 and F5 are checked in openMSX.

## Dying halves the money

p01:701E divides the money by two in BCD, digit by digit; items 0, 1 and 0x0A
are lost as well (p01:700A). In openMSX, 4800 ryo became 2400, and on the next
death 2180 became 1090.

## The shops open by the clock

Interiors 8 to 15 are closed when the tens digit of the timer is odd
(p03:AD57). Checked in openMSX: all eight, open and closed.

## Blocks give 50 ryo if the timer ends in 11, 33, 55, 77 or 99

p02:8D95: 5 ryo, or 50 if the last two digits of the timer are equal and odd.
Read in the code.

## The dice: double or half

In interior 17 you bet on even or odd (0xCD8F). Guess right and the money
doubles (p03:B233); guess wrong and it is halved (p03:B247). Read in the code.

## Hitting type 0x21 eight times changes the end of the stage

p03:A9D3 counts the hits in 0xCD60. With 8 or more, the stage's lord does not
say his own text but the one at 0x9F92 (p02:9BC7):
«おぬし わしのせいじにけちをつけるか…» ("You dare find fault with my rule? …
Remember this in the next stage"). It happens in every stage but the last.
Read in the code.

## Four endings

p01:6546 picks the ending from two things: whether all 7 stages have been
played and whether the neighbour cartridge was there. The sentences are at
0xBCD3 (bank 12):

- **Without the 7 stages:** not every lord has promised to rule well; go back
  to the provinces.
- **With the 7:** peace, and "by the way, Konami's next games are ひのとり and
  まじょうでんせつ2" (Hinotori and Majō Densetsu 2).
- **With the neighbour**, it adds: "next time, do the *yonaoshi* without
  using the cartridge for ten times the fun".

Read in the code; the texts come from the ROM.

## Four bugs in the code

- **p03:AAFE:** it means to write to (ix+0x75) and writes to 0x0075, which is
  BIOS ROM. The count at p03:ABC4 then starts with whatever the previous
  figure left in that slot.
- **p03:B4F1:** it loads 0x20 into DE to add life, but p00:5884 adds A, which
  is 0xD0 at that point, so life is filled completely. It is figure 0x2C in
  interior 18.
- **p03:A5BB:** `ld hl,(0xC494)` instead of `ld hl,0xC494`. When deciding
  whether to go up or down, the figure compares against an almost random
  byte.
- **p03:ADB4:** if nothing is for sale, the `djnz` at p03:ADB2 falls into a
  table and runs it as code.

## Nobody sells item 14

It has a price (0x9371) and a routine (p03:AEB2), but it is in none of the 21
interiors (0x9567).

## Konami's mark, in hiragana

At the end of bank 3 is the mark Konami hid in its cartridges (discovered by
Manuel Pazos). Here it is not in katakana with the house code but in the
game's own font: がんばれごえもん, followed by 0x48, the RC-748.
