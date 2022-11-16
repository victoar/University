
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
    
    a db 1;
    b dw 2;
    c db 3;
    d dd 4;
    x dq 5;
    
    
segment  code use32 class=code ; code segment
start: 

    ; (a*b+2) / (a+7-c) + d + x
    
    ; (a*b+2)
    mov AL, [a];
    CBW;
    imul word [b];
    add AX, 2;
    
    ; (a+7-c)
    mov BL, [a];
    add BL, 7;
    sub BL, [c];
    mov BH,0;
    
    ; (a*b+2) / (a+7-c)
    push DX;
    idiv BX;
    
    ; (a*b+2) / (a+7-c) + d
    CWD;
    pop DX;
    add AX, word [d]
    adc DX, word [d+2]
    
    ; (a*b+2) / (a+7-c) + d + x
    CWDE;
    CDQ;
    add EAX, dword [x];
    adc EDX, dword [x+4];
    
    
     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	