
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	
    a db 8;
    b db 4;
    c db 6;
    d db 12;
    e dw 7
    f dw 15
    g dw 13
    h dw 16
    
segment  code use32 class=code ;
start: 

    ; [(e+f-g)+(b+c)*3]/5
    
    mov BX, [f];
    sub BX, [g];
    add BX, [e];
    mov AL, [b];
    add AL, [c];
    mov CL, 3;
    mul CL;
    add AX,BX;
    mov CL, 5;
    div CL;
    
    	