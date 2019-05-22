%include "io.inc"

section .data
MULTA DD 0xABCDEF
MULTB DD 0xFFFFFFFF
PROD DQ 0h

section .text
global CMAIN
CMAIN:
    MOV EAX, 0
    MOV EDX, 0
    MOV ECX, [MULTB]
    
    Schleife:
    CMP ECX, 0
    JZ ende
    ADD EAX, [MULTA]
    JNC KeinUebertrag
    INC EDX
    
    KeinUebertrag:
    DEC ECX
    JMP Schleife
    
    ende:
    MOV DWORD [PROD], EAX
    MOV DWORD [PROD+4], EDX 
    PRINT_HEX 4, [PROD+4]
    PRINT_HEX 4, [PROD]
       
    xor eax, eax
    ret