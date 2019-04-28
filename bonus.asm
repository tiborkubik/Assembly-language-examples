%include "rw32-2018.inc"
; Bonusova uloha do predmetu ISU 2018/2019
; Zadani: Implementujte algoritmy pro razeni pole Bubblesort a Selection sort
; Deadline: 1. 5. 2019 23:59
; Reseni posilejte na iregeciova@fit.vutbr.cz s predmetem ISU: bonus 
; Za ulohu lze ziskat 1 bod, hodnocena bude spravnost i upravenost kodu a komentare 

section .data
    ARRAY DD 4, -2, 1, 5, 0, 42, 3, -44, 1894, 7 ; vstupni pole
    ARRAY_SIZE DD 10 ; velikost vstupniho pole
    
    STR_SPACE DB " ", 0, EOL
    STR_UNSORTED_ARR DB "Neserazene pole: ", 0, EOL
    STR_SORTED_ARR DB "Serazene pole: ", 0, EOL

section .text
; Funkcia CMAIN
; =============================================
;
; Popis: Funkcia vola jednotlive funkcie programu,
; teda vdaka nej sa vypise nezoradene pole, potom prebehne sorting metoda
; a nakoniec sa vypise nezoradene pole
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    
    
    ; === Vypis neserazeneho pole ===
        mov esi, STR_UNSORTED_ARR
        call WriteString
        call WriteNewLine
    ; == Koniec vypisu ==
    
    
    ; === Volanie funkcie printArray ===
        mov esi, ARRAY
        mov ecx, [ARRAY_SIZE]
        
        push esi                ; Predavanie argumentov funkcii printArray
        push ecx
        call printArray         ; Samotne volanie funkcie printArray
    ; == Koniec volania ===
    
    
    ; === Volani funkce Bubblesort alebo funkce Selectionsort ===
        mov esi, ARRAY
        mov ecx, [ARRAY_SIZE]
        
        push esi
        push ecx
        
        call Selectionsort
    ; == Koniec volania ==
    
    
    ; === Vypis serazeneho pole ===
    mov esi, STR_SORTED_ARR
    call WriteString
    call WriteNewLine
    ; == Koniec vypisu ==
    
    
    ; === Volanie funkcie printArray ===
    mov esi, ARRAY
    mov ecx, [ARRAY_SIZE]
    
    push esi
    push ecx
    call printArray
    ; == Koniec volania ==
    
    pop ebp
    ret


; Funkcia printArray
; =============================================
;
; Popis: Funkcia vypise jednotlive prvky pola oddelene medzerou na konzolu
;
; Parameter1: Dlzka pola(pocet prvkov)
;
; Parameter2: Ukazatel na prvu polozku pola
printArray:
    mov ebp, esp
    push ebp
    
    mov ecx,[esp+8]
    mov edi,[esp+12]
    xor edx, edx
    
    ; Vytlacime kazdy prvok pola
    while:
        cmp edx, ecx
        jnl end_while
        
        mov eax, [edi+edx*4]
        call WriteInt32
        mov esi, STR_SPACE
        call WriteString            ; Vytlacenie medzery medzi prvkami pola
        inc edx
        jmp while
    
    end_while:
    call WriteNewLine               ; Pre prehlednost na konci tiskneme prazdny riadok
        
    pop ebp
    ret 8


; Funkcia Bubblesort
; ============================================
;
; Popis: Implementacia radiaceho algoritmu s nazvom Bubblesort
;
; Parameter1: Dlzka pola(pocet prvkov)
;
; Parameter2: Ukazatel na prvu polozku pola
;
; Return: Zoradene pole od najmensieho prvku po najvacsi
Bubblesort:
    
    ; Fragment C kodu:
    ;----------------------------------------
    ; for(int i = 0; i < N; i++){           |
    ;   for(int j = i + 1; j < N; j++) {    |
    ;       if(pole[i] < pole[j]) {         |
    ;           tmp = pole[i];              |
    ;           pole[i] = pole[j];          |
    ;           pole[j] = tmp;              |
    ;       }                               |
    ;   }                                   |
    ; }                                     |
    ;----------------------------------------
    mov ebp, esp
    push ebp
    
    mov ecx, [esp+8]        ; pole.length
    mov esi, [esp+12]       ; pole
    
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    xor edi, edi
    
    for1:
        cmp eax, ecx    ;podmienka vonkajsieho cyklu
        jnl end_for1
        
        mov ebx, eax
        inc ebx         ; ebx = j = i + 1
        for2:
            
            cmp ebx, ecx ; podmienka vnoreneho cyklu
            jnl end_for2
            
            mov edx, [esi+eax*4]
            cmp edx, [esi+ebx*4]
            jng end_if1
            
            ; === Vymena prvkov ===
            push ecx
            
            mov edi, [esi+eax*4] ; edi = tmp = pole[i]
            mov ecx, [esi+ebx*4]
            
            mov [esi+eax*4], ecx
            mov [esi+ebx*4], edi
            
            pop ecx
            ; == Koniec vymeny ==
            
            end_if1:
            
            inc ebx
            jmp for2        
        
        end_for2:
                        
        inc eax
        jmp for1
    
    end_for1:
    
    pop ebp
    ret 8


; Funkcia Selectionsort
; ============================================
;
; Popis: Implementacia radiaceho algoritmu s nazvom Selection
;
; Parameter1: Dlzka pola(pocet prvkov)
;
; Parameter2: Ukazatel na prvu polozku pola
;
; Return: Zoradene pole od najvacsieho prvku po najmensi
Selectionsort:
    
    ; Fragment C kodu:
    ;------------------------------------------------
    ; for(int index = 0; index < n-1; index++) {    |
    ;    int max_idx = index;                       |
    ;                                               |
    ;    for(int j = index+1; j < n; j++)           |
    ;        if(data[j] > data[min_idx])            |
    ;           max_idx = j;                        |
    ;                                               |
    ;    int temp = data[max_idx];                  |
    ;    data[max_idx] = data[index];               |
    ;    data[index] = temp;                        |
    ; }                                             |
    ;------------------------------------------------
    
    mov ebp, esp
    push ebp
    
    mov ecx, [esp+8]    ; n = 10;
    mov esi, [esp+12]
    
    xor eax, eax        ; index = 0;
    xor ebx, ebx        ; j = 0;
    xor edx, edx        ; max_idx = 0;
    xor edi, edi
    
    .for1:; {
        dec ecx
        cmp eax, ecx
        jnl .endfor1
        inc ecx
        
        mov edx, eax    ; max_idx = index;
        
        mov ebx, eax    ; j = index;
        inc ebx         ; j = index+1;
        
        .for2:; {
            cmp ebx, ecx
            jnl .endfor2
            
            mov edi, [esi+ebx*4]
            
            cmp edi, [esi+edx*4] ; if(data[j] > data[min_idx])
            jng .endif1; {
            
            mov edx, ebx    ; max_idx = j;
;           }
            .endif1:
            
            inc ebx
            jmp .for2 
;       }
        .endfor2:    
        
        ; === Vymena prvkov ===
        push ecx
        push edi
            
        mov edi, [esi+edx*4] ; edi = tmp = pole[max_idx]
        mov ecx, [esi+eax*4] ; ecx = pole[index]
           
        mov [esi+edx*4], ecx ; pole[max_idx] = pole[index]
        mov [esi+eax*4], edi ; pole[index] = tmp
        
        pop edi
        pop ecx
        ; == Koniec vymeny ==
        
        inc eax
        jmp .for1 
;    }
    .endfor1:
    
    pop ebp
    ret 8
    
    
