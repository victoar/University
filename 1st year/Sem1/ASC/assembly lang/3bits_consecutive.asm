bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    sir dq 1110111b, 1000000h, 0abcd0002e7fch, 5
    len equ ($-sir)/8
    rez times len dd 0
    counter dd 0
    ok dd 0
    format_char db '%c', 0
    prop times 30 db 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov esi, sir
        mov edi, rez
        mov ecx, len
        cld
        loop1:
            lodsd
            push ecx
            mov ebx, eax
            mov ecx, 32
            mov edx, 0 ; number of 3 consecutive 1
            counter_bits:
                shl ebx, 1
                jnc is_zero
                    inc dword [counter]
                    jmp next
                is_zero:
                cmp dword [counter], 3
                jb not_good
                    inc edx
                not_good:
                mov dword [counter], 0
                next:
                
            loop counter_bits
            
            cmp dword [counter], 3
            jb not_good1
                inc edx
            not_good1:
            
            cmp edx, 2
            jb not_two
                stosd
            not_two:
            
            lodsd
            pop ecx
        loop loop1
                
        mov esi, rez
        cld
        printing:
            lodsd
            cmp eax, 0
            je stop
            mov ecx, 32
            mov dword [ok], 0
            bits_loop:
                shl eax, 1
                jnc is_zero1
                    mov dword [ok], 1
                    push ecx
                    push eax
                    push dword '1'
                    push dword format_char
                    call [printf]
                    add esp, 4*2
                    jmp next1
                is_zero1:
                push ecx
                push eax
                cmp dword [ok], 0
                je no_print
                    push dword '0'
                    push dword format_char
                    call [printf]
                    add esp, 4*2
                no_print:
                next1:
                pop eax
                pop ecx
            loop bits_loop
        push dword ' '
        push dword format_char
        call [printf]
        add esp, 4*2
        
        jmp printing
        stop:
        
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
