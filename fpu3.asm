; Ukol 3:
; Vypocitej ((6*a - 3*b*(c+d))*(a-d))/a+sqrt(b*c+cos(a))
; Autor: Dominika Regeciova

%include "rw32-2018.inc"

section .data
a dd 8.0
b dd 5.0
c dd 3.0
d dd 2.0

trojka dd 3.0
sestka dd 6.0

bFormat db "%f",0

section .bss
    var resd 1

section .text

_main:

    finit               ; inicializace jednotky FPU
    
                        ;      st0          st1         st2        st3
    fld dword [b]       ;       b            -            -          -
    fld dword [c]       ;       c            b            -          -
    fmulp               ;      c*b           -            -          -
    fld dword [a]       ;       a           c*b           -          -
    fcos                ;    cos(a)         c*b           -          -
    faddp               ;   cos(a)+b*c       -            -          -
    fsqrt               ; sqrt(cos(a)+b*c)   -            -          -
    fld dword [c]       ;       c     sqrt(cos(a)+b*c)    -          -
    fld dword [d]       ;       d            c     sqrt(cos(a)+b*c)  -
    faddp               ;      c+d    sqrt(cos(a)+b*c)    -          -
    fld dword [b]       ;       b           c+d    sqrt(cos(a)+b*c)  -
    fmulp               ;    b*(c+d)  sqrt(cos(a)+b*c)    -          -
    fld dword [trojka]  ;       3        b*(c+d)   sqrt(cos(a)+b*c)  -
    fmulp               ;   3*b*(c+d) sqrt(cos(a)+b*c)    -          -
    fld dword [sestka]  ;       6       3*b*(c+d)  sqrt(cos(a)+b*c)  -
    fld dword [a]       ;       a            6        3*b*(c+d)  sqrt(cos(a)+b*c)
    fmulp               ;      6*a      3*b*(c+d)  sqrt(cos(a)+b*c)  -
    fxch                ;   3*b*(c+d)       6*a    sqrt(cos(a)+b*c)  -
    fsubp               ; 6*a - 3*b*(c+d) sqrt(cos(a)+b*c)-          -
    fld dword [a]       ;       a    6*a - 3*b*(c+d) sqrt(cos(a)+b*c)-
    fld dword [d]       ;       d           a     6*a-3*b*(c+d) sqrt(cos(a)+b*c)
    fsubp               ;      a-d    6*a-3*b*(c+d) sqrt(cos(a)+b*c) -
    fmulp               ;(6*a - 3*b*(c+d))*(a-d)  sqrt(cos(a)+b*c) 6*a - 3*b*(c+d) - -
    fxch                ;sqrt(cos(a)+b*c) (6*a - 3*b*(c+d))*(a-d) -          -
    fld dword [a]       ;       a    sqrt(cos(a)+b*c) (6*a - 3*b*(c+d))*(a-d)
    faddp               ;  a+sqrt(cos(a)+b*c) (6*a - 3*b*(c+d))*(a-d)
    fdivp               ;
    
next:                   ; vypis vysledku z st0 pomoci funkce printf
    sub esp, 8
    fst qword [esp]
    push bFormat
    call printf
    add esp, 12
ret
