#!/bin/sh
R=$(cd "$(dirname "$0")/.." && pwd)
mkdir -p $R/work/v_konami
cd $R && GO_OUT=$R/work/v_konami timeout 60 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_konami.tcl > $R/work/v_konami/stdout.txt 2>&1
