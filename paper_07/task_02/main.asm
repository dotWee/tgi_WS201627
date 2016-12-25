%include "io.inc"
section .data
pos_zahl DD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
neg_zahl DD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

format DB "%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", 0xA, 0
section .text
global CMAIN
extern printf
CMAIN:

    mov ebp, esp
    
    mov eax, -1
    mov ebx, 0
    mov ecx, 10
    mov edx, 0
    
    Schleife:
    mov [pos_zahl+ebx], edx
    mov [neg_zahl+ebx], eax
    add ebx, 4
    inc edx
    dec eax
    loop Schleife
    
    ;Ausgabe pos_zahlen
    mov ecx, 10
    mov ebx, 36
    Schleife2:
    push dword[pos_zahl+ebx]
    sub ebx, 4
    loop Schleife2
    
    push format
    call printf
    mov esp, ebp
    
    ;Ausgabe neg_zahlen
    mov ecx, 10
    mov ebx, 36
    Schleife3:
    push dword[neg_zahl+ebx]
    sub ebx, 4
    loop Schleife3
    
    push format
    call printf
    mov esp, ebp
    
    xor eax, eax
    ret