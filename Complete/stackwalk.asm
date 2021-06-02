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
section	.data
bMem	times 100 db	0
msg1 	db	'_LOCAL_VARS: ',10
len1 	equ	$-msg1
msg2 	db	'_EBP       : ',10
len2 	equ	$-msg2
msg3 	db	'_RET_ADDR  : ',10
len3 	equ	$-msg3
msg4 	db	'_ARG       : ',10
len4 	equ	$-msg4
hexchar	db '0123456789ABCDEF'
cMem	db 0

	extern	write_hex
	extern	space
	extern	newline

section .text
	global	stackwalk
	
stackwalk:
    push	ebp           ; Dua basepointer EBP vao trong Stack Frame
	mov 	ebp, esp      ; Cap nhat lai EBP len vi tri dinh cua Stack
	xor 	ebx,ebx       ; xet ebx =0 -> dung de lam bien chi vi tri trong stack
	add 	ebx, 8        ; ebx = ebx+8 cong gia tri thanh ghi ebx voi 8 va luu ket qua vao lai ebx
    call	newline
	writeStr msg1,len1

_local:
                          ; edx = edx + ebp + ebx
	mov 	edx,ebp 
	add 	edx,ebx       ; cong edx voi ebx va luu vao edx
    cmp 	edx,[ebp]     ; dieu kien lap: so sanh gia tri cua ebp - (dia chi cua ebp stack truoc)
    je 		_ebp 
	lea 	eax, [ebp+ebx]; lay dia chi ebp+ebx luu vao thanh ghi eax
	call 	write_hex     ; in dia chi cua local vars
	call 	space
	mov 	eax, [ebp+ebx]; lay gia tri tai dia chi ebp+ebx luu vao thanh ghi eax
	call 	write_hex     ; in gia tri cua local var
	call 	newline   
	add 	ebx,4         ; cong gia tri thanh ghi ebx voi 4 la luu ket qua vao ebx
    jmp 	_local  
    call 	newline
	
_ebp:
	call 	newline
    writeStr msg2,len2
    lea 	eax, [ebp+ebx];lay dia chi ebp+ebx luu vao thanh ghi eax
    call 	write_hex     ; in dia chi cua EBP
    call 	space
    mov 	eax, [ebp+ebx];lay gia tri tai dia chi ebp+ebx luu vao thanh ghi eax
    call 	write_hex     ; in gia tri cua EBP
    call 	newline
    call 	newline
    add 	ebx,4         ; cong gia tri thanh ghi ebx voi 4 la luu ket qua vao ebx
	writeStr msg3,len3
	
_ret_addr:
    lea 	eax, [ebp+ebx];lay dia chi ebp+ebx luu vao thanh ghi eax
    call 	write_hex
    call 	space
    mov 	eax, [ebp+ebx];lay gia tri tai dia chi ebp+ebx luu vao thanh ghi eax
    call 	write_hex
	add 	ebx,4         ; cong gia tri thanh ghi ebx voi 4 la luu ket qua vao ebx
	call 	newline
	call 	newline
	writeStr msg4,len4
	
_number_of_arg:
	lea 	eax, [ebp+ebx] ; bien chi vi tri toi vi tri arg c
    call 	write_hex
    call 	space
    mov 	eax, [ebp+ebx] ;lay gia tri tai dia chi ebp+ebx luu vao thanh ghi eax
    call 	write_hex      ; in gia tri cua arg c
	call 	newline
	mov 	ecx,[ebp+ebx]  ; lay gia tri cua arg c(so phan tu cua arg v) luu vao ecx
	add 	ebx,4          ; tang bien chi vi chi len 4
	xor 	esi,esi        ; gan esi = 0 = mov esi,0; esi dung de lam bien dem trong vong lap _arg
	mov 	edx,[ebp+ebx]  ;lay gia tri tai dia chi ebp + ebx (dang truy xuat toi arg v)

_arg:
    cmp 	esi,ecx        ;so sanh esi voi so luong arg
    je 		_exit  
	lea 	eax, [edx]     ;lay dia chi edx luu vao thanh ghi eax
	call 	write_hex 
	call 	space
	mov 	eax, [edx]     ;lay gia tri tai dia chi edx luu vao thanh ghi eax
	call 	write_hex
	call 	newline
	add 	edx,4          ; tang gia tri edx  len 4 (ma edx la )
	inc 	esi            ; tang esi 
    jmp 	_arg  

_exit:
	leave
	ret