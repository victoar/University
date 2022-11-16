
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	
    a db 11;
    b db 40;
    c db 5;
    d db 1
    
    
segment  code use32 class=code ;
start: 

    ; (a+b-c)-(a+d)

    mov AL, [a];
    add AL, [b];
    sub AL, [c];
    mov CL, [a];
    add CL, [d];
    sub AL, CL;
    	