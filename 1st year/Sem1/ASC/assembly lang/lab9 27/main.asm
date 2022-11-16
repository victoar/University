bits 32
global start

;Two strings of characters of equal length are given. 
;Calculate and display the results of the interleaving of the letters, for the two possible interlaces 
;(the letters of the first string in an even position, respectively the letters from the first string in an odd positions). 
;Where no character exist in the source string, the ‘ ’ character will replace it in the destination string.

import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit

extern factorial, factorial1

segment data use32
	a db "bja.Alk"
    len equ $-a
    b times len db 0
    c times len db 0
    format1 db "The string with uppercase letters is: %s \n", 0
    format2 db "The string with lowercase letters is: %s ", 0

segment code use32 public code
start:
	push dword len
    push dword b
    push dword a
	call factorial
    
	push dword b
	push format1
	call [printf]
	add esp, 2*4
    
    push dword len
    push dword c
    push dword a
	call factorial1
    
	push c
	push format2
	call [printf]
	add esp, 2*4

	push 0
	call [exit]
