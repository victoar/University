bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit ,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                        ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    sir1 db 'SI se ImpiNg SI SAr RAZanD'
    len1 equ $-sir1
    sir2 db 'PrIn ZapADA Fac mATAniI'
    len2 equ $-sir2
    format db '%d', 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        mov ebx, 0
        mov esi, len1-1
        mov ecx, len1
        et_1:
            push ecx
            mov al, [sir1+esi]
            cmp al, 'z'
            ja et_4
            cmp al, 'a'
            jb et_4
            mov edi, 0
            mov ecx, len2
            et_2:
                cmp al, [sir2+edi]
                jne et_3
                inc ebx
            et_3:
                inc edi
            loop et_2
        et_4:
            pop ecx
       loop et_1
       
       push ebx
       push dword format
       call [printf]
       add esp, 4*2
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
