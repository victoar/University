bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, fread, scanf, fopen, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fread msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    L dd 0
    nr_cuvant dd 0
    nr_cuvinte dd 0
    format_number db "%u", 0
    print_format db "There are %u words with ", 0
    print_format2 db "the length of %u .", 0
    file_name db "cuvinte.txt", 0
    access_mode db "r", 0
    file_descrpitor dd -1
    
    format_string db "%s", 0
    cuvinte times 100 db 0
    cuvant times 50 db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        push access_mode
        push file_name
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je file_not_open
        mov [file_descrpitor], eax
        
        push dword [file_descrpitor]
        push 100
        push 1
        push cuvinte
        call [fread]
        add esp, 4*4
        
        push dword L
        push dword format_number
        call [scanf]
        add esp, 4*2
        
        
        mov esi, cuvinte
        ;mov edi, cuvant
        cld
        parse:
            lodsb
            ;inc [nr_cuvnt]
            cmp al, 0
            je stop
            cmp al, ' '
            je new_word
            inc dword [nr_cuvant]
            jmp next
            
            new_word:
                mov eax, dword [L]
                cmp eax, dword [nr_cuvant]
                jne not_equal
                    inc dword [nr_cuvinte]
            not_equal:
            mov dword [nr_cuvant], 0
            
            next:
        
        jmp parse
        
        stop:
        
        mov eax, dword [L]
        cmp eax, dword [nr_cuvant]
            jne not_equal2
                inc dword [nr_cuvinte]
        not_equal2:
        
        push dword [nr_cuvinte]
        push dword print_format
        call [printf]
        add esp, 4*2
        
        push dword [L]
        push dword print_format2
        call [printf]
        add esp, 4*2
        
        push dword [file_descrpitor]
        call [fclose]
        add esp, 4
        
        
        file_not_open:
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
