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
	push ebx
	push ecx
	mov ecx, 0
push4Bit:
	mov ebx, eax
	and ebx, 0x0000000f
	push ebx
	ror eax, 4
	inc ecx
	cmp ecx, 8
	jl push4Bit
pop4BitAndPrint:
	pop eax,
	call write_hex_digit
	loop pop4BitAndPrint
	pop ecx
	pop ebx
	ret
	
