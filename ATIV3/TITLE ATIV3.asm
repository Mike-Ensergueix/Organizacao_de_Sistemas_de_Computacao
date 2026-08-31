TITLE ATIV3
.model small
.STACK 100h
.DATA
MSG1 DB "Digite um caractere: $"
SIM DB 10,13,'O caractere digitado e um numero.',10,13,"$"
NAO DB 10,13,'O caractere digitado e letra.',10,13,"$"
DESCO DB 10,13,'O caractere digitado e desconhecido.',10,13,"$"
.CODE
main proc
    mov ax,@DATA
    mov ds,ax

INICIO:
; Exibe na tela a string MSG1 (“Digite um caractere: ”)
    MOV AH,9
    LEA DX, MSG1
    INT 21h
    ; Lê um caractere do teclado e salva o caractere lido em AL
    MOV AH,1
    INT 21h

    CMP AL,27
    je fim

    ; Copia o caractere lido para BL
    MOV BL,AL

    ; Compara o caractere em BL com o valor 48 (código ASCII do caractere “0”)
    CMP BL,48
    ; Se o caractere em BL for menor que 48 (“0”), salta para o rótulo NAOENUMERO
    JB DESC
    ; Compara o caractere em BL com o valor 57 (código ASCII do caractere “9”)

    CMP BL,57
    ; Se o caractere em BL for maior que 57 (“9”), salta para o rótulo NAOENUMERO
    JA ELETRA

    ; Exibe na tela dizendo que o caractere é um número
    MOV AH,9
    LEA DX, SIM
    INT 21h

    jmp INICIO

ELETRA:

   CMP BL,65
        ; Se o caractere em BL for menor que 48 (“0”), salta para o rótulo NAOENUMERO
        JB DESC
    ; Compara o caractere em BL com o valor 57 (código ASCII do caractere “9”)
        CMP BL,90
        ; Se o caractere em BL for maior que 57 (“9”), salta para o rótulo NAOENUMERO
        JA ELETRAM

    MOV AH,9
    LEA DX, NAO
    INT 21h
    ; Salta para o rótulo FIM
    JMP INICIO

ELETRAM:

    CMP BL,97
    ; Se o caractere em BL for menor que 48 (“0”), salta para o rótulo NAOENUMERO
    JB DESC
    ; Compara o caractere em BL com o valor 57 (código ASCII do caractere “9”)
    CMP BL,122
    ; Se o caractere em BL for maior que 57 (“9”), salta para o rótulo NAOENUMERO
    JA DESC

    MOV AH,9
    LEA DX, NAO
    INT 21h
    ; Salta para o rótulo FIM
    JMP INICIO
    ; Define o rótulo NAOENUMERO
DESC:
    ; Se chegou até aqui, exibe na tela dizendo que o caracter é um número
    MOV AH,9
    LEA DX, DESCO
    INT 21h
    JMP INICIO
    ; Define o rótulo FIM
FIM:
; Finaliza o programa
    MOV AH,4Ch
    INT 21h
    main endp
END main