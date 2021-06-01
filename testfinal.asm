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
	label1	db 'X: '
	label2	db 'Y: '
	label3	db 'EBP: '
	label4	db 'RET: '
	label5	db 'argc: '
	label6	db 'argv: '
	cMem	db 0
	
section .text
	global func1
func1:
	push ebp
	mov ebp,esp
	
	writeStr label1, 3
	lea eax, [esp + 28]
	call write_dword_hex
	call write_space
	mov eax, [esp + 28]
	call write_dword_hex
	call write_new_line
	
	writeStr label2, 3
	lea eax, [esp + 32]
	call write_dword_hex
	call write_space
	mov eax, [esp + 32]
	call write_dword_hex
	call write_new_line
	
	
	writeStr label3, 5
	lea eax, [esp + 80]
	call write_dword_hex
	call write_space
	mov eax, [esp + 80]
	call write_dword_hex
	call write_new_line
	
	writeStr label4, 5
	lea eax, [esp + 84]
	call write_dword_hex
	call write_space
	mov eax, [esp + 84]
	call write_dword_hex
	call write_new_line
	
	writeStr label5, 6
	lea eax, [esp + 88]
	call write_dword_hex
	call write_space
	mov eax, [esp + 88]
	call write_dword_hex
	call write_new_line
	
	writeStr label6, 6
	lea eax, [esp + 92]
	call write_dword_hex
	call write_space
	mov eax, [esp + 92]
	call write_dword_hex
	call write_new_line
	
	
	leave
	ret
	
write_space:
	push eax
	mov al, 32
	mov [cMem], al
	writeStr cMem, 1
	pop eax
	ret
	
write_new_line:
	push eax
	mov al, 0xd
	mov [cMem], al
	writeStr cMem, 1
	mov al, 0xa
	mov [cMem], al
	writeStr cMem, 1
	pop eax
	ret

write_dword_hex:
	; input eax
	push ecx
	push edx
	mov ecx, 8
.digit_loop:
	rol eax, 4
	mov edx, eax
	and edx, 0x0f
	movzx edx, byte [hexchar + edx]
	mov [cMem], dl
	writeStr cMem, 1
	loop .digit_loop
	pop edx
	pop ecx
	ret