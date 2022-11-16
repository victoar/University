; Given the doubleword A, obtain the integer number n represented on the bits 14-17 of A. Then obtain the doubleword B by rotating A n positions to the ; left. Finally, obtain the byte C as follows:
; the btis 0-5 of C are the same as the bits 1-6 of B
; the bits 6-7 of C are the same as the bits 17-18 of B

bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
     A dd 0111_0111_0101_0111_0000_0100_1100_0001b
     B resd 1
     c dw 0
segment  code use32 class=code ; code segment
start: 

     
     ; Given the doubleword A, obtain the integer number n represented on the bits 14-17 of A. Then obtain the doubleword B by rotating A n positions to the left
     mov  EAX, 0000_0000_0000_0011_1100_0000_0000_0000b ; 
     and EAX, [A]; get the bits from 14 to 17 and we put them in EAX
     ror EAX, 14; get the bits in which we are interested in AL
     mov EBX, [A]; 
     mov CL, AL;
     rol EBX, CL;
     
     ; we compute the result in ECX
     mov ECX, 0;
     
     ; the btis 0-5 of C are the same as the bits 1-6 of B
     mov EAX, EBX;
     and EAX, 0000_0000_0000_0000_0000_0000_0111_1110b
     mov CL, 1;
     ror EAX, CL;
     or ECX, EAX;
     
     ; the bits 6-7 of C are the same as the bits 17-18 of B
    mov EAX, EBX;
    and EAX, 0000_0000_0000_0110_0000_0000_0000_0000b
    mov CL, 11;
    ror EAX, CL;
    or ECX, EAX;
     
     

     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	
