
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
    
    a dd 125;
    b db 2;
    c db 1,2,3,4;
    d db '1234';
    e db '1,2,3,4';
    f db '1',',','2''
    g db 'a';
    
    
segment  code use32 class=code ; code segment
start: 

    mov ax, [e];
        
    
     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	
     
     