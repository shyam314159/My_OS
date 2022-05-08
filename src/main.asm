org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
	jmp main


puts:
	push si         ; save registers we will modify
	push ax

.loop:
	lodsb           ; loads next char from si to al and increment pointer si
	or al, al
	jz .done

	mov ah, 0x0e    ; prints chars in TTY mode
	int 0x10        ; BIOS interupt for video related actions

	jmp .loop

.done:
	pop ax
	pop si
	ret

main:
	mov ax, 0
	mov ds, ax
	mov es, ax

	mov ss, ax
	mov sp, 0x7C00

	mov si, msg_hello
	call puts

	hlt

.halt:
	jmp .halt

msg_hello: db 'Hello world...!', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h
