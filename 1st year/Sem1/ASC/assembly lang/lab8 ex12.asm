;    A file name is given (defined in the data segment). Create a file with the given name,
;  then read numbers from the keyboard and write those numbers in the file,
;  until the value '0' is read from the keyboard.


bits 32

global start

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, scanf, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "numbers.txt", 0   ; filename to be created
    access_mode db "w", 0       ; file access mode:
                                ; w - creates an empty file for writing
    file_descriptor dd -1       ; variable to hold the file descriptor
    format dd "%d", 0  ; text to be write to file
    wformat dd "%d ", 0
    titleformat dd "Your numbers are: ", 0
    msg dd "Give some numbers: "
    nr dd 0

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

        mov [file_descriptor], eax  ; store the file descriptor returned by fopen
        
        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final
        
        ; print a nice message
        push dword msg
        call [printf]
        add ESP, 4*1

        push dword titleformat
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        mov ecx, 1
        mov ebx, 0 ; I put in EBX 0, so I can compare EBX with the register in which the number from the keyboard will be
        jecxz endFor
        forIndex
            push dword nr
            push dword format
            call [scanf]
            add ESP, 4*2
            mov eax, [nr]
            cmp eax, ebx
            je equal
            ; write the text to file using fprintf()
            ; fprintf(file_descriptor, text)
            push dword [nr]
            push dword wformat
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4*3
            inc ecx
        loop forIndex
        endFor:

      equal:
        ; call fclose() to close the file
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4

      final:

        ; exit(0)
        push dword 0      
        call [exit]
        
        
        
        
        
        
        
        
        
        