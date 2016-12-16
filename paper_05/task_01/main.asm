%include "io.inc"

section .data

;Zahl dessen Fakultät berechnet werden soll
N DD 2h             
;Variable in der das Ergebnis gespeichert wird
ERG DD 1h           

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    
    ;Schreibe Wert von ERG in eax
    mov eax, [ERG]  
    ;Schreibe Wert von N in ecx
    mov ecx, [N]    
    
    Anfang:
    ;Multipliziere Wert aus eax mit ecx und schreibe Ergebnis in eax
    mul ecx         
    ;Springe zu Anfang wenn ecx nicht null 
    ;und ziehe von ecx 1 ab, ansonnsten Weiterführung
    Loop Anfang     
    
    ;Schreibe Wert von eax in ERG
    mov [ERG], eax 
  
    ;Gib Ergebnis aus
    PRINT_DEC 4, [ERG]
    ret