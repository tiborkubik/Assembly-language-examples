%include "rw32-2018.inc"

section .data
pA dd 23, 140, 13, 349, 2

section .text
CMAIN:
    mov ebp, esp
    
    mov esi, pA
    mov ecx, 5
    mov ebx, 23
    
    push esi
    push ecx
    push ebx
    
    call function
    
    ret

function:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8]
    mov ecx, [ebp+12]   ;dlzka
    mov esi, [ebp+16]
    
    xor eax, eax
    
    dec ecx
    for:
        cmp ebx, [esi+ecx*4]
        jne endif
        mov eax, [esi+ecx*4]
        jmp endd
        
        endif:
        
        LOOP for
        
    cmp ebx, [esi]
    jne endd
    mov eax, [esi]
    
    endd:
    
    pop ebp
    ret 12
