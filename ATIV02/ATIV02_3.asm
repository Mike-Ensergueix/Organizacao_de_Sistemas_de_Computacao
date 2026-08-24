.model small
.stack 100h
.data
msg1 db "Digite o Primeiro Numero: $"
msg2 db 10,13,"Digite o Segundo Numero: $"
msg3 db 10,13,"O Resultado da Soma eh: $"
.code
main proc
mov ax,@data
mov ds,ax

mov ah,09
lea dx, msg1
int 21h

mov ah,01 
int 21h

mov bl,al

mov ah,09
lea dx, msg2
int 21h

mov ah,01 
int 21h

add bl,al
sub bl, 30h

mov ah,09
lea dx, msg3
int 21h

mov ah,02
mov dl,bl
int 21h

mov ah,4ch
int 21h

main endp
end main