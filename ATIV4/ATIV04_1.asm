TITLE Lab04_01
.model small
.stack 100h
.data 
.code  
main proc
mov ax,@data
mov ds,AX

mov ah,2
mov dl, 2ah
mov cx,50

; 50 "*" na mesma linha
for1:
int 21h
dec cx
jnz for1

; espaço em branco
mov dl, 0ah
int 21h
mov dl, 0dh
int 21h

mov dl, 2ah
mov cx,50

; 50 "*" em linhas diferentes
for2:
int 21h

; espaço
mov dl, 0ah
int 21h
mov dl, 0dh
int 21h

; volta caracter "*" em dl para impressao
mov dl, 2ah
dec cx
jnz for2

; finaliza programa
mov ah, 4ch
int 21h
main endp
end main