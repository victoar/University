bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    sir1 dd 1245ab36h, 23456789h, 1212F1EEh
    len equ ($-sir1)/4
    lung dd 0
    sir2 times len db 0
    sir3 times 100 db 0
    sir4 times len db 0
    format db '%d', 0
    format2 db '%c', 0
    format3 db '%s ', 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        
        mov esi, sir1
        mov edi, sir2
        mov ecx, len
        cld
        jecxz loop1
        forIndex:
            lodsw
            cmp AH, byte 0
            jg not_good
                mov al, ah
                stosb
                inc dword [lung]
            not_good:
            lodsw
        loop forIndex
        loop1:
        
        mov esi, sir2
        cld
        ;mov edi, sir4
        loop4:
            lodsb
            cmp al, byte 0
            je outside1
            mov ecx, 8
                print_bits:
                
                shl al, 1
                push eax
                push ecx
                jnc zero
                
                mov ebx, 1
                push ebx
                push dword format
                call [printf]
                add esp, 4*2
                jmp next
                
                zero:
                
                mov ebx, 0
                push ebx
                push dword format
                call [printf]
                add esp, 4*2
                
                next:
                
                pop ecx
                pop eax
                
                loop print_bits
                
                mov ebx, 32
                push ebx
                push dword format2
                call [printf]
                add esp, 4*2
                
        jmp loop4
        outside1:
        
        mov esi, sir2
        mov edi, sir3
        mov bl, 10
        cld
        loop3:
            mov al, '-'
            stosb
            lodsb
            cmp al, 0
            je stop_loop
            neg al
            mov ecx, 0
            loop5:
                cmp al, 0
                je stop_loop5
                mov ah, 0
                div bl
                mov [sir4 + ecx], ah
                inc ecx
            jmp loop5
            stop_loop5:
            invers:
                cmp ecx, dword 0
                je stop_invers
                dec ecx
                mov al, [sir4 + ecx]
                add al, 48
                stosb
            jmp invers
            stop_invers:
            mov al, 32
            stosb
                  
        jmp loop3
        stop_loop:
        dec edi
        mov al, 0
        stosb
        
        mov esi, sir3
        printing:
        
            mov eax, 0
            lodsb
            cmp al, 0
            je stop_printing
                push eax
                push dword format2
                call [printf]
                add esp, 4*2
        jmp printing
        
        stop_printing:
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
