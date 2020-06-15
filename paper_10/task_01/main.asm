%include "io.inc"

section .data
    ZAHL1       DD  0h
    ZAHL2       DD  0h
    OPERAND     DB  0h
    ERGEBNIS    DQ  0h
    ZEHN        DD  10

section .text
    global CMAIN

CMAIN:
    mov ebp, esp            ; for correct debugging
    GET_CHAR [OPERAND]
    GET_DEC 4, [ZAHL1]
    GET_DEC 4, [ZAHL2]

    CMP BYTE[OPERAND], '+'
    JE Addition

    CMP BYTE[OPERAND], '-'
    JE Subtraktion

    CMP BYTE[OPERAND], '/'
    JE Division

    CMP BYTE[OPERAND], '*'
    JE Multiplikation

    CMP BYTE[OPERAND], '%'
    JE Modulo

    JMP Error

Addition:
    MOV EAX, [ZAHL1]
    ADD EAX, [ZAHL2]
    JMP Ende

Subtraktion:
    MOV EAX, [ZAHL1]
    SUB EAX, [ZAHL2]
    JMP Ende

Division:
    MOV EAX, [ZAHL1]
    MOV EDX, 0
    DIV DWORD[ZAHL2]
    JMP Ende

Modulo:
    MOV EAX, [ZAHL1]
    MOV EDX, 0
    DIV DWORD[ZAHL2]
    MOV EAX, EDX
    JMP Ende

Multiplikation:
    MOV EAX, [ZAHL1]
    MUL DWORD[ZAHL2]
    CMP EDX, 0
    JNE AusgabeMultiplikationVor
    JMP Ende

Ende:
    PRINT_DEC 4, EAX
    XOR EAX, EAX
    MOV ESP, EBP
    RET

Error:
    PRINT_STRING 'Fehler'
    RET

AusgabeMultiplikationVor:
    MOV ECX, 0
    MOV DWORD[ERGEBNIS], EAX
    MOV DWORD[ERGEBNIS + 4], EDX

AusgabeMultiplikation:
    XOR EDX, EDX
    MOV EAX, [ERGEBNIS + 4]
    DIV DWORD[ZEHN]
    MOV [ERGEBNIS + 4], EAX
    MOV EAX, [ERGEBNIS]
    DIV DWORD[ZEHN]
    MOV [ERGEBNIS], EAX
    PUSH EDX
    INC ECX
    MOV EBX, [ERGEBNIS]
    ADD EBX, [ERGEBNIS + 4]
    CMP EBX, 0
    JNE AusgabeMultiplikation

Schleife:
    POP EBX
    PRINT_HEX 4, EBX
    LOOP Schleife
    XOR EAX, EAX
    MOV ESP, EBP
    RET
