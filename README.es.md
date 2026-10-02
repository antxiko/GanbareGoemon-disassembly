# Ganbare Goemon! — desensamblado comentado

*(Also available [in English](README.md).)*

Desensamblado comentado de ***Ganbare Goemon! Karakuri Dōchū***, Konami, 1987,
cartucho **RC-748** para **MSX2**: un MegaROM de 128 KB con el mapper Konami
sin SCC, dieciséis bancos de 8 KB.

**La web**: https://antxiko.github.io/GanbareGoemon-disassembly/es/

| | |
|---|---|
| explicado | 100 % (28.724 bytes de código, 102.348 de datos) |
| comentado | 42,5 % de las instrucciones |
| rutinas | 1.678, ninguna por debajo del 10 % |
| reensamblado | la ROM, byte a byte |
| imágenes | dibujadas desde la ROM y cotejadas contra openMSX |

## Qué hay

- El listado de los dieciséis bancos (`src/goemon_pNN.asm`), que se genera
  desde el binario y las notas y reensambla la ROM exacta.
- Las 49 zonas de las siete fases, calle a calle, montadas desde las tablas
  del cartucho; los 21 interiores con sus precios; los 42 pasadizos secretos.
- Goemon, Ebisumaru y los 30 tipos de enemigo, compuestos desde sus tablas.
- Seis cotejos contra volcados de openMSX (`make coteja`).

## Cómo reproducirlo

Hace falta Python 3 (con Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
y **tu propia imagen del cartucho** como `goemon.rom` en la raíz:

```
sha256  a436addc241d977ba38081463322e7e611d6bab4d10cd06305fe5a71f02a549c
make
```

Los detalles, en [Empezar](docs/es/EMPEZAR.md).

## Aviso

El juego es de Konami; aquí solo están el análisis, los comentarios y las
herramientas. La ROM no se distribuye. Ver [AVISO-LEGAL.md](AVISO-LEGAL.md).
