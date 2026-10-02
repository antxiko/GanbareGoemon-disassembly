#!/bin/sh
# lanza_vecino.sh: Goemon con Q*bert en la ranura B y luego con el Game Master (tools/omsx_vecino.tcl). UN openMSX cada vez.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/v_vecino2
mkdir -p $d
ROMS=$R/../ROMS
cd $R && GO_OUT=$d GO_NOMBRE=qbert timeout 60 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -cartb work/qbert.rom -script tools/omsx_vecino.tcl > $d/stdout_qbert.txt 2>&1
cd $R && GO_OUT=$d GO_NOMBRE=gamemaster timeout 60 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -cartb work/gamemaster.rom -script tools/omsx_vecino.tcl > $d/stdout_gm.txt 2>&1
echo hecho > $d/fin.txt
