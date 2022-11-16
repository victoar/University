bits 32

extern _string1, _string2

segment data public data use32

segment code use32 public code

; declare the strings procedure as global so it can be used in the C module
global _strings
    
_strings:
    
        push ebp
        mov ebp, esp
        ; ebp = esp -> caller ebp
        ; ebp+4 -> ret address
        ; ebp +8 -> length
        ; ebp + 12 string4
        ; ebp + 16 string3 
        mov esi, _string1 ; ESI = address of string1
        mov edi, [ebp+16] ; EDI = address of string3
        mov ecx, [ebp+8] ; ECX = len = 4
        cld ; sets the direction flag to 0 -> parse from left to right
        ; put the characters from string1 in even positions in string3
        repeta1:
        lodsb ; load a byte from string1 in AL
        ; checks if the character is a letter
        cmp al, 'a'
        jb other1
        cmp al, 'z'
        ja other1
        ; if the character is a letter then it copies it to string3
        stosb
        jmp next1
        ; if the charecter is not a letter then it is replaced with a space in string3
        other1:
        mov al, 32
        stosb
        
        next1:
        ; skip the odd positions
        inc edi
        loop repeta1
        
        mov esi, _string2 ; ESI = address of string2
        mov edi, [ebp+16] ; EDI = address of string3
        mov ecx, [ebp+8] ; ECX = len = 7
        ; put the characters from string2 in odd positions in string3
        repeta2:
        inc edi; skip the even positions
        lodsb ; load a byte from string2 in AL
        ; checks if the character is a letter
        cmp al, 'a'
        jb other2
        cmp al, 'z'
        ja other2
        ; if the character is a letter then it copies it to string3
        stosb
        jmp next2
        ; if the charecter is not a letter then it is replaced with a space in string3
        other2:
        mov al, 32
        stosb

        next2:
        loop repeta2
        
        mov esi, _string2 ; ESI = address of string2
        mov edi, [ebp+12] ; EDI = address of string4
        mov ecx, [ebp+8] ; ECX = len = 4
        cld ; sets the direction flag to 0 -> parse from left to right
        ; put the characters from string2 in even positions in string4
        repeta3:
        lodsb ; load a byte from string2 in AL
        ; checks if the character is a letter
        cmp al, 'a'
        jb other3
        cmp al, 'z'
        ja other3
        ; if the character is a letter then it copies it to string4
        stosb
        jmp next3
        ; if the charecter is not a letter then it is replaced with a space in string4
        other3:
        mov al, 32
        stosb

        next3:
        ; skip the odd positions
        inc edi
        loop repeta3
        
        mov esi, _string1 ; ESI = address of string1
        mov edi, [ebp+12] ; EDI = address of string4
        mov ecx, [ebp+8] ; ECX = len = 4
        ; put the characters from string1 in odd positions in string4
        repeta4:
        ; skip the even positions
        inc edi
        ; load a byte from string1 in AL
        lodsb
        ; checks if the character is a letter
        cmp al, 'a'
        jb other4
        cmp al, 'z'
        ja other4
        ; if the character is a letter then it copies it to string4
        stosb
        jmp next4
        ; if the charecter is not a letter then it is replaced with a space in string4
        other4:
        mov al, 32
        stosb

        next4:
        loop repeta4
        
        
        mov esp, ebp ; restore esp
        pop ebp ; restore ebp

        ; jump back to the return address kept on the stack and clears the stack from the parameters of the procedure
        ret 4*4
        