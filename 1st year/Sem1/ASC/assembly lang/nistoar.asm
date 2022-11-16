bits 32 

global start        

extern exit, scanf, fopen, fclose, fprintf  
import exit msvcrt.dll   
import fopen msvcrt.dll   
import fclose msvcrt.dll   
import scanf msvcrt.dll   
import fprintf msvcrt.dll
 
; se citeste de la tastatura un numar si un sir de caractere si apoi se creeaza un fisier cu numele "(sir)(numar).txt"

                         
segment data use32 class=data
    a dd 0
    decimal_format db "%d", 0
    buffer times 50 db 0
    string_format db "%s", 0
    access_mode db "w", 0
    file_descriptor dd -1
    extensie db ".txt", 0
    char_format db "%c", 0
    ten dd 10
    two dd 2
    minus_one dd -1
    digits times 50 db 0
    a1 dd 0
    parity dd 0
    
segment code use32 class=code
    start:
    
    ; scanf("%s", &buffer)
    push dword buffer
    push dword string_format
    call [scanf]
    add ESP, 4*2
    
    ; scanf("%d", &a)
    push dword a
    push dword decimal_format
    call [scanf]
    add ESP, 4*2
    
    ; first things first, we compute the name of the file
    cld 
    mov ESI, buffer
    
    my_loop:
        lodsb
        
        cmp AL, 0
        je exit_loop
    jmp my_loop
    
    exit_loop:
    dec ESI
    
    mov EDI, ESI
    mov ESI, extensie
    
    loop_2:
        lodsb 
        stosb
        cmp al, 0
        je stop_loop
    jmp loop_2
    
    stop_loop:
    
    ; fopen(&filename, &access_mode)
    push dword access_mode
    push dword buffer
    call [fopen]
    add ESP, 4*2
    
    cmp EAX, 0
    je errorx
    mov dword[file_descriptor], EAX
    
    ; we check to see if there is a negative number
    
    mov eax, [a]
    cmp eax, 0
    cdq
    jg not_minus
        imul dword [minus_one]
    not_minus:
    mov [a], eax
    
    ; we count the length of the number in ecx
    
    mov ecx, 0
    
    loop1:
        cmp eax, 0
        je stop_loop2
        cdq
        div dword [ten]
        inc ecx
    jmp loop1
    
    stop_loop2:
    
    
    ; in this part we will check every postion of the number
    ; if the position is even, we ll add the number in digits variable
    
    mov ebx, 0
    mov eax, dword [a]
    mov dword [a1], eax    
        
    loop2:
        cmp ecx, 0
        je stop_loop_2
        mov eax, ecx
        cdq
        div dword [two]
        mov [parity], edx
        ;jne no_even_pos
        mov eax, [a1]
        cdq
        div dword [ten]
        mov [a1], eax
        cmp dword [parity], 0
        jne no_even_pos
            mov [digits+ebx], dl
            inc ebx        
        no_even_pos:
        dec ecx
    jmp loop2
    stop_loop_2:
    
    ; im this part we will print step by step the numbers from digits variable
    dec ebx
    print_loop:
        mov eax, 0
        mov al, [digits+ebx]
        ;cmp ebx, 0
        ;je print_finished
        push dword eax
        push dword decimal_format
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*3
        cmp ebx, 0
        je print_finished
        dec ebx
    jmp print_loop
    
    print_finished:
    
    
    ; fclose(file_descriptor)
    push dword [file_descriptor]
    call [fclose]
    add ESP, 4*1
    
    errorx:
    
       
        push    dword 0   
        call    [exit]   