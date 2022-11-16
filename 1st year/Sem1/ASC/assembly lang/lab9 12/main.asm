bits 32
global start

import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit

extern modul1, modul2

segment data use32
	a db "casa"
    len equ $-a
    b db "t8r6"
    format1 db "The first string is: %s ", 0
    format2 db "The second string is: %s ", 0
    c times len*2 db 0
    d times len*2 db 0
    
segment code use32 public code
start:
	push dword len
    push dword c
    push dword b
    push dword a
	call modul1
    
	push dword c
	push format1
	call [printf]
	add esp, 2*4
    
    push dword len
    push dword d
    push dword b
    push dword a
	call modul2
    
	push dword d
	push format2
	call [printf]
	add esp, 2*4

	push 0
	call [exit]
