

bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
    
    a db 10h;
    b dw 20h;
    c dd 15h
    d dq 40h
    
segment  code use32 class=code ; code segment
start: 

    ; (a+c) - (d+b)
    mov EAX, 0;
    mov EDX, 0;
    mov AL, [a];
    mov AH, 0;
    add AX, word [c];
    mov DX, word [c+2];    
 
    
    mov EBX, dword [d]
    mov ECX, dword [d+4]
    
    add BX,[b]
    
    sub EAX, EBX;
    sub EDX, ECX;
    
    
    
    
    

     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	