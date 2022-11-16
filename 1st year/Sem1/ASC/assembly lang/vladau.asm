bits 32 ; assembling for the 32 bits architecture
 
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
 
; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
 
extern printf                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
 
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sir1 db "alina",0
    lungsir1 db $-sir1-1
    sir2 db "dragalina",0
    lungsir2 db $-sir2-1
    sir3 db "banana",0
    lungsir3 db $-sir3-1
    lungime db 0
    rezultat times 50 db 0
    rezultat_final times 50 db 0
    format1 db "Sufixul de lungime maxima, comun este: %s \n", 0
    contor db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
 
            ; call exit to terminate the program
    mov cl, [lungsir1]
    mov bl, [lungsir2]
    cmp cl, bl; vedem care sir este mai scurt
    jb .lung1
    mov cl, bl
    .lung1:
    mov esi, sir1
    mov edi, sir2
 
    mov [contor], cl
    dec byte[contor]
    mov ebx, [contor]
 
    .for1:
    push edx
    mov al, [esi+ebx]
    mov dl, [edi+contor]
    cmp al, dl; verificam daca literele sunt egale
    jne .break1
    pop edx
    mov [edx+lungime], al
    dec byte[contor]
    inc byte[lungime]
    loop .for1
 
    .break1:
    MOV ESI, edx
    MOV EDI, rezultat_final
    mov ecx, 0
    MOV cl, [lungime] 
 
    dec byte[lungime]
    add ESI, [lungime] 
 
    Jecxz .Final 
    .Repeta: 
    Std 
    Lodsb 
    cld 
    Stosb 
    Loop .Repeta 
    .Final: 
 
    push rezultat_final
	push format1
	call [printf]
	add esp, 2*4
 
      ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit] 