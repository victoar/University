bits 32

global modul2
                         
segment code use32 public code

modul2:

    mov edi, dword [esp+12]; d
    mov ecx, dword [esp+16]; len
    mov ebx, 0
    mov edx, 0
    jecxz endFor1
    forIndex1:
        mov esi, dword [esp+8]; b
        mov al, [esi+edx]
        ; checking if in al is a character
        cmp al, 'a'
        jb other
        cmp al, 'z'
        ja other
        mov [edi+ebx], al
        jmp next
        other:
        mov al, 32
        mov [edi+ebx], al
        next:
        inc ebx
        mov esi, dword [esp+4]; a
        mov al, [esi+edx]
        ; checking if in al is a character
        cmp al, 'a'
        jb other1
        cmp al, 'z'
        ja other1
        mov [edi+ebx], al
        jmp next1
        other1:
        mov al, 32
        mov [edi+ebx], al
        next1:
        inc ebx
        inc edx
    loop forIndex1
    endFor1:
    
    ret