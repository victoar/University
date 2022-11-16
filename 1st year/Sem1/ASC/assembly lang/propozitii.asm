bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fgets, printf, fopen               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fgets msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import fopen msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    file_name db "propozitii.txt", 0
    access_mode db "r", 0
    sentence times 100 db 0
    format db "%s", 0
    
    file_descriptor dd -1
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        cmp eax, 0
        je finish
        
        push dword sentence
        push dword format
        push dword [file_descriptor]
        call [fgets]
        add esp, 4*3
        
        mov esi, sentence
        
        push dword esi
        call [printf]
        add esp, 4
        
        finish:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
