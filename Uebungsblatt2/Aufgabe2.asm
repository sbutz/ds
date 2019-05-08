%include "io.inc"

section .data
Hallo DB "Hallo",0      ;definiert eine Byte-Kette (String)

A DD 12h                ;definiert ein double-word
B DD 5h
ERG DD 0


section .text
global CMAIN
CMAIN:
    mov ebp, esp
    ;write your code here
    xor eax, eax        ;accumulator leeren

    MOV EAX, [A]        ;Den Wert von A nach EAX schreiben
    MOV EBX, 12         ;Wert 12 in EBX shreiben
    ADD EAX, EBX        ;EAX und EBX addieren und nach EAX schreiben
   
    MOV EBX, [B]
    ADD EAX, EBX
    
    MOV [ERG], EAX
     
    PRINT_STRING Hallo  ;Gibt den String Hallo aus
    PRINT_DEC 4, ERG    ;Gibt die ersten vier Byte aus EAX in DEZIMAL aus
    
    xor eax, eax        ;Accumulator leeren
    ret