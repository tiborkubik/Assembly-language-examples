%include "rw32-2018.inc"
; autor: Marta Jaros
; upravila Dominika Regeciova

section .data
    ; Zobrazte si v debuggeru
    a dq 12.123 ; double
    b dd 5.0    ; float
    c dd -12.5  ; float
    d dd 333    ; integer

section .bss
    var resd 1

section .text
_main:
    push ebp
    mov ebp, esp
    
    finit ; inicializace jednotky FPU
    
    fld qword [a]       ; st0 = a, st1 = ?, st2 = ?
    fld dword [b]       ; st0 = b, st1 = a, st2 = ?
    ; Stejnym zpusobem vlozte do FPU cislo "c"
    ; V jakem registru se nachazi "a" a "b"? 
    fld dword [c]       ; st0 = c, st1 = b, st2 = a
    
    
    
    fld st1 ; pozorujte v debuggeru
    fild dword [d] ; vlozime integer
                   ; st0 = d, st1 = b, st2 = c, st3 = b, st4 = a
                   ; !! FILD cte pouze z pameti !! Jina kombinace neni povolena.
                   
    ; pomoci instrukce FST/FIST zkuste hodnotu d (st0 registr) ulozit do pameti do promenne var
    ; ovlivnilo to nejak registr st0?
    fst dword [var]
    
    mov [var], dword 0    
    ; provedte stejnou operaci, tentokrat ale pomoci FSTP/FISTP
    ; co znamena P v jmenu instrukce? Co se stalo s st0?
    FSTP dword [var]
    
                                  
    pop ebp
    ret