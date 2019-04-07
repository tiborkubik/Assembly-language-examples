%include "rw32-2018.inc"
     
; Spocitej pocet znaku v retezci, vysledek do registru A.
; Autor: Ing. Martin Sakin
     
section .data
    pStr1 db "nejaky retezec",0
     
section .text
my_strlen:
; int strlen(const char *s);
    push ebp
    mov ebp, esp
    xor eax, eax
    ; your code
    mov ecx, -1
    mov edi, pStr1
    mov al, 0
    
    repne scasb ;opakuj, dokym nebude v stringu 0, zaroven dekrementuje ecx
    
    neg ecx     ; v ecx mam negativnu verziu poctu znakov, zaroven je potrebne odobrat 2, pretoze sme zacali na -1 a ratali sme aj EOL
    sub ecx, 2
    
    mov eax, ecx
    
    pop ebp
    ret
     
CMAIN:
    call my_strlen
    call WriteInt32
    call WriteNewLine
    ret

