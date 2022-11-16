bits 32           

global factorial1             

segment code use32 public code

factorial1:

	mov esi, dword [esp+4]; a
    mov ebx, 0; counter for c positions
    mov edi, dword [esp+8]; c 
    mov ecx, dword [esp+12]; len of a
     jecxz endFor2
     forIndex2:
         lodsb
         cmp al, 61h
         jl noLowercase
         cmp al, 7ah
         jg noLowercase
         mov [edi+ebx], al
         inc ebx
        noLowercase:
     loop forIndex2
     endFor2:
	
	ret