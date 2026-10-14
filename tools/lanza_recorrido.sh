#!/bin/sh
# lanza_recorrido.sh <zona>: el recorrido de tools/vistas.py (sin el paso de
# salir) andado en openMSX con tools/omsx_recorrido.tcl. UN openMSX cada vez.
R=$(cd "$(dirname "$0")/.." && pwd)
z=${1:-0}
d=$R/work/v_recorrido/z$z
rm -rf $d
mkdir -p $d
pasos=$(cd $R && ${PYIMG:-python} tools/vistas.py pasos $z)
cd $R && GO_OUT=$d GO_ZONA=$z GO_PASOS=$pasos timeout 300 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_recorrido.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
