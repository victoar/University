bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit , scanf, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fprintf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    file_name db "1-impar_neg.txt", 0
    number_format db "%d", 0
    print_format db "%d ", 0
    counter dd 0
    nr dd 0
    numbers times 20 dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov ebx, 0
        read_loop:
            push ebx
            push dword nr
            push dword number_format
            call [scanf]
            add ESP, 4*2
            
            cmp dword [nr], 0
            je exit_loop
            
            pop ebx
            mov eax, [nr]
            mov [numbers], eax    
            inc ebx
                
        jmp read_loop
        exit_loop:

        mov ebx, 0
        print_loop:
        
            cmp ebx, ecx
            je exit_print_loop
            
            push dword [numbers+ebx]
            push dword print_format
            call [printf]
            add ESP, 4*2
            inc ebx
        
        jmp print_loop
        exit_print_loop:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
