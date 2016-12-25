%include "io.inc"
section .data
OPA DD 0h
OPB DD 0h
OPERAND DB 0h
ERG DQ 0h
ZEHN DD 10

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_CHAR [OPERAND]
    GET_DEC 4, [OPA]
    GET_DEC 4, [OPB]
    
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
    MOV EAX, [OPA]
    ADD EAX, [OPB]
    JMP Ende
    
    Subtraktion:
    MOV EAX, [OPA]
    SUB EAX, [OPB]
    JMP Ende
    
    Division:
    MOV EAX, [OPA]
    MOV EDX, 0
    DIV DWORD[OPB]
    JMP Ende
    
    Modulo:
    MOV EAX, [OPA]
    MOV EDX, 0
    DIV DWORD[OPB]
    MOV EAX, EDX
    JMP Ende
    
    Multiplikation:
    MOV EAX, [OPA]
    MUL DWORD[OPB]
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
    MOV DWORD[ERG], EAX
    MOV DWORD[ERG+4], EDX
    
    AusgabeMultiplikation:
    XOR EDX, EDX
    MOV EAX, [ERG+4]
    DIV DWORD[ZEHN]
    MOV [ERG+4], EAX
    MOV EAX, [ERG]
    DIV DWORD[ZEHN]
    MOV [ERG], EAX
    PUSH EDX
    INC ECX
    MOV EBX, [ERG]
    ADD EBX, [ERG+4]
    CMP EBX, 0
    JNE AusgabeMultiplikation
    
    Schleife:
    POP EBX
    PRINT_HEX 4, EBX
    LOOP Schleife
    
    XOR EAX, EAX
    MOV ESP, EBP
    RET