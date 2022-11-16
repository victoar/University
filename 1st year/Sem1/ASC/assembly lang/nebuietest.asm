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

    s db '12&1+5^123-26<<2+10'
    format db "%d", 0
    len equ $-s 
    rez db 0
    ten db 10
    semn db 0
    first_number db 0
    second_number db 0
    ok db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        mov esi, 0
        mov ecx, len
        mov edx, 0
        loop1:
            mov al, [s+esi]
            cmp al, '0'
            jl not_good
            cmp al, '9'
            jg not_good
            sub al, '0'
            add dl, al
            mov al, dl
            mul byte [ten]
            mov dx, ax
            jmp next
            not_good:
                mov byte [semn], al
                mov ax, dx
                div byte [ten]
                mov byte [first_number], al
                mov edx, 0
            next:
            cmp byte [semn], '+'
            jne outside
                mov al, byte [first_number]
                mov bl, byte [second_number]
                add al,bl
                mov byte [rez], al
            cmp byte [semn], '-'
            jne outside
                mov al, byte [first_number]
                mov bl, byte [second_number]
                sub al,bl
                mov byte [rez], al
            cmp byte [semn], '&'
            jne outside
                mov al, byte [first_number]
                mov bl, byte [second_number]
                and al,bl
                mov byte [rez], al
            cmp byte [semn], '^'
            jne outside
                mov al, byte [first_number]
                mov bl, byte [second_number]
                xor al,bl
                mov byte [rez], al
            inc esi
            
            
        loop loop1
        
        mov eax, 0
        mov al, byte [rez]
        
        push eax
        push dword format
        call [printf]
        add esp, 4*2
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
