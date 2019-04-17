; Ukol 2:
; Vypocitej a^2-c a sqrt(b)+c a vypis vetsi vysledne cislo
; Autor: Dominika Regeciova

%include "rw32-2018.inc"

section .data
a dd 8.0
b dd 25.0
c dd 3.0

bFormat db "%f",0

section .bss
    var resd 1

section .text

_main:
    xor eax, eax
    
    finit               ; inicializace jednotky FPU
    
    fld dword [c]       ; st0       st1         st2 
                        ;  c         -           -  
    fld dword [a]       ;  a         c           -
    fld dword [a]       ;  a         a           c
    fmulp st1, st0      ; a*a        c           -
    fxch st1            ;  c        a*a          -
    fsubp               ; a*a-c      -           -
                        ;  -         -           -
    fstp dword [var]    ;  -         -           -
                        ;  -         -           -
    fld dword [c]       ;  c         -           -
    fld dword [b]       ;  b         c           -
    fsqrt
    faddp
    
    fcom dword [var]
    FSTSW AX
    sahf
    
next:                   ; vypis vysledku z st0 pomoci funkce printf
    sub esp, 8
    
    fst qword [esp]
    push bFormat
    call printf
    add esp, 12
ret
