bits 32

segment data public data use32

segment code use32 public code

; declare the strings procedure as global so it can be used in the C module
global _strings
    
_strings:

        push ebp
        mov ebp, esp
        
        mov esi, dword [esp+20]; a
        mov ebx, 0; counter for b positions
        mov edi, dword [esp+16]; b
        mov ecx, dword [esp+8]; len of a
        cld
         jecxz endFor1
         forIndex1:
             lodsb; loads a byte in al which should represent a character
             ; checks if the character is an uppercase
             cmp al, 41h
             jl noUppercase
             cmp al, 5ah
             jg noUppercase
             stosb; stores the character in edi which is b if and only if the character is an uppercase
             inc ebx
            noUppercase:
         loop forIndex1
         endFor1:
         
        mov esi, dword [esp+20]; a
        mov ebx, 0; counter for c positions
        mov edi, dword [esp+12]; c 
        mov ecx, dword [esp+8]; len of a
        cld
         jecxz endFor2
         forIndex2:
             lodsb; loads a byte in al which should represent a character
             ; checks if the character is a lowercase
             cmp al, 61h
             jl noLowercase
             cmp al, 7ah
             jg noLowercase
             stosb; stores the character in edi which is c if and only if the character is a lowercase 
             inc ebx
            noLowercase:
         loop forIndex2
         endFor2:
         
         mov esp, ebp ; restore esp
         pop ebp ; restore ebp
         
         ret 4*5