# Empezar

Para reproducir este desensamblado hace falta Python 3 (con Pillow para las
imágenes), GNU make y [Pasmo](https://pasmo.speccy.org/). La imagen del
cartucho **no viaja en este repositorio**: cada cual pone la suya.

```
goemon.rom    131.072 bytes
sha256        a436addc241d977ba38081463322e7e611d6bab4d10cd06305fe5a71f02a549c
```

Con el fichero en la raíz del repositorio:

```
make            # listado, verificación, coherencia y tests
```

## Qué hace cada paso

| orden | qué hace |
|---|---|
| `make comprueba` | comprueba el sha256 de la ROM |
| `make reconoce` | la cabecera y las 49 escrituras al mapper, con su banco |
| `make listado` | genera los dieciséis `.asm` desde el binario, las notas y las semillas |
| `make verify` | reensambla cada banco y la ROM entera, y compara los sha256 |
| `make sanity` | comprueba que ningún dato se lea como código y que no quede un byte sin asignar |
| `make test` | los tests |
| `make densidad` | cuántas instrucciones llevan comentario, banco a banco |
| `make imagenes` | dibuja los PNG de `docs/imagenes/` desde la ROM |
| `make coteja` | coteja las imágenes con los volcados de openMSX de `work/` |
| `make web` | genera las páginas HTML y comprueba los enlaces |

`make verify` es el que decide: al final tiene que imprimir `OK: la ROM entera
reproducible byte a byte`.

`make coteja` necesita los volcados de openMSX, que no viajan en el
repositorio. Se hacen con los lanzadores de [En el emulador](EN-EL-EMULADOR.md);
el del vecino necesita además las imágenes de Q\*bert y del Game Master.

## Dónde está cada cosa

- `src/goemon_pNN.asm`: el listado, uno por banco. **Se genera**: no se edita
  a mano.
- `src/pNN.notes`: las etiquetas (`L`), los comentarios de línea (`C`), los
  rangos de datos (`D`) y los encabezados de rutina (`B`). Esto **sí** se
  edita.
- `tools/anota.py`: los nombres de las rutinas.
- `src/pNN.entries` y `src/pNN.nocode`: las entradas de cada banco y las tablas
  que no son código, sacadas del trazado del cartucho entero (`make semillas`).
- `tools/`: el trazador, el generador del listado y las herramientas que
  dibujan y cotejan.
- `docs/`: esta web, en inglés en la raíz y en castellano en `docs/es/`.
