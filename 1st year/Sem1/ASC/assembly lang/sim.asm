bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                   ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    a db "Ab, Cdka. Opasd"
    len equ $-a
    b db ""
    c db ""
    format db "%s" 

; our code starts here
segment code use32 class=code
    start:
        ; ...
     
     
     mov esi, a
     mov ecx, len
     mov ebx, 0; counter for b positions
     mov edx, 0; counter for c positions
     jecxz endFor1
     forIndex1
         lodsb
         cmp al, 41h
         jl noUppercase
         cmp al, 5ah
         jg noUppercase
         mov [b+ebx], al
         inc ebx
        noUppercase:
     loop forIndex1
     endFor1:
     
     push dword b
     push dword format
     call [printf]
     add ESP, 4*2
     
     mov esi, a
     mov ecx, len
     jecxz endFor2
     forIndex2
         lodsb
         cmp al, 61h
         jl noLowercase
         cmp al, 7ah
         jg noLowercase
         mov [c+edx], al
         inc edx
        noLowercase:
     loop forIndex2
    endFor2:
        
     
     push dword c
     push dword format
     call [printf]
     add ESP, 4*2
     

    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
