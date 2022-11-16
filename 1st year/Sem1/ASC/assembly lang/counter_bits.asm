bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                         ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    
    sir dq 1234a678h, 12785634h, 1a4d3c2bh
    len equ ($-sir)/4
    sir2 times len dw 0
    counter dd 0
    decimal_format db "%d", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        mov esi, sir
        mov edi, sir2
        mov ecx, len
        cld
        loop1:
            lodsd
            mov bl, ah
            shr eax, 16
            mov al, bl
            stosw
        loop loop1
        
        mov esi, sir2
        mov edx, 0
        mov ecx, len
        loop2:
            lodsw
            push ecx
            mov ecx, 16
            count_bits:
                shl ax, 1
                jnc is_zero
                    inc dword [counter]
                is_zero:
            loop count_bits
            mov ecx, [counter]
            add edx, ecx
            mov dword [counter], 0
            pop ecx
        loop loop2
        
        push edx
        push dword decimal_format
        call [printf]
        add esp, 4*2
            
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
