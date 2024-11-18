bits 16

section _TEXT

global _x86_Video_WriteCharTeletype
_x86_Video_WriteCharTeletype:

  enter 0, 0

  push bx

  mov ah, 0xE
  mov al, [bp + 4]
  mov bh, [bp + 6]
  
  int 0x10

  pop bx

  leave
  ret
