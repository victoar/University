
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	
    a db 11;
    b db 40;
    c db 0;
    d db 1
    
segment  code use32 class=code ;
start: 

    ; 2-(c+d)+(a+b-c)

    mov AL, 2;
    mov BL, [c];
    add BL, [d];
    mov CL, [a];
    add CL, [b];
    sub CL, [c];
    sub AL, BL;
    add AL,CL;
