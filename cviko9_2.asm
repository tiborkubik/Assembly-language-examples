%include "rw32-2018.inc"
; Autor: Ing. Marta Jaros

section .data
    string1 db "ahoj, ja jsem tvuj bozacky testovaci retezec!", 0

section .bss  
    string2 resb 50
    
section .text
_main:
    push ebp
    mov ebp, esp
    
    xor eax, eax
    
    mov esi, string1 ; adresa string1 predavana funkci ReverseCopy pres registr ESI
    call ReverseCopy
    mov esi, string2
    call WriteString
    call WriteNewLine

    pop ebp
    ret

CountLength:
; Implementujete proceduru EAX CountLength(ESI), ktera na vstupu ocekava ukazatel na retezec 
; ukonceny nulou. Tento ukazatel ji predejete pomoci registru ESI. Funkce vraci vysledek v EAX. 
; Procedura vypocte delku retezce (ukazatel na nej je predany pres ESI) - ukoncovaci nula se nepocita
; do delky retezce. 
; Pouzijte vhodnou retezovou instrukci a instrukci rep.
; Provedte zalohu a obnovu registru, ktere pouzivate (az na eax - proc?) pomoci push a pop.
    
    ; ZDE DOPLNTE SVUJ KOD
    push ebp
    mov ebp, esp

    xor eax, eax
    ; your code
    mov ecx, -1
    mov edi, string1
    mov al, 0
    
    repne scasb ;opakuj, dokym nebude v stringu 0, zaroven dekrementuje ecx
    
    neg ecx     ; v ecx mam negativnu verziu poctu znakov, zaroven je potrebne odobrat 2, pretoze sme zacali na -1 a ratali sme aj EOL
    sub ecx, 2
    
    pop ebp
    ret

ReverseCopy:
; Implementujte proceduru void ReverseCopy(ESI);
; Procedura modifikuje promennou string2 v pameti, do ktere zapisuje prevraceny retezec.
; Vyuzijte instrukci LODS? a STOS?
; Pro vypocet adresy, kterou budou pouzivat tyto instrukce pouzijte instrukce LEA.
; Procedura pracuje podle nasledujiciho pseudokodu:
; i = 0
; eax = CountLength()
; for (ecx = eax; ecx > 0; ecx--)
; {
;    char a = string1[ecx-1]; // vynechavame nulu na konci retezce
;    string2[i] = a;
;    i++;
; }
; Napoveda: Diky retezovym instrukcim se nemusime zabyvat indexy, pouze musite mit nejaky counter,
;           diky kteremu vite, zda zpracovavat dalsi znak nebo jiz muzete skoncit
;           Pomoci vhodnych instrukci mente DF.
  
    ; ZDE DOPLNTE SVUJ KOD
    push ebp
    mov ebp, esp
    
    call CountLength    ; ECX = dlzka stringu

    mov edx, 0
    
    xor eax, eax
    mov edi, string2

for:
    mov esi, string1  
    mov edi, string2
    
    lea esi, [esi+ecx-1]
    lodsb
    lea edi, [edi+edx]
    stosb
    inc edx
    
    LOOP for

    pop ebp
    ret