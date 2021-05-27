section .data
  value	db 'A'
  bMem  db '0123456'

  
  extern space
  extern write_char
  extern write_hex
  extern write_hex_digit
  extern newline
section .text
global _start

_start:
  mov esi,_start
  mov ecx,16
  cld
_ploop:
  lodsb
  call write_hex
  call space
  loop _ploop
  call newline
_exit:
  mov eax,1
  int 0x80
