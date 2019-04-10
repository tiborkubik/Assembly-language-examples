%include "rw32-2018.inc"

section .data
pole dd 3, 2, 6, 5

section .text
CMAIN:
    mov ebp, esp
    
    mov esi, pole
    mov ecx, 4
    
    push esi
    push ecx
    
    call sort
    
    ret
    
sort:
    push ebp
    mov ebp, esp
    
    push eax
    
    mov ecx, [ebp+8]
    mov esi, [ebp+12]
    
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    xor edi, edi
    
    for1:
        cmp eax, ecx
        jnl end_for1
        
        mov ebx, eax
        inc ebx
        for2:
            
            cmp ebx, ecx
            jnl end_for2
            
            mov edx, [esi+eax*4]
            cmp edx, [esi+ebx*4]
            jng end_if1
            
            push ecx
            
            mov edi, [esi+eax*4] ;edi=tmp
            mov ecx, [esi+ebx*4]
            
            mov [esi+eax*4], ecx
            mov [esi+ebx*4], edi
            
            pop ecx
            
            end_if1:
            
            inc ebx
            jmp for2        
        
        end_for2:
                        
        inc eax
        jmp for1
    
    end_for1:
    
    pop eax
    
    pop ebp
    ret 8
