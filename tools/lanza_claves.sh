#!/bin/sh
R=/c/Users/Antxiko/Documents/DES_ASM/GOEMON_DISAM
mkdir -p $R/work/v_claves
cd $R && GO_OUT=$R/work/v_claves timeout 320 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_claves.tcl > $R/work/v_claves/stdout.txt 2>&1
