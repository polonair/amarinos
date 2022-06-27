org 0x7C00
	jmp word boot
label disk_id byte at $$
boot_msg db "AmarinOs Bootloader v0.0.0",13,10,0
reboot_msg db "Press any key...",13,10,0
; print string DS:SI
write_str:
	push ax si
	mov ah, 0x0E
 @@:
	lodsb
	test al, al
	jz @f
	int 0x10
	jmp @b
 @@:
	pop si ax
	ret

error:
	pop si
	call write_str

reboot:
	mov si, reboot_msg
	call write_str
	xor ah, ah
	int 0x16
	jmp 0xFFFF:0

boot:
	; setup segment registers
	jmp 0:@f
 @@:
	mov ax, cs
	mov ds, ax
	mov es, ax
	; setup stack
	mov ss, ax
	mov sp, $$
	; enable interrupts
	sti
	; save disk id
	mov [disk_id], dl
	; print boot_msg
	mov si, boot_msg	
	call write_str
	; reboot
	jmp reboot
; rest
rb 0x200 - ($ - $$) - 2
db 0x55,0xAA

