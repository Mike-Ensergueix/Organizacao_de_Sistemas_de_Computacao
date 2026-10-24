TITLE ATIV05_2
.model small
.stack 100h
.code
main proc
mov cx,16
mov ah,2
print_bin:
xor dl,dl
or dl,bl
and dl,01h
or dl,30h
int 21h
rol bx,1
loop print_bin
mov ah,4ch
int 21h
main endp 
end main
