bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    a db "casa"
    len equ $-a
    b db "ture"
    format db "%s ", 0
    format1 db "The first string is: ", 0
    format2 db "The second string is: ", 0
    c times len*2 db 0
    d times len*2 db 0
    ; in the end it should be ctausrae and tcuarsea
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
    mov ebx, 0
    mov edx, 0
    mov ecx, len
    mov edi, 0
    jecxz endFor1
    forIndex1
        mov al, [a+ebx]
        mov [c+edi], al
        inc edi
        mov al, [b+edx]
        mov [c+edi], al
        inc edi
        inc ebx
        inc edx
    loop forIndex1
    endFor1:
    
    push dword format1
    call [printf]
    add esp, 4
    
    push dword c
    push dword format
    call [printf]
    add ESP, 4*2
    
    mov ebx, 0
    mov edx, 0
    mov ecx, len
    mov edi, 0
    jecxz endFor2
    forIndex2
        mov al, [b+edx]
        mov [d+edi], al
        inc edi
        mov al, [a+ebx]
        mov [d+edi], al
        inc edi
        inc ebx
        inc edx
    loop forIndex2
    endFor2:
    
    push dword format2
    call [printf]
    add esp, 4
    
    push dword d
    push dword format
    call [printf]
    add ESP, 4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
