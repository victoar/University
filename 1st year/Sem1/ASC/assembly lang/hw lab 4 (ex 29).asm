; the bits 0-7 of C are the same as the bits 21-28 of A
; the bits 8-15 of C are the same as the bits 23-30 of B complemented
; the bits 16-21 of C have the value 101010
; the bits 22-31 of C have the value 0
; the bits 32-42 of C are the same as the bits 21-31 of B
; the bits 43-55 of C are the same as the bits 1-13 of A
; the bits 56-63 of C are the same as the bits 24-31 of the result A XOR 0ABh


bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
     A dd 0111_0111_0101_0111_0000_0100_1100_0001b
     B dd 0011_1001_0100_0011_0001_1100_0000_0100b
     c resd 1
segment  code use32 class=code ; code segment
start: 

     ; we put the result in EBX:ECX
     mov EBX, 0;
     mov ECX, 0;
     
     ; the bits 0-7 of C are the same as the bits 21-28 of A
     mov EAX, [A];
     and EAX, 0001_1111_1110_0000_0000_0000_0000_0000b
     ror EAX, 21;
     or ECX, EAX;
     
     ; the bits 8-15 of C are the same as the bits 23-30 of B complemented
     mov EAX, [B];
     not EAX;
     add EAX, 1;
     and EAX, 0111_1111_1000_0000_0000_0000_0000_0000b
     ror EAX, 15;
     or ECX, EAX;
     
     ; the bits 16-21 of C have the value 101010
     or ECX, 0000_0000_0010_1010_0000_0000_0000_0000b
     
     ; the bits 22-31 of C have the value 0
     or ECX, 0000_0000_0000_0000_0000_0000_0000_0000b
     
     ; the bits 32-42 of C are the same as the bits 21-31 of B
     mov EAX, [B];
     and EAX, 1111_1111_1110_0000_0000_0000_0000_0000b
     ror EAX, 21;
     or EBX, EAX;
     
     ; the bits 43-55 of C are the same as the bits 1-13 of A
     mov EAX, [A];
     and EAX, 0000_0000_0000_0000_0011_1111_1111_1110b
     rol EAX, 10;
     or EBX, EAX;
     
     ; the bits 56-63 of C are the same as the bits 24-31 of the result A XOR 0ABh
     mov EAX, [A];
     xor EAX, 0000_0000_0000_0000_0000_0000_1010_1011b
     and EAX, 1111_1111_1000_0000_0000_0000_0000_0000b
     or EBX, EAX;
    

     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	
