#!/bin/sh
# lanza_final.sh: el final 1 (0xC26A = 7, sin vecino) por su camino (tools/omsx_final.tcl). UN openMSX cada vez.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/v_final
mkdir -p $d
cd $R && GO_OUT=$d GO_C26A=7 timeout 180 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_final.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
