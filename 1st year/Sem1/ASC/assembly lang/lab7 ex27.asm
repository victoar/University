; A character string is given (defined in the data segment). 
; Read one character from the keyboard, then count the number of occurences of that character in the given string and display the character along with its number of occurences.

bits 32
global start        

; declare extern functions used by the program
extern exit, printf, scanf         ; add printf as extern function            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf can be found in library msvcrt.dll
import scanf msvcrt.dll
                          
segment data use32 class=data
; char arrays are of type byte
        a db 'a' , 'b' , 'a' , 'c' , 'd' , 'a';
        len equ ($-a)
        msg db "character = ", 0;
        format2 db "%c"
        format db "The character %c,", 0
        format1 dd " appears %d time(s)", 0
        
		c db 0
        
segment  code use32 class=code
    start:
        
        push dword msg
        call [printf]
        add ESP, 4*1
        
        push dword c
        push dword format2
        call [scanf]
        add ESP, 4*2
        
        mov EDX, 0
        mov DL, [c]
        mov EBX, 0
        mov ESI, 0
        mov ECX, len
        jecxz endFor
        forIndex
            mov AL, [a+ESI]
            cmp AL, DL
            JNE equal
                inc EBX
            equal:
            inc ESI
        loop forIndex
        endFor:
        
        push dword EDX
        push dword format
        call [printf]
        add ESP, 4*2
        
        push dword EBX
        push dword format1
        call [printf]
        add ESP, 4*2
        
        
        
        
        ; exit(0)
        push dword 0      ; push on stack the parameter for exit
        call [exit]       ; call exit to terminate the programme
