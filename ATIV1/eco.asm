TITLE Eco
.MODEL SMALL
.STACK 100h
.DATA
msg1 db "Digite um Caracter: $"
msg2 db 10,13,"O caracter digitado foi: $"
.CODE
main proc
mov ax,@data
mov ds,AX

mov ah,9
lea dx, msg1
int 21h

; Lê um caracter do teclado e salva o caracter lido em AL
MOV AH,1
INT 21h

; Copia o caracter lido para BL
mov bl, AL


mov ah,9
lea dx, msg2
int 21h

; Exibe o caracter lido (salvo em BL)
MOV AH,2
MOV DL,bl
INT 21h

; Finaliza o programa
MOV AH,4Ch
INT 21h
main endp
END main