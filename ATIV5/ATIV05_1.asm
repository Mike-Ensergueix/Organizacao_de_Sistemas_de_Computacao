TITLE ATIV05_1
.model small
.stack 100h
.data
N_bin dw ?
.code
main proc

mov ax,@DATA
mov ds,ax

xor bx,bx
mov cx,16
mov ah,1
ler_bin:
int 21h
cmp al,13
je fim

and al,0Fh
shl bx
or bl, al 
loop ler_bin

fim:
mov N_bin, BX
mov ah,4ch
int 21h
main endp
end main
