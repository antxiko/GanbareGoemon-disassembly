#!/bin/sh
# lanza_vuelca.sh <dir>: la demo volcada en cada cambio de casilla (tools/omsx_vuelca.tcl). UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/${1:-v_demo}
mkdir -p $d
cd $R && GO_OUT="$d" timeout 200 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_vuelca.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
