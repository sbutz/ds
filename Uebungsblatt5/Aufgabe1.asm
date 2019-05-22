%include "io.inc"

section .data
POS_ZAHL DD 0,0,0,0,0,0,0,0,0,0
NEG_ZAHL DD 0,0,0,0,0,0,0,0,0,0

FORMAT db "%d,%d  ", 0


section .text
global CMAIN
extern printf

CMAIN:
    mov ebp, esp; for correct debugging
    
    MOV EBX, 0
    MOV ECX, 0
    
    Schleife:
    CMP ECX, 10
    JE Ende
    
    MOV EAX, 4
    MUL ECX
    
    MOV [POS_ZAHL+EAX], EBX
    
    MOV EDX, EBX
    ADD EDX, 1
    neg EDX
    MOV [NEG_ZAHL+EAX], EDX
    
    PUSH ECX
    
    PUSH EDX
    PUSH EBX
    PUSH FORMAT
    CALL printf
    POP EAX
    POP EAX
    POP EAX
    
    POP ECX
    
    ADD EBX, 1
    
    INC ECX
    JMP Schleife
    
    Ende:    
    xor eax, eax
    ret