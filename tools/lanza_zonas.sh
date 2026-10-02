#!/bin/sh
# lanza_zonas.sh <dir> "<zonas>": las zonas forzadas una tras otra (tools/omsx_zonas.tcl). UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/${1:-v_zonas}
mkdir -p $d
cd $R && GO_OUT="$d" GO_ZONAS="${2:-0}" timeout 700 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_zonas.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
