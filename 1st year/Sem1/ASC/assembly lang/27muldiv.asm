
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	
    a db 8;
    b db 4;
    c db 5;
    d dw 12;
    
    
segment  code use32 class=code ;
start: 
    
    ; d/[(a+b)-(c+c)]

    mov AX, [d];
    mov BL, [a];
    add BL, [b];
    mov CL, [c];
    add CL, [c];
    sub BL,CL;
    div BL;
    
    	