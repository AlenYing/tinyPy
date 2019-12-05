global main
extern write_natural
extern read_natural
extern write_boolean
extern read_boolean

section .bss

section .text
main:
mov eax,28
push eax
call write_natural
add esp,4
xor eax,eax
ret
