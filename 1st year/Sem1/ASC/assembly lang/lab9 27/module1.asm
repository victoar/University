bits 32

global factorial
                         
segment code use32 public code

factorial:

	mov esi, dword [esp+4]; a
    mov ebx, 0; counter for b positions
    mov edi, dword [esp+8]; b
    mov ecx, dword [esp+12]; len of a
     jecxz endFor1
     forIndex1:
         lodsb
         cmp al, 41h
         jl noUppercase
         cmp al, 5ah
         jg noUppercase
         mov [edi+ebx], al
         inc ebx
        noUppercase:
     loop forIndex1
     endFor1:
    
	ret