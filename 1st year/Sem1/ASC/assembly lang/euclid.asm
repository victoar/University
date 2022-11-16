bits 32 ; assembling for the 32 bits architecture
 
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
 
; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import printf msvcrt.dll
 
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
 
        format db "%u"
        format1 db "CMMDC is %u"
        a db 0
        b db 0
 
; our code starts here
segment code use32 class=code
    start:
        ; ...
 
        ; read the first number
        push dword a
        push dword format
        call [scanf]
        add ESP, 4*2
        
        mov ebx, [a]
 
        ; read the second number
        push dword b
        push dword format
        call [scanf]
        add ESP, 4*2
 
        mov edx, [b]
 
        mov ecx, 1; we will make an infinite loop. It will stop only when the 2 numbers are the same
        
        jecxz endFor
        forIndex:
            cmp ebx,edx
                je outside; jumps outside if the loop instruction when the 2 numbers are the same (CMMDC is found)
            cmp ebx,edx
                ja next; if ebx is bigger than edx, it jumps to second operation, else it substracts ebx from edx
                    sub edx, ebx
                    ja next1
                next:
                jb next1; if edx is bigger than ebx, it jumps to the end, else it substracts edx from ebx
                    sub ebx, edx
                next1:
            inc ecx
        loop forIndex
        endFor:
        outside:
        
        ; printing the final result
        push dword ebx; ebx and edx are the same, so we can take any of them 
        push dword format1
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
 