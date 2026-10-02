# In the emulator

Everything drawn on this website is checked against **openMSX** with a
Japanese MSX2 machine (`C-BIOS_MSX2_JP`). The probes are Tcl scripts that take
the cartridge wherever it needs to be, by poking RAM or pressing real keys,
and dump the whole VRAM (128 KB), the palette and the RAM. One emulator runs
at a time.

## The probes

| probe | what it does | launcher | dumps |
|---|---|---|---|
| `omsx_konami.tcl` | the Konami logo, when its sweep ends | `lanza_konami.sh` | 1 |
| `omsx_vuelca.tcl` | the demo, at each change of cell or state | `lanza_vuelca.sh` | — |
| `omsx_zonas.tcl` | the entrance of each area | `lanza_zonas.sh` | 49 |
| `omsx_interiores.tcl` | the 21 interiors, closed and open | `lanza_interiores.sh` | 21 + 8 |
| `omsx_vecino.tcl` | the title with Q\*bert and with the Game Master in slot B | `lanza_vecino.sh` | 2 |
| `omsx_claves.tcl` | the four password keywords | `lanza_claves.sh` | 4 |
| `omsx_secretos.tcl` | the menu, the pause words, F2, F5 and the money on dying | `lanza_secretos.sh` | 1 game |
| `omsx_pasadizos.tcl` | the 42 secret passages, the view and the map | `lanza_pasadizos.sh` | 84 |
| `omsx_entrada_pasadizo.tcl` | entering the passage by paying in interior 16 | `lanza_entrada_pasadizo.sh` | 1 |

To force an area, `omsx_zonas.tcl` puts the stage in 0xC288, the area in
0xC280 and 0xC268 to 0, and goes back to state 4, step 1: the game loads the
area as if it had been reached on foot.

## The comparisons

`make coteja` compares what is drawn from the ROM with the dumps. Current
result:

| test | what it compares | result |
|---|---|---|
| `coteja.py` | the 49 area entrances: 0xD800, the screen, the characters on page 1 and the palette | 49 dumps, 0 different |
| `titulo.py` | the logo, the title and the neighbour's menu | 0 pixels different |
| `figuras.py` | Goemon's pose in each dump: patterns, sprites and colours | 49 dumps, 0 different |
| `enemigos.py` | each figure in the dumps and the lists of each cell | 107 figures and 49 lists, 0 different |
| `interiores.py` | the 21 interiors, the whole of page 0 | 0 bytes different |
| `pasadizos.py` | the 42 passages: the grid at 0xD800, the map and the palette | 42, 0 different |

## Tricks to see it

- The stage goes in 0xC288 (0-6), the area in 0xC280 (0-6) and the cell in
  0xC281.
- To enter an interior: its number with bit 7 in 0xC500, 0xC482 = 1 and
  0xC283 = 5.
- In the shop menus, the first button (space) changes the option and the
  second (CTRL) chooses.
- With Q\*bert or the Game Master in another slot, STOP brings up the
  neighbour's pause (p00:40E7).
- The pause words are typed by their place in the keyboard matrix (table in
  bank 6, 0xADEC).
