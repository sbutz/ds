%include "io.inc"

section .data
ERG DQ 0
DIV1 DD 10

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    GET_CHAR ebx
    GET_UDEC 4, eax
    GET_UDEC 4, edx
    
    cmp ebx, '+'
    je addition
    cmp ebx, '-'
    je subtraction
    cmp ebx, '*'
    je multiplication
    cmp ebx, '/'
    je division
    cmp ebx, '%'
    je modulo
    jmp error_unknown_operation
    
    addition:
    PRINT_STRING "Addition"
    NEWLINE
    add eax, edx
    mov DWORD [ERG], 0
    mov DWORD [ERG+4], eax
    jnc ausgabe
    mov DWORD [ERG], 1
    jmp ausgabe
    
    subtraction:
    PRINT_STRING "Subtraction"
    NEWLINE
    sub eax, edx
    mov DWORD [ERG], 0
    mov DWORD [ERG+4], eax
    jmp ausgabe
    
    multiplication:
    PRINT_STRING "Multiplication"
    NEWLINE
    mul edx
    mov DWORD [ERG], edx
    mov DWORD [ERG+4], eax
    jmp ausgabe
    
    division:
    PRINT_STRING "Dvision"
    NEWLINE
    mov ebx, edx
    xor edx, edx
    div ebx
    mov DWORD [ERG], 0
    mov DWORD [ERG+4], eax
    jmp ausgabe
    
    modulo:
    PRINT_STRING "Modulo"
    NEWLINE
    mov ebx, edx
    xor edx, edx
    div ebx
    mov DWORD [ERG], 0
    mov DWORD [ERG+4], edx
    jmp ausgabe
    
    error_unknown_operation:
    PRINT_STRING "Unbekannte Operation"
    jmp ende  
    
    ausgabe:
    xor ecx, ecx
    
    .Div:
    xor edx, edx
    
    mov eax, [ERG]
    DIV DWORD [DIV1]
    mov DWORD [ERG], eax
    
    mov eax, [ERG+4]
    DIV DWORD [DIV1]
    mov DWORD [ERG+4], eax
    
    push edx
    inc ecx
    
    mov eax, [ERG]
    cmp eax, 0    
    jnz .Div
    
    mov eax, [ERG+4]
    cmp eax, 0
    jnz .Div
        
    .Loop:
    pop ebx
    PRINT_DEC 4, ebx
    loop .Loop

    ende:    
    xor eax, eax
    ret