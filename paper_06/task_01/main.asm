%include "io.inc"

Addition DD " + "
Equals DD " = "

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    ;eax auf 0 setzen
    mov eax, 0
    
    LOOP_LINE:
        ;Zeile in ecx einlesen
        call READ_LINE
        call LOG_LINE
    ;Wiederhole bis ecx 0 ist (Eine 0 im Input-Feld deklariert das Ende der Schleife)
    loop LOOP_LINE
    
    xor eax, eax
    ret
    
READ_LINE:
    ;Zeile in ecx einlesen
    GET_DEC 4, ecx
    
    ;Zusätzlich ins Counter Register kopieren
    ;mov cx, ecx
    ret
    
LOG_LINE:
    ;Summand1 in eax
    PRINT_DEC 4, eax
    PRINT_STRING Addition
    
    ;Summand2 in ecx
    PRINT_DEC 4, ecx
    PRINT_STRING Equals
    
    ;Ergebnis in eax berechnen
    add eax, ecx
    PRINT_DEC 4, eax
    
    ;Neue Zeile
    NEWLINE
    
    ;Ende
    ret