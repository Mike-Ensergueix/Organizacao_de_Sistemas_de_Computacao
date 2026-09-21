TITLE Lab04_03
.model small
.stack 100h
.data 
.code  
main proc
mov ax, @data
mov ds, ax

xor bx, bx
mov cx, 5 ; prepara para 5 leituras

leitura:
mov ah, 1
int 21h

and al, 0Fh ; converte ascii para valor numerico

add bl, al ; soma bl = bl + al

loop leitura

; espaço
mov ah, 2
mov dl, 0dh
int 21h
mov dl, 0ah
int 21h

mov dl, bl
or dl, 30h ; converte valor numerico para ascii

; exibe o resultado
int 21h

; finaliza o programa
mov ah, 4ch
int 21h
main endp
end main