#!/bin/sh
# lanza_interiores.sh <dir> "<interiores>" [tiempo]: los interiores uno tras otro (tools/omsx_interiores.tcl). UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/${1:-v_interiores}
mkdir -p $d
cd $R && GO_OUT="$d" GO_INTERIORES="${2:-0}" GO_TIEMPO="${3:-}" timeout 700 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_interiores.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
