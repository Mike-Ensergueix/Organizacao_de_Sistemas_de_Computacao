TITLE ATIV3
.model small
.STACK 100h
.DATA
MSG1  DB "Digite um caractere (ESC para SAIR!): $"
NUM   DB 10,13,'O caractere digitado eh um numero.',10,13,"$"
LET   DB 10,13,'O caractere digitado eh uma letra.',10,13,"$"
DESC DB 10,13,'O caractere digitado eh desconhecido.',10,13,"$"
.CODE
main proc
;Inicia DS e Permite acesso as variaveis
    mov ax,@DATA
    mov ds,ax

INICIO:
; Exibe na tela a string MSG1 (“Digite um caractere: ”)
    MOV AH,9      ;Move função 9(Print String) para AH
    LEA DX, MSG1  ;Endereça DX para o offset de MSG1
    INT 21h       ;Executa a função em AH printando o que está em DX

    MOV AH,1      ;Move função 1(Ler INput) para AH
    INT 21h       ;Executa a função em AH salvando o INput em AL

    CMP AL,27     ;Compara AL com 27(esc)
    je fim        ;Se igual pula pro Final

    MOV BL,AL     ; Copia o caractere lido para BL

;Verificação Número

    CMP BL,48     ;Compara o caractere em BL com o valor 48 (código ASCII do caractere “0”)
    JB IMPRIME_DESCONHECIDO       ;Se o caractere < 48 (“0”), salta para o rótulo IMPRIME_DESCONHECIDO (Desconhecido)

    CMP BL,57     ;Compara o caractere em BL com o valor 57 (código ASCII do caractere “9”)
    JA VERIFICA_MAIUSCULA     ;Se o caractere em BL > 57 (“9”), pode ser Letra, pula para la

;Caso passe pelas verificações é Número; Exibe na tela dizendo que o caractere é um Número
    MOV AH,9      ;Move função 9(Print String) para AH
    LEA DX, NUM   ;Endereça DX para o offset de NUM
    INT 21h       ;Executa a função em AH printando o que está em DX

    jmp INICIO    ;Volta ao Inicio do Programa

VERIFICA_MAIUSCULA:           
;Verificação de Letra Maiuscula
    CMP BL,65     ;Compara o caractere em BL com o valor 65 (código ASCII do caractere “A”)
    JB IMPRIME_DESCONHECIDO       ;Se o caractere < 65 (“A”), salta para o rótulo IMPRIME_DESCONHECIDO (Desconhecido)
    
    CMP BL,90     ;Compara o caractere em BL com o valor 90 (código ASCII do caractere “Z”)
    JA VERIFICA_MINUSCULA    ;Se o caractere > 57 (“Z”), pode ser Letra Minúscula, pula pra la

;Caso passe pelas verificações é Letra; Exibe na tela dizendo que o caractere é uma Letra
    MOV AH,9      ;Move função 9(Print String) para AH
    LEA DX, LET   ;Endereça DX para o offset de LET
    INT 21h       ;Executa a função em AH printando o que está em DX

    JMP INICIO    ;Volta ao Inicio do Programa

VERIFICA_MINUSCULA:          
;Verificação de Letra Minúscula
    CMP BL,97     ;Compara o caractere em BL com o valor 97 (código ASCII do caractere “a”)
    JB IMPRIME_DESCONHECIDO       ;Se o caractere < 97 (“a”), salta para o rótulo IMPRIME_DESCONHECIDO (Desconhecido)
    
    CMP BL,122    ;Compara o caractere em BL com o valor 122 (código ASCII do caractere “z”)
    JA IMPRIME_DESCONHECIDO       ;Se o caractere > 122 (“z”), salta para o rótulo IMPRIME_DESCONHECIDO (Desconhecido)

;Caso passe pelas verificações é Letra; Exibe na tela dizendo que o caractere é uma Letra
    MOV AH,9      ;Move função 9(Print String) para AH
    LEA DX, LET   ;Endereça DX para o offset de LET
    INT 21h       ;Executa a função em AH printando o que está em DX

    JMP INICIO    ;Volta ao Inicio do Programa
IMPRIME_DESCONHECIDO:
;Roda apenas se passar em verificação
    MOV AH,9      ;Move função 9(Print String) para AH
    LEA DX, DESC ;Endereça DX para o offset de DESC
    INT 21h       ;Executa a função em AH printando o que está em DX

    JMP INICIO    ;Volta ao Inicio do Programa
FIM:
; Finaliza o programa
    MOV AH,4Ch    ;Move função 4C(Terminar o Programa e Retornar ao Sistema Operacional) para AH
    INT 21h       ;Executa a função em AH e termina o programa
    main endp
END main