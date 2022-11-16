
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
    
    a db -30;
    b dw 20;
    c dd 10;
    d dq 40;
    
segment  code use32 class=code ; code segment
start: 

    ; (d+d-c) - (c+c-a) + (c+a)
    
    ; (d+d-c)
    mov EAX, dword [d];
    mov EDX, dword [d+4];
    add EAX, dword [d];
    adc EDX, dword [d+4];
    sub AX, word [c];
    sbb DX, word [c+2];
    mov EBX, EAX;
    mov ECX, EDX;
 
    ; (c+c-a)
    mov AX, word[c];
    mov DX, word[c+2];
    add AX, word[c];
    adc DX, word[c+2];
    sub AL, [a];
    CBW;
    CWD;
    
    ; (d+d-c) - (c+c-a)
    sub BX, AX;
    sbb CX, DX;
    
    ; (c+a)
    mov AX, word[c];
    mov DX, word[c+2]
    add AL, [a];
    CBW;
    
    
    ; (d+d-c) - (c+c-a) + (c+a)
    add BX, AX;
    adc CX, DX;
    
    
     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	