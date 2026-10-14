#!/bin/sh
# lanza_mapa.sh: el plano de cada fase (estado 4, paso 0) en openMSX con
# tools/omsx_mapa.tcl, la fase f con la marca en la zona f (la fase 6 con la
# zona 4: solo para variar el sitio de la marca). Un openMSX cada vez; los
# volcados, en work/v_mapa/fNN.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/v_mapa
mkdir -p $d
for f in 0 1 2 3 4 5 6; do
    z=$f; [ $z = 5 ] && z=4
    k=$((f * 7 + z))
    cd $R && GO_OUT=$d/tmp GO_ZONA=$k GO_T="0.3" timeout 300 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_mapa.tcl > $d/stdout_$f.txt 2>&1
    for e in vram ram pal png; do mv $d/tmp/p0_3.$e $d/f0$f.$e; done
    cat $d/tmp/mapa.log >> $d/mapa.log
done
echo hecho > $d/fin.txt
