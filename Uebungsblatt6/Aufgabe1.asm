%include "io.inc"

section .data
ZAHL DD 429496729
MUL1 DD 22
MUL2 DD 8
DIV1 DD 2
DIV2 DD 2
ERG DD 0,0,0
TMP_HIGH DD 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    MOV EAX, [ZAHL]
    MOV [ERG], EAX
    
    push DWORD [MUL1]
    push 3h
    push ERG
    call big_mul
    mov esp, ebp
    
    push DWORD [MUL2]
    push 3h
    push ERG
    call big_mul
    mov esp, ebp
    
    PRINT_HEX 4, [ERG + 8]
    PRINT_HEX 4, [ERG + 4]
    PRINT_HEX 4, [ERG]
    NEWLINE
    
    push DWORD [DIV1]
    push 3h
    push ERG
    call big_div
    mov esp, ebp
    
    push DWORD [DIV2]
    push 3h
    push ERG
    call big_div
    mov esp, ebp

    PRINT_STRING "Ergebnis:  "
    PRINT_HEX 4, [ERG + 8]
    PRINT_HEX 4, [ERG + 4]
    PRINT_HEX 4, [ERG]
    NEWLINE
    
    xor eax, eax
    ret
    
big_mul:
    push ebp
    mov ebp, esp
    
;    mov eax, [ebp + 20]
;    PRINT_HEX 4, eax   
;    NEWLINE
;    mov eax, [ebp + 16]
;    PRINT_HEX 4, eax   
;    NEWLINE
;    mov eax, [ebp + 12]
;    PRINT_HEX 4, eax
;    NEWLINE 
;    mov eax, [ebp + 8]
;    PRINT_HEX 4, eax
;    NEWLINE 
;    NEWLINE
    
    ;pseudo tmp high
    push 0
    mov ecx, 0
    
    schleife_mul:
    cmp ecx, [ebp + 12]
    JGE ende_mul
    
    ;Calculate address of array element
    mov eax, 4
    mul ecx
    add eax, [ebp + 8]
    
    ;fetch element value
    mov eax, [eax]
    
    ;fetch multiplyer
    mov ebx, [ebp + 16]
    
    ;multiply
    mul ebx
    
    ;add previous high part
    pop ebx
    add eax, ebx
    
    jnc keinUeberlauf
    add edx, 1
    
    keinUeberlauf:
    ;save high part
    push edx
        
    ;PRINT_HEX 4, eax
    ;NEWLINE
    
    ;save element value
    push eax
    ;Calculate address of array element
    mov eax, 4
    mul ecx
    add eax, [ebp + 8]
    mov ebx, eax

    ;save element value
    pop eax
    mov [ebx], eax
    
    inc ecx
    jmp schleife_mul

    ende_mul:
    mov esp, ebp
    pop ebp
    ret
    
big_div:
    push ebp
    mov ebp, esp
    
    ;pseudo high
    push 0
    
    mov ecx, [ebp+12]
    sub ecx, 1
    
    schleife_div:
    cmp ecx, 0
    JL ende_div
    
    ;Calculate address of array element
    mov eax, 4
    mul ecx
    add eax, [ebp + 8]

    ;get dividend
    mov eax, [eax]
    pop edx
    
    ;division
    div DWORD [ebp + 16]
    
    ;save rest
    push edx
    
    ;save value
    push eax
    ;calculate address
    mov eax, 4
    mul ecx
    add eax, [ebp + 8]
    mov ebx, eax
    pop eax
    
    ;save value to address
    mov [ebx], eax
    
    DEC ecx
    JMP schleife_div
    
    ende_div:
    mov esp, ebp
    pop ebp
    ret