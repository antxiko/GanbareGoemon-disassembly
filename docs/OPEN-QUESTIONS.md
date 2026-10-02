# Open questions

What the listing says but has not yet been seen in the emulator, and what is
not known.

## Read in the code, not seen in openMSX

The 10 ryo of すきやねん, "continue" when exchanging item 3, the eight hits on
type 0x21, the 50-ryo blocks, the dice and the four endings. They are all in
[Findings](FINDINGS.md), with their address; none has been tried in play.

## Item 14

It has a price in the table and its routine is the life one (p03:AEB2). That
routine adds B to life: items 11 and 12 set B to 16 and 8 before getting
there, but item 14 jumps straight in with whatever B holds. Since no shop
sells it, how much it would give is unknown.

## Figure 0x1B

It is not in the lists of the cells and nothing has been found that creates
it. Figures 0x12 and 0x1D belong to the end-of-stage scene, but 0x1B is
unknown.

## Tune 0x9C

It has an entry in the table, but its first pointer goes to the silence and
right behind it effect 0x20 already begins (0x663A). Whether anything asks for
it is still unknown.

## The table that gets executed

If a shop has nothing for sale, the `djnz` at p03:ADB2 falls into the table at
p03:ADB4 and runs it as code. What it does then has not been seen.

## The passages of each area

Besides the secret passages, the game has other passages (0xC483, bank 15:
their holes and their pieces). They are in the listing, but have not been
drawn yet.
