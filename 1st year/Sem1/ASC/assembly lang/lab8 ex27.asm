; A text file is given. The text file contains numbers (in base 10) separated by spaces.
; Read the content of the file, determine the minimum number (from the numbers that have been read) and write the result at the end of file.



bits 32

global start

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, fread, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "text.txt", 0   ; filename to be created
    access_mode db "r", 0
    access_mode1 db "w", 0       ; file access mode:
                                ; w - creates an empty file for writing
    file_descriptor dd -1       ; variable to hold the file descriptor
    format dd "%d", 0  ; text to be write to file
    wformat dd "%d ", 0
    titleformat dd "Smallest number is: ", 0    
    len equ 100
    text times (len+1) db 0 
    space db ' '

; our code starts here
segment code use32 class=code
    start:
        ; call fopen() to create the file
        ; fopen() will return a file descriptor in the EAX or 0 in case of error
        ; eax = fopen(file_name, access_mode)
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack

        mov [file_descriptor], eax
        
        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final
        
        push dword titleformat
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4
        
        mov dl, [space]
        mov esi, EAX
        dec esi
        mov ecx, eax
        mov ebx, 0
        mov eax, 0
        jecxz endFor
        forIndex
            mov bl, [text+esi]
            cmp dl, bl
            jne ceau
                mov eax, 0
            ceau:
            sub bl, '0'
            mul byte 10
            mul bl
            mov [x], bl
            dec esi            
            
        loop forIndex
        endFor:
        
        
        push dword ebx
        ;push dword EAX
        push dword format
        call [printf]
        add esp, 4*3

        ; call fclose() to close the file
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4

      final:

        ; exit(0)
        push dword 0
        call [exit]
        
        
        
        
        
        
        
        
        
        