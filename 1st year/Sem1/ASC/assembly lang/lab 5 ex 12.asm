
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it
import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
     s1 db 'a', 'b', 'c', 'd', 'e', 'f' ; declare the string of bytes
     s2 db '1', '2', '3', '4', '5' ; 
	 l1 equ $-s1 ; compute the length of the string 1 in l1
     l2 equ $-s2 ; compute the length of the string 2 in l2
	 d times l1 db 0 ; reserve l1+l2 bytes for the destination string and initialize it
segment  code use32 class=code ; code segment
start: 

     ; Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements found on even positions in S2 and the elements ; ; ; found on odd positions in S1.
     ; The result should be D: '2','4','a','c','e'
     ;                          32, 34, 61, 63, 65
     
     mov ecx, l2 ; we put the length l2 in ECX in order to make the loop
	 mov esi, 0 ;
     mov ebx, 0 ; the position in which we will put the numbers in d
	 jecxz endFor      
	 forIndex
        mov ax, 0;
		mov edx, esi;
        mov al, dl;
        mov dl, 2; division by 2 to see if the number is even or odd 
        div dl;
        mov al, 1;
        cmp ah,al;
        jne evenPos
        mov al, [s2+esi]
		mov [d+ebx], al;
        inc ebx;
        evenPos:
		inc esi
	 loop forIndex
	 endFor:
     
     mov ecx, l1 ; 
     sub ecx, l2 ; we put the length l1 in ECX in order to make the loop
     mov esi, 0;
     
	 jecxz endFor1      
	 forIndex1
        mov ax, 0;
        mov edx, esi;
		mov al, dl;        
		mov dl, 2; division by 2 to see if the number is even or odd
        div dl;
        mov al, 0
        cmp al,ah
        jne oddPos
        mov al, [s1+esi]
        mov [d+ebx], al;
        inc ebx;
        oddPos:
        inc esi
	 loop forIndex1
	 endFor1:
     mov eax, dword [d]
     mov edx, dword [d+4]

     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution ofthe program	
