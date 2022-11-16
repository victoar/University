; A negative number a (a: dword) is given. Display the value of that number in base 10 and in the base 16 in the following format: "a = <base_10> (base 10), a = <base_16> (base 16)"

bits 32
global start        

; declare extern functions used by the program
extern exit, printf         ; add printf as extern function            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf can be found in library msvcrt.dll
import scanf msvcrt.dll
                          
segment data use32 class=data
; char arrays are of type byte

        n dd -5
        format1 db "a= %d (base 10)", 0 ; %d will be replaced with a number in base 10
        format2 db ", a= %x (base 16)", 0  ; %x will be replaced with a number in base 16

				; char strings for C functions must terminate with 0
segment  code use32 class=code
    start:
        
        
        mov EAX, [n]
        push dword EAX 
        push dword format1
        call [printf]
        add ESP, 4*2
        
        mov EAX, [n]
        push dword EAX
        push dword format2
        call [printf]
        add ESP, 4*2
        
        ; exit(0)
        push dword 0      ; push on stack the parameter for exit
        call [exit]       ; call exit to terminate the programme
        