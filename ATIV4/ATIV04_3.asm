TITLE Lab04_03
.model small
.stack 100h
.data 
.code  
main proc
mov ax,@data
mov ds,AX

mov ah, 2
mov dl, 97
mov cx, 26

; imprime alfabeto minusculo com espaço
for1:
int 21h
inc dl

; salva incremento
mov bx, dx

; espaço
mov dl, 0ah
int 21h
mov dl, 0dh
int 21h

; devolve incremento
mov dx,bx
loop for1

mov dl, 65
mov cx, 26

; imprime alfabeto maisculo na mesma linha
for2:
int 21h
inc dl
loop for2

; finaliza programa
mov ah, 4ch
int 21h
main endp
end main