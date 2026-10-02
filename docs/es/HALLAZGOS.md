# Hallazgos

Lo que apareció al desmontar el cartucho. Cada cosa lleva la dirección donde
se puede comprobar y dice si se ha visto en openMSX o solo se ha leído en el
código.

## Con Q\*bert o el Game Master al lado, un menú para elegir fase

Al arrancar, p01:7EAB mira la otra ranura. Si encuentra Q\*bert o el Game
Master, pone 0xEF00 a 0xFF y el título saca un menú más (p01:7F1A) para elegir
la fase y las vidas. Comprobado en openMSX con los dos cartuchos; el menú está
dibujado desde la ROM y coincide con el volcado sin un solo punto distinto.

## Cuatro claves en la pantalla de la contraseña

p03:BE4E compara lo tecleado con cuatro textos de 9 letras (0xBE8A):

| Clave | Lo que hace |
|---|---|
| くるくるてんてん | juega el jugador 2 |
| きみちやんげんき | vida máxima 0x20 en vez de 0x10 |
| あけみさんのさいふ | 2000 ryo |
| つづきがしたい | se puede continuar |

Las cuatro comprobadas en openMSX. Uno de los consejos del propio juego (el
texto 32: «かくしこまんど きみちゃんげんき») ya da la segunda.

## Dos palabras en la pausa

En la pausa (F1) se pueden teclear 5 letras (p03:BDF6). Cada tecla da una
letra según la tabla del banco 6 (0xADEC, u 0xAE34 con el teclado en kana).

- **おやぶん** dentro de un pasadizo secreto pone el bit 0 de 0xEF80 y da su
  mapa (0xC27A).
- **すきやねん** fuera pone el bit 1. Con él, tocar a los tipos 8 y 0x21 da 10
  ryo además de los 1000 puntos (p01:79D1).

Comprobado en openMSX tecleándolas: los dos bits y 0xC27A (el pasadizo,
forzado en la RAM). Los 10 ryo están leídos en el código.

## Cambiar de opción seis veces en el título

p01:634F cuenta en 0xEF81 las veces que se cambia la opción del menú. Si al
empezar son 6 o 7, p00:5EB6 pone el bit 6 de 0xEF80 (p03:BEDD). Comprobado en
openMSX. Lo que hace ese bit está leído en el código: con la cosa 0x0A, el
mapa del pasadizo marca la salida con una flecha (p03:BBCD).

## F2 enseña la contraseña, F5 continúa

- **F2 en la pausa** enseña la contraseña del sitio donde se está (p01:6B5F).
  F2 otra vez la quita, y solo vale una vez por pausa (0xC28C).
- **F5 sin vidas:** si se ha ganado «continuar» (0xC27F), la partida sigue
  (p00:5F8E) con los puntos y el dinero a cero. «Continuar» se gana con la
  clave つづきがしたい o cambiando la cosa 3 en la casa de cambio (p03:B047,
  leído en el código).

F2 y F5 están comprobados en openMSX.

## Al morir, la mitad del dinero

p01:701E divide el dinero entre dos en BCD, cifra a cifra; además se pierden
las cosas 0, 1 y 0x0A (p01:700A). En openMSX, 4800 ryo se quedaron en 2400, y
en la siguiente muerte 2180 se quedaron en 1090.

## Las tiendas abren según el reloj

Los interiores 8 a 15 están cerrados cuando la cifra de las decenas del tiempo
es impar (p03:AD57). Comprobado en openMSX: los ocho, abiertos y cerrados.

## Los bloques dan 50 ryo si el tiempo acaba en 11, 33, 55, 77 o 99

p02:8D95: 5 ryo, o 50 si las dos últimas cifras del tiempo son iguales e
impares. Leído en el código.

## Los dados: el doble o la mitad

En el interior 17 se apuesta a par o impar (0xCD8F). Si se acierta, el dinero
se dobla (p03:B233); si no, se queda en la mitad (p03:B247). Leído en el
código.

## Pegar ocho veces al tipo 0x21 cambia el final de la fase

p03:A9D3 cuenta los golpes en 0xCD60. Con 8 o más, el señor de la fase no dice
su texto sino el de 0x9F92 (p02:9BC7): «おぬし わしのせいじにけちをつけるか…»
(«¿Le pones pegas a mi gobierno? … Acuérdate en la próxima fase»). Pasa en
todas las fases menos en la última. Leído en el código.

## Cuatro finales

p01:6546 elige el final según dos cosas: si se han pasado las 7 fases y si
estaba el vecino. Las frases están en 0xBCD3 (banco 12):

- **Sin las 7 fases:** no todos los señores han prometido gobernar bien; hay
  que volver a las provincias.
- **Con las 7:** la paz, y «por cierto, los próximos juegos de Konami son
  ひのとり y まじょうでんせつ2» (Hinotori y Majō Densetsu 2).
- **Con el vecino** se añade: «la próxima vez, haz el *yonaoshi* sin usar el
  cartucho para divertirse diez veces más».

Leído en el código; los textos salen de la ROM.

## Cuatro fallos del código

- **p03:AAFE:** quiere escribir en (ix+0x75) y escribe en 0x0075, que es ROM
  de la BIOS. La cuenta de p03:ABC4 empieza entonces con lo que dejó en ese
  hueco la figura anterior.
- **p03:B4F1:** carga 0x20 en DE para sumar vida, pero p00:5884 suma A, que ahí
  vale 0xD0, así que la vida se llena entera. Es la figura 0x2C del interior
  18.
- **p03:A5BB:** `ld hl,(0xC494)` en lugar de `ld hl,0xC494`. Al decidir si va
  hacia arriba o hacia abajo, la figura compara con un byte casi al azar.
- **p03:ADB4:** si no hay nada a la venta, el `djnz` de p03:ADB2 cae en una
  tabla y la ejecuta como código.

## La cosa 14 no la vende nadie

Tiene precio (0x9371) y rutina (p03:AEB2), pero no está en ninguno de los 21
interiores (0x9567).

## La marca de Konami, en hiragana

Al final del banco 3 está la marca que Konami escondía en sus cartuchos (la
descubrió Manuel Pazos). Aquí no va en katakana con el código de la casa,
sino en la fuente del propio juego: がんばれごえもん, y detrás 0x48, el RC-748.
