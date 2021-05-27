section	.data
bMem	times 100 db	0
section .bss
	extern	write_hex
	extern	space
	extern	newline
	extern	write_char
section .text
	global	display_memory
	global  mem_line
display_memory:
	push	ebp
	mov	ebp,esp
	mov	esi,[ebp+8]
	mov	ecx,[ebp+12]
	shr	ecx,4
displ_mem:
	call	mem_line
	loop	displ_mem
	leave
	ret
mem_line:
	push	ecx
	mov	ecx,16
	cld
disp_loop:
	lodsb
	call 	write_hex 
	call	space
	loop	disp_loop
	call	newline
	pop	ecx
	ret

