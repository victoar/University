;Given an array A of doublewords, build two arrays of bytes:  
;  - array B1 contains as elements the lower part of the lower words from A
;  - array B2 contains as elements the higher part of the higher words from A



bits 32 
global start
extern exit; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll; exit is a function that ends the calling process. It is defined in msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	
    A dd 12341A2Ch , 98FC1278h
    len equ ($ - A)/4 ; len = length of the string A (in doublewords)= 2
    B1 times len db 0 ; B1 = len = length of the string A = 2
    B2 times len db 0 ; B2 = len = length of the string A = 2
    
; our code starts here
segment code use32 class=code
    start:
    
    ;  - array B1 contains as elements the lower part of the lower words from A
    mov ESI, A
    mov ECX, len
    mov EDI, B1
    cld
    repeta:
    lodsw ; loads in AX the lower word from A
    mov AH, 0 ; we don't need the higher part of the lower word
    stosb ; store AL that contains the lower byte
    lodsw ; this loads in AX the higher word
    loop repeta
    
    ;  - array B2 contains as elements the higher part of the higher words from A
    mov ESI, A
    mov ECX, len
    mov EDI, B2
    repeta2:
    lodsw ; this loads in AX the lower word from A
    lodsw ; this loads in AX the lower word from A
    shr AX, 8 ; we shift to right with 8 positions to get AH
    stosb ; store AL that contains the higher byte
    loop repeta2
    
	

sfarsit:;end the program
           
        push dword 0; push the parameter for exit onto the stack
        call [exit]; call exit to terminate the program
        