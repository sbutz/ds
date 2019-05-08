%include "io.inc"

section .data
Hallo DB "Hallo",0      ;definiert eine Byte-Kette (String)

A DD 12h                ;definiert ein double-word


section .text
global CMAIN
CMAIN:
    mov ebp, esp
    ;write your code here
    xor eax, eax        ;accumulator leeren

    MOV EAX, [A]        ;Den Wert von A nach EAX schreiben
    MOV EBX, 12         ;Wert 12 in EBX shreiben
    ADD EAX, EBX        ;EAX und EBX addieren und nach EAX schreiben
    
    PRINT_STRING Hallo  ;Gibt den String Hallo aus
    PRINT_DEC 4, EAX    ;Gibt die ersten vier Byte aus EAX in DEZIMAL aus
    
    xor eax, eax        ;Accumulator leeren
    ret