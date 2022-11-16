bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, gets, printf, fopen, fread               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import gets msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sentence times 100 db 0
    
    file_name db "citire.txt", 0
    access_mode db "r", 0
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
        
        push dword[file_descriptor]
        push 100
        push 1
        push sentence
        call [fread]
        
        mov dx, 1 ; nr propozitiei
        mov bl, 2
        mov esi, sentence
        
        cld
        loop1:
            lodsb
            cmp al, 0
            je stop
            cmp al, '!'
            jne work
            
            mov byte [esi - 1], 0
            mov ax, dx
            div bl
            cmp ah, 0
            je no_printing
            
            
        
        
        
        
        
        push dword sentence
        push dword format
        call [printf]
        add esp, 4*2
        
        finish:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
