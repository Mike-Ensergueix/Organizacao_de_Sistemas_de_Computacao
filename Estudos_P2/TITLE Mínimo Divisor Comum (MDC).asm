TITLE Mínimo Divisor Comum (MDC)
.model small
.stack 100h
.data
A db ?
B db ?
.code
mov ax,@data
mov ds,ax

while1: 
    cmp A, 0
    je fim1

    cmp B, 0
    je fim2

    mov AL, A
    cmp AL, B
    ja R_A

    mov AL, B
    xor AH, AH
    div A
    mov B, AH
    jmp while1

R_A:
    xor AH, AH
    div B
    mov A, AH
    jmp while1

fim1:
    mov al, B
    jmp print

fim2:
    mov al, A

print:
    mov dl, al 
    or dl, 30h
    mov ah, 02
    int 21h

mov ah, 4ch
int 21h