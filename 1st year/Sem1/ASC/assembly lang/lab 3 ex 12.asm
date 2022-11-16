
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
    
    a db 30h;
    b dw 20h;
    c dd 15h
    d dq 40h
    
segment  code use32 class=code ; code segment
start: 

    ; (a+b+d) - (a-c+d) + (b-c)
    
    ; (a+b+d)
    mov EAX, 0;
    mov EDX, 0;
    mov AL, [a];
    add AX, [b];
    add EAX, dword [d];
    adc EDX, dword [d+4];    
 
    ; (a-c+d)
    mov EBX, 0;
    mov ECX, 0;
    mov BL, [a];
    mov BH, 0;
    sub BX, word [c];
    sub CX, word [c+2];
    add EBX, dword [d]
    adc ECX, dword [d+4]
    
    ; (a+b+d) - (a-c+d)
    sub EAX, EBX;
    sub EDX, ECX;
    
    ; (b-c)
    mov BX, [b];
    mov CX, 0;
    sub BX, word [c];
    sub CX, word [c+2];
    
    ; (a+b+d) - (a-c+d) + (b-c)
    add AX, BX;
    add DX, CX;
    
    
     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	