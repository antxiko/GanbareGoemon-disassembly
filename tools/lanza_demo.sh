#!/bin/sh
# lanza_demo.sh: el cartucho solo, sin tocar nada (tools/omsx_demo.tcl), en work/demo.
R=$(cd "$(dirname "$0")/.." && pwd)
cd $R && GO_OUT="$R/work/demo" timeout 200 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart goemon.rom -script tools/omsx_demo.tcl > work/demo/stdout.txt 2>&1
echo hecho > work/demo/fin.txt
