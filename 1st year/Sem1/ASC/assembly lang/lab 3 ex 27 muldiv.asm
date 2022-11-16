
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
    
    a db 1;
    b db 2;
    c dw 3;
    e dd 4;
    x dq 5;
    
    
segment  code use32 class=code ; code segment
start: 

    ; (100+a+b*c)/(a-100)+e+x/a
    
    ; (100+a+b*c)
    mov AL, [b];
    CBW;
    imul word [c];
    mov BL, [a];
    add BL, 100;
    mov BH, 0;
    add AX,BX;
    adc DX,0;
    
    ; (a-100)
    mov BL, [a];
    sub BL, 100;
    mov BH,0;
    
    ; (100+a+b*c)/(a-100)
    push DX;
    idiv BX;
    
    
    ; (100+a+b*c)/(a-100) + e
    CWD;
    add AX, word [e]
    adc DX, word [e+2]
    mov BX, AX;
    mov CX, DX;
    
    ; x/a
    mov EAX, dword [x]
    mov EDX, dword [x+4]
    idiv byte [a];
    
    ; (100+a+b*c)/(a-100)+e+x/a
    add AX, BX;
    adc DX, CX;
    
    
     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	
     
     