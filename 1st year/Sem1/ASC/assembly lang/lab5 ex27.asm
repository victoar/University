
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
     s1 db '1', '3', '6', '2', '3', '2' ; declare the string of bytes
     s2 db '6', '3', '8', '1', '2', '5' ; 
	 l equ $-s2 ; compute the length of the string in l
	 d times l db 0 ; reserve l bytes for the destination string and initialize it
segment  code use32 class=code ; code segment
start: 

     ; Two byte strings S1 and S2 of the same length are given. Obtain the string D where each element is the difference of the corresponding elements from S1 and S2
     ; The result should be D: -5, 0, -2, 1, 1, -3
     ;                         FB,00, FE,01,01, FD 

     mov ecx, l ; we put the length l in ECX in order to make the loop
	 mov esi, 0     
	 jecxz endFor      
	 forIndex
		mov al, [s1+esi]
		mov bl, [s2+esi] 
		sub al, bl             
		mov [d+esi], al    
		inc esi
	 loop forIndex
	 endFor;end of the program
     mov eax, dword [d];
     mov edx, dword [d+4];
    

     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	
