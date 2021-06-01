section	.data
bMem	times 100 db	0

section .bss
	extern	write_hex
	extern	space
	extern	newline
	extern	write_char
	extern  write_bin

section .text
	global	stackwalk
	
stackwalk:
    push	ebp
	mov 	ebp, esp ;dua ebp len dau
	xor 	ebx,ebx; xet ebx =0 -> dung de lam bien chi vi tri trong stack
	add 	ebx, 8 ; + 8 cho ebx
   
_local:
 ; edx = edx + ebp + ebx
	mov 	edx,ebp 
	add 	edx,ebx; cong edx voi ebx va luu vao edx
    cmp 	edx,[ebp] ; dieu kien lap: so sanh gia tri cua ebp - (dia chi cua ebp stack truoc)
    je _ebp 
	lea 	eax, [ebp+ebx]
	call write_hex
	call space
	mov eax, [ebp+ebx]
	call write_hex
	call newline  
	add ebx,4	
    jmp _local  
    call newline
_ebp:
    lea eax, [ebp+ebx]
    call write_hex
    call space
    mov eax, [ebp+ebx]
    call write_hex
    call newline
    call newline
    add ebx,4
    
_ret_addr:
    lea eax, [ebp+ebx]
    call write_hex
    call space
    mov eax, [ebp+ebx]
    call write_hex
	add ebx,4
	call newline
    call newline

_number_of_arg:
	lea eax, [ebp+ebx] ; bien chi vi tri toi vi tri arg c
    call write_hex
    call space
    mov eax, [ebp+ebx]
    call write_hex; in gia tri cua arg c
	call newline
	call newline
	mov ecx,[ebp+ebx]; lay gia tri cua arg c(so phan tu cua arg v) luu vao ecx
	add ebx,4 ; tang bien chi vi chi len 4
	xor esi,esi; gan esi = 0 = mov esi,0; esi dung de lam bien dem trong vong lap _arg
	mov edx,[ebp+ebx] ;lay gia tri tai dia chi ebp + ebx (dang truy xuat toi arg v)

_arg:
    cmp esi,ecx;so sanh esi voi so luong arg
    je _exit 
	lea eax, [edx]
	call write_hex
	call space
	mov eax, [edx]
	call write_hex
	call newline
	add edx,4; tang gia tri edx  len 4 (ma edx la )
	inc esi; tang esi 
    jmp _arg  

_exit:
	leave
	ret