bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functionsi
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    string times 100 db 0
    format db "%s", 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
   
        
        push dword string
        push dword format
        call [scanf]
        add esp, 4*2
        
        push dword string
        push dword format
        call [printf]
        add esp, 4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
