TITLE Lab04_04
.model small
.stack 100h
.data 
.code  
main proc
mov ax,@data
mov ds,AX

mov ah, 2
mov bh, 97 ; letras em bh para não comprometer a impressão
mov bl, 26 ; contagem fora do contador


for2:
mov cx, 4  ; contagem para primeiro loop

; printa 4 letras na mesma linha
for1:
mov dl, bh ; restaura caracter para impressao
int 21h

inc bh  ; incrementa letra
dec bl  ; decrementa contagem principal
jz fim  ; se bl igual a 0 = fim

loop for1 ; ate preencher 4 letras por linha

; cx igual a 0 = espaço
mov dl, 0ah
int 21h
mov dl, 0dh
int 21h

jmp for2

; finaliza programa
fim:
mov ah, 4ch
int 21h
main endp
end main