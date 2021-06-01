%macro writeStr 2
	push	eax
	push	ebx
	push	ecx
	push	edx
	mov		edx,%2
	mov		ecx,%1
	mov		ebx,1
	mov		eax,4
	int		0x80
	pop		edx
	pop		ecx
	pop		ebx
	pop		eax
%endmacro
section .data
	hexchar	db '0123456789ABCDEF'
	cMem	db 0

	global space
	global newline
	global write_char
	global write_str
	global write_hex_digit
	global write_hex
	global write_bin
	global write_dec
	global	write_hex_byte
	global  write_hex_dword
    global  write_byte_low1
    global  write_byte_high1
section .text


space:
	push eax
	mov al,0x20
	call write_char
	pop eax
	ret
newline:
	push eax
	mov al,10
	call write_char
	pop eax
	ret
write_char:
	; input al
	mov byte[cMem],al
	writeStr cMem,1
;	mov byte[cMem],al
;	push cMem
;	push 1
;	call write_str
;	add  esp,8
	ret
write_str:
	; strAddr [ebp+12]
	; strLen [ebp+8]
	push ebp
	mov  ebp,esp
	writeStr [ebp+12],[ebp+8]
	leave
	ret 
write_hex_digit:
	; input al
	push ebx
	mov  ebx,hexchar	
	xlat
	call write_char
	pop  ebx
	ret
write_hex:
	; input al
	push ebx
	mov  bl,al 
	shr  al,4
	call write_hex_digit
	mov  al,bl
	and  al,0x0f
	call write_hex_digit
	pop  ebx
; --
;   push ebx
;	xor ah,ah
;	mov bl,16
;	div bl
;	call write_hex_digit
;	mov al,ah
;	call write_hex_digit
;	pop ebx
	ret	
write_bin:
	; input al

	ret
write_dec:
	; input ax

	ret

write_hex_byte:
    push ax
    mov ah,al
    and al,0F0h
    rol al,4
    cmp al,0Ah
    jb write_byte_low1
    add al,7
    ret

write_byte_low1:
    add al,'0'
    call write_char
    mov al,ah
    and al,0Fh
    cmp al,0Ah
    jb write_byte_high1
    add al,7
    ret

write_byte_high1:
    add al,'0'
    call write_char
    pop ax
    ret

write_hex_dword:
    push eax
    rol eax,8
    call write_hex_byte
    rol eax,8
    call write_hex_byte
    rol eax,8
    call write_hex_byte
    rol eax,8
    call write_hex_byte
    pop eax
    ret