#!/bin/sh
# lanza_pasadizos.sh: los 42 pasadizos secretos, vista y mapa (tools/omsx_pasadizos.tcl). UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/v_pasadizos
mkdir -p $d
cd $R && GO_OUT="$d" GO_ZONAS="0 1 2 3 4 6 7 8 9 10 11 13 14 15 16 17 18 20 21 22 23 24 25 27 28 29 30 31 32 34 35 36 37 38 39 41 42 43 44 45 46 48" timeout 1000 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_pasadizos.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
