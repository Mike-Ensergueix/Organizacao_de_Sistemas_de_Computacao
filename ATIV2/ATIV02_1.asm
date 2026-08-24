title ATIV02_1.asm
.model small
.stack 100h
.data
msg db 'Digite uma Letra: $'
msg1 db 10,13,'Sua Letra Maiuscula eh: $'

.code
main proc
mov ax,@data ; inicializar DS com endereco do segmento de dados
mov ds,ax

mov ah,09 ; funcao 09 impirme um string
lea dx, msg ; endereço incial do string
int 21h ; executa a funcao 09

mov ah,01
int 21h

mov bl,al
sub bl,20h

mov ah,09 ; funcao 09 impirme um string
lea dx, msg1 ; endereço incial do string
int 21h ; executa a funcao 09

mov ah,02
mov dl,bl
int 21h

mov ah,4ch ; fim do programa
int 21h ; retorno ao SO
main endp
end main