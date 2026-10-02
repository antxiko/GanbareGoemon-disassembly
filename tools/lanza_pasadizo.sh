#!/bin/sh
# lanza_pasadizo.sh: la pantalla de p00:5969 (tools/omsx_pasadizo.tcl). UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/v_pasadizo
mkdir -p $d
cd $R && GO_OUT="$d" timeout 150 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_pasadizo.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
