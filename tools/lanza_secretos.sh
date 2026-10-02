#!/bin/sh
# lanza_secretos.sh: los secretos de tools/omsx_secretos.tcl en UNA partida. UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/v_secretos
mkdir -p $d
cd $R && GO_OUT="$d" timeout 450 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_secretos.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
