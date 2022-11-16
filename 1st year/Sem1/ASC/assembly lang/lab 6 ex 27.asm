; Being given a string of words, compute the longest substring of ordered words ;(in increasing order) from this string.




bits 32 
global start
extern exit; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll; exit is a function that ends the calling process. It is defined in msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	
    A dw 1234h , 3456h , 5678h , 1000h, 1230h
    len equ ($ - A)/2 ; length of the string A (in doublewords)= 3
    B times len db 0 ; length of the string A = 3
    
; our code starts here
segment code use32 class=code
    start:
    
    
    mov ESI, A
    mov EDI, A+2
    mov BL, 1
    mov BH, 0
    mov DH, len - 1
    cmp DH, BH
    je final
    mov ECX, len - 1
    repeta:
        cmpsw
        JA new
        inc BL
        new:
        cmp BH, BL
        jae notupdateed
        mov BH, BL
        mov EDX, EDI
        notupdateed:
        mov BL, 1
        stosw
    loop repeta
    final:
    mov EAX, 0
    mov AL, BH
    sub EDX, EAX
    mov ESI, EDX
    mov EDI, B
    mov ECX, 0
    mov CL, BH
    repeta2:
    movsw
    loop repeta2
    
    
    
	

sfarsit:;end the program
           
        push dword 0; push the parameter for exit onto the stack
        call [exit]; call exit to terminate the program
        