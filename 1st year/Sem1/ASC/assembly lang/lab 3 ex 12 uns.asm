
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
    
    a db 30h;
    b dw 20h;
    c dd 10h
    d dq 40h
    
segment  code use32 class=code ; code segment
start: 

    ; (a-b-c) + (d-b-c) - (a-d)
    
    ; (a-b-c)
    mov AL, [a];
    CBW;
    sub AX, [b];
    CWD;
    sub AX, word [c]
    sub DX, word [c+2]
    mov BX,AX;
    mov CX,DX;
 
    ; (d-b-c)
    mov EAX, dword[d];
    mov EDX, dword[d+4];
    sub AX, [b];
    sub AL, [a];
    
    ; (a-b-c) + (d-b-c)
    add AX, BX;
    adc DX, CX;
    mov EBX,EAX;
    mov ECX,EDX;
    
    ; (a-d)
    mov AL, [a];
    CBW;
    CWDE;
    CDQ;
    sub EAX, dword [d];
    sbb EDX, dword [d+4];
    
    ; (a-b-c) + (d-b-c) + (a-d)
    add EAX, EBX;
    adc EDX, ECX;
    
    
     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	