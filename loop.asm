
section .data
list1	db 4,1,-5,7,9,3
list2	db 4,1,5,7,9,3
LEN	equ 6
msg1	db "Matched!",10
len1	equ $-msg1
msg2	db "Unmatch found at: ",0x30,10
len2	equ $-msg2

section .text
global	_start
_start:
	mov ecx,LEN	
	mov esi,list1
	mov edi,list2
	cld
_cmploop:
	repe cmpsb

	mov ebx,list1
	sub esi,ebx
	cmp esi,LEN
	jb  _unmatched
_matched:
	mov eax,4
	mov ebx,1	
	mov ecx,msg1	
	mov edx,len1
	int 0x80
	jmp _exit
_unmatched:
	mov eax,esi
	add byte[msg2+len2-2],al
	mov eax,4
	mov ebx,1	
	mov ecx,msg2	
	mov edx,len2
	int 0x80	

_exit:
	mov eax,1
	int 0x80


