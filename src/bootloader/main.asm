;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                 ;;
;;  AmarinOS bootloader v0.0.1                                     ;;
;;                                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format Binary as "bin"

org 0x7C00
	jmp boot

boot:
	jmp 0xffff:0

; Mark first sector as boot sector
rb 0x200 - ($ - $$) - 2
db 0x55, 0xAA

