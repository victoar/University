bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fclose, fscanf, printf, fopen               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fscanf msvcrt.dll                         ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_name db "test1.txt", 0
    access_mode db "r", 0
    
    n dd 0
    two dd 2
    file_descrpitor dd -1
    format dd "%x"
    format1 dd "%x "
    format2 dd " ", 13, 10, 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descrpitor], eax
        cmp eax, 0
        je finish
        
        read:
        
            push dword n
            push dword format
            push dword [file_descrpitor]
            call [fscanf]
            add esp, 4*3
            
            cmp eax, 0
            jl stop
            
            mov eax, [n]
            mov edx, 0
            div dword [two]
            cmp edx, 0
            je not_good
                push dword [n]
                push dword format1
                call[printf]
                add esp, 4*2
                
                mov ecx, 0
                mov eax, [n]
                binary_count:
                  cmp eax, 0
                  je stop_couting
                  mov edx, 0
                  div dword [two]
                  cmp edx, 0
                  je is_zero
                    inc ecx
                  is_zero:
                jmp binary_count
                
                stop_couting:
                push dword ecx
                push dword format1
                call [printf]
                add esp, 4*2
                
                push dword format2
                call [printf]
                add esp, 4
                
            not_good:
            
            
        jmp read
        
        stop:
        
        push dword [file_descrpitor]
        call [fclose]
        add esp,4
        
        finish:
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
