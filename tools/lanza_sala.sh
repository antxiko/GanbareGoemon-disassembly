#!/bin/sh
# lanza_sala.sh: la sala del senor de la fase 1 grabada en openMSX con
# tools/omsx_sala.tcl (sprites de cada cuadro, VRAM cada 30, los ld a,r) a
# work/v_sala, para tools/sala.py. UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/v_sala
mkdir -p $d
cd $R && GO_OUT=$d GO_FASE=0 timeout 600 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_sala.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
