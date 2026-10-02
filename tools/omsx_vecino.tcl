# omsx_vecino.tcl - con otro cartucho en la ranura B (Q*bert o el Game
# Master), pulsa ESPACIO en el titulo, espera al estado 0x0C (p00:5E8D, el menu "senkaku") y hace una foto
# y un volcado de la VRAM; apunta 0xEF00 (p01:7EC8: 0xFF si encontro la marca).
#   GO_OUT=<dir> GO_NOMBRE=<n> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -cartb otro.rom -script este.tcl
set OUT $::env(GO_OUT)
set NOMBRE $::env(GO_NOMBRE)
file mkdir $OUT
set LOG [open "$OUT/$NOMBRE.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
set ::visto 0
proc mira {} {
    global OUT NOMBRE
    set e [debug read memory 0xC000]
    if {$e == 1 && !$::visto} {
        keymatrixdown 8 0x01
        after time 0.1 { keymatrixup 8 0x01 }
    }
    if {$e == 12 && !$::visto} {
        set ::visto 1
        after time 1.5 {
            screenshot -raw "$OUT/$NOMBRE.png"
            set f [open "$OUT/$NOMBRE.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
            say "estado 0x0C  EF00=[format %02X [debug read memory 0xEF00]]"
            exit 0
        }
    }
    after time 0.2 mira
}
after time 1 mira
after time 40 { say "no llego al estado 0x0C  C000=[debug read memory 0xC000] EF00=[format %02X [debug read memory 0xEF00]]" ; exit 1 }
