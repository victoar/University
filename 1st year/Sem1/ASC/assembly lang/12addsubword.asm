
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	
    a dw 11;
    b dw 16;
    c dw 5;
    d dw 2Ch;
    
    
segment  code use32 class=code ;
start: 

    ; d-(a+b)-(c+c)

    mov AX, [d];
    mov BX, [a];
    add BX, [b];
    mov CX, [c];
    add CX, [c];
    sub AX, BX;
    sub AX, CX;
    	