bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fprintf,fread,fopen,fclose,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fprintf msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_name1 db 'fisier1.txt',0
    file_name2 db 'fisier2.txt',0
    format_string db '%s',0
    format_char db '%c',0
    access_mode1 db 'r',0
    access_mode2 db 'w',0
    file_descript1 dd -1
    file_descript2 dd -1
    nr_prop dd 1
    starting dd 0
    text times 100 db 0
    
    
; our code starts here
segment code use32 class=code
    
    start:
        ; ...
        push access_mode1
        push file_name1
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je final
        mov [file_descript1],eax
        
        push dword[file_descript1]
        push 100
        push 1
        push text
        call [fread]
        
        mov bl, 2
        mov esi, text
        mov dword[starting] , text
        
        parse:
        lodsb 
        cmp al, 0
        je gata_text
        cmp al, '.'
        jne interior_prop
        
        mov byte[esi-1],0
        mov ax, word[nr_prop]
        div bl
        cmp ah, 1
        jne nu_print
        
        push dword[starting]
        push format_string
        call [printf]
        add esp, 8
        
        push '.'
        push format_char
        call [printf]
        add esp, 8
        
        nu_print:
        mov [starting],esi
        inc word[nr_prop]
        interior_prop:
        jmp parse
        
        gata_text:
        
        push dword[file_descript1]
        call [fclose]
        add esp, 4
        
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
