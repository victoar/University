bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    caractere db "aeiouAEIOUbcdfghjklmnopqrstvwxyzBCDFGHJKLMNOPQRSTVWXYZ0123456789"
    lv equ $-caractere
    propozitie db "In perioada 20-23 Ianuarie 2020 sunt programate exeamenel la ASC!"
    l equ $-propozitie

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        mov ecx, propozitie + 1
        mov esi, caractere
        mov edi, propozitie
        mov eax, 0
        mov ebx, 0
        
        repeta:
        
            cmpsb
            
            ;
            jne continuare
            inc al
            mov esi, caractere
            inc ebx
            continuare:
                mov edi, propozitie
                add esi, ebx
                cmp esi, propozitie
                jne urmatorul
                mov esi, caractere
                inc ebx
            urmatorul:
                cmp edi, ecx
                je afara
           jmp repeta
           afara:
              sub eax, 1
              neg eax
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
