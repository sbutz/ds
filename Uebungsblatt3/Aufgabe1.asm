%include "io.inc"

%macro SHIFT_LEFT_ONE 1
    MOV EAX, %1
    SHL EAX, 1
    JO ende
    MOV %1, EAX
%endmacro

section .data
A DD 1h
B DD 2h
C DD 3h
ERG DD 0
O_Flag DD 0
Zahl DD 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
       
    anfang:
    mov EAX, [A]
    mov EBX, [B]
    sub EAX, EBX
    
    JO ende
    
    mov EBX, [C]
    ADD EAX, EBX
    
    JO ende
    
    MOV [ERG], EAX    
    MOV EAX, [Zahl]
    INC EAX
    MOV [Zahl], EAX
    
    SHIFT_LEFT_ONE [A]
    SHIFT_LEFT_ONE [B]
    SHIFT_LEFT_ONE [C]
    JMP anfang
    
    ende:
    PRINT_STRING "A: "
    PRINT_HEX 4,A
    NEWLINE
    PRINT_STRING "B: "
    PRINT_HEX 4,B
    NEWLINE
    PRINT_STRING "C: "
    PRINT_HEX 4,C
    NEWLINE
    PRINT_STRING "Ergebnis: "
    PRINT_HEX 4,ERG
    NEWLINE
    PRINT_STRING "Flag: "
    PRINT_HEX 4,O_Flag
    NEWLINE
    PRINT_STRING "Zahl: "
    PRINT_HEX 4,Zahl
    xor eax, eax
    ret