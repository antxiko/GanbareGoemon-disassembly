# En el emulador

Todo lo que se dibuja en esta web está cotejado contra **openMSX** con una
máquina MSX2 japonesa (`C-BIOS_MSX2_JP`). Las sondas son guiones Tcl que
llevan el cartucho adonde hace falta, tocando la RAM o pulsando teclas de
verdad, y vuelcan la VRAM entera (128 KB), la paleta y la RAM. Se lanza un
emulador cada vez.

## Las sondas

| sonda | qué hace | lanzador | volcados |
|---|---|---|---|
| `omsx_konami.tcl` | el logotipo de Konami, al acabar su barrido | `lanza_konami.sh` | 1 |
| `omsx_vuelca.tcl` | la demo, en cada cambio de casilla o de estado | `lanza_vuelca.sh` | — |
| `omsx_zonas.tcl` | la entrada de cada zona | `lanza_zonas.sh` | 49 |
| `omsx_interiores.tcl` | los 21 interiores, cerrados y abiertos | `lanza_interiores.sh` | 21 + 8 |
| `omsx_vecino.tcl` | el título con Q\*bert y con el Game Master en la ranura B | `lanza_vecino.sh` | 2 |
| `omsx_claves.tcl` | las cuatro claves de la contraseña | `lanza_claves.sh` | 4 |
| `omsx_secretos.tcl` | el menú, las palabras de la pausa, F2, F5 y el dinero al morir | `lanza_secretos.sh` | 1 partida |
| `omsx_pasadizos.tcl` | los 42 pasadizos secretos, la vista y el mapa | `lanza_pasadizos.sh` | 84 |
| `omsx_entrada_pasadizo.tcl` | entrar en el pasadizo pagando en el interior 16 | `lanza_entrada_pasadizo.sh` | 1 |

Para forzar una zona, `omsx_zonas.tcl` pone la fase en 0xC288, la zona en
0xC280 y 0xC268 a 0, y vuelve al estado 4, paso 1: el juego carga la zona como
al entrar por su camino.

## Los cotejos

`make coteja` compara lo dibujado desde la ROM con los volcados. Resultado
actual:

| prueba | qué compara | resultado |
|---|---|---|
| `coteja.py` | las 49 entradas de zona: 0xD800, la pantalla, los caracteres de la página 1 y la paleta | 49 volcados, 0 distintos |
| `titulo.py` | el logotipo, el título y el menú del vecino | 0 puntos distintos |
| `figuras.py` | la pose de Goemon en cada volcado: dibujos, sprites y colores | 49 volcados, 0 distintos |
| `enemigos.py` | cada figura de los volcados y las listas de cada casilla | 107 figuras y 49 listas, 0 distintas |
| `interiores.py` | los 21 interiores, la página 0 entera | 0 bytes distintos |
| `pasadizos.py` | los 42 pasadizos: la rejilla de 0xD800, el mapa y la paleta | 42, 0 distintos |

## Trucos para verlo

- La fase va en 0xC288 (0-6), la zona en 0xC280 (0-6) y la casilla en 0xC281.
- Para entrar en un interior: su número con el bit 7 en 0xC500, 0xC482 = 1 y
  0xC283 = 5.
- En los menús de las tiendas, el primer botón (espacio) cambia de opción y el
  segundo (CTRL) elige.
- Con Q\*bert o el Game Master en otra ranura, STOP pone la pausa del vecino
  (p00:40E7).
- Las palabras de la pausa se teclean por su sitio en la matriz del teclado
  (tabla del banco 6, 0xADEC).
