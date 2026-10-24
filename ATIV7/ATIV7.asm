TITLE CONVESORA LOSC-Atividade7 Mike Ensergueix
.MODEL SMALL
.STACK 100H
.DATA 
    Menu DB   10,13,10,13,'!CONVERSORA BIN/DEC/HEX!'
         DB   10,13,"Escolha uma opcao (Entrada/Saida):"
         DB   10,13,"1.E/S Binario - Decimal"
         DB   10,13,"2.E/S Binario - Hexadecimal"
         DB   10,13,"3.E/S Decimal - Binario"
         DB   10,13,"4.E/S Decimal - Hexadecimal"
         DB   10,13,"5.E/S Hexadecimal - Binario"
         DB   10,13,"6.E/S Hexadecimal - Decimal"
         DB   10,13,'0.Sair Do Programa.$'
    
    OPC  DB   10,13,'Escolha Uma Opcao: $'

    EBIN DB   10,13,10,13,'Digite Um Numero Binario: $'
    SBIN DB   10,13,10,13,'Numero Digitado Em Binario (16 bits): $'

    EHEX DB   10,13,10,13,'Digite Um Numero Hexadecilmal: $'
    SHEX DB   10,13,10,13,'Numero Digitado Em Hexadecimal: $'

    EDEC DB   10,13,10,13,'Digite Um Numero Decilmal: $'
    SDEC DB   10,13,10,13,'Numero Digitado Em Decimal: $'
    
    INV  DB   10,13,10,13,'Opcao Invalida!',10,13,'$'

    NL   DB   10,13,'$'

    total    DW 0; variavel para armazenar o numero
    negativo DB 0; flag para número negativo
.CODE
MAIN PROC 
    MOV AX,@DATA; inicialização do segmento de dados
    MOV DS,AX

    XOR AX,AX   ; zera AX

    MOV AH,09   ; printa o menu
    LEA DX,Menu
    INT 21H

INICIO:
    MOV AH,09   ; printa a escolha
    LEA DX,OPC
    INT 21H

    MOV AH,01   ; le opcao escolhida (tecla do teclado)
    INT 21H

    CMP AL,30H  ; 0 = sai do programa
    JE FIM
    
    CMP AL,31H
    JB INVALIDO ; 1 > caracter invalido

    CMP AL,36H  ; 6 < carater invalido
    JA INVALIDO

    CMP AL,31H  ; opcao 1
    JE OP1

    CMP AL,32H  ; opcao 2
    JE OP2

    CMP AL,33H  ; opcao 3
    JE OP3

    CMP AL,34H  ; opcao 4
    JE OP4

    CMP AL,35H  ; opcao 5
    JE OP5

    CMP AL,36H  ; opcao 6
    JE OP6

; processar opcoes
OP1:
    CALL E_BIN  ; chama entrada em binario
    CALL S_DEC  ; chama saida em decimal
    JMP MAIN    ; volta para inicio

OP2:
    CALL E_BIN  ; chama entrada em binario
    CALL S_HEX  ; chama saida em hexadecimal
    JMP MAIN    ; volta para inicio

OP3:
    CALL E_DEC  ; chama entrada em decimal
    CALL S_BIN  ; chama saida em binario
    JMP MAIN    ; volta para inicio

OP4:
    CALL E_DEC  ; chama entrada em decimal
    CALL S_HEX  ; chama saida em hexadecimal
    JMP MAIN    ; volta para inicio

OP5:
    CALL E_HEX  ; chama entrada em hexadecimal
    CALL S_BIN  ; chama saida em binario
    JMP MAIN    ; volta para inicio

OP6:
    CALL E_HEX  ; chama entrada em hexadecimal
    CALL S_DEC  ; chama saida em decimal
    JMP MAIN    ; volta para inicio

INVALIDO:
    CALL INVALID; caracter invalido
    JMP INICIO  ; loop 

FIM:
    MOV AH,4CH  ; finaliza o programa
    INT 21H

MAIN ENDP

INVALID PROC
    MOV AH,09   ; printa caracter invalido
    LEA DX,INV
    INT 21H
    RET         ; retorna

INVALID ENDP

E_BIN PROC
    XOR BX,BX   ; zera BX
    XOR CX,CX   ; zera CX

    MOV CX,16   ; limita contador para 16 bits

    MOV AH,09   ; printa escolha binaria
    LEA DX,EBIN
    INT 21H

LER1:
    MOV AH,01   ; le caracter binario
    INT 21H
    
    CMP AL,0DH  ; CR = sai do loop
    JE FIM_EBIN

    CMP AL,30H  ; 0 > caracter nao binario
    JB NB

    CMP AL,31H  ; 1 < caracter nao binario
    JA NB

    AND AL,01H  ; converte hexa para binario

    SHL BX,1      ; desloca BX uma casa para esquerda

    OR BL,AL    ; imprime o lsb de AL no lsb de BL

    LOOP LER1    ; loop
    JMP FIM_EBIN; encerra loop

NB:
    CALL INVALID; caracter invalido

    LEA DX,EBIN;; printa escolha binaria
    INT 21H

    JMP LER1    ; loop sem decrementar CX

FIM_EBIN:
    RET         ; retorna

E_BIN ENDP

S_BIN PROC
    PUSH BX     ; preserva BX
    PUSH CX

    XOR CX,CX   ; zera CX

    MOV CX,16   ; limita saida para 16 bits

    MOV AH,09   ; printa saida binaria
    LEA DX,SBIN
    INT 21H

PRINT_BIN:
    MOV AH,02   ; seta print do numero binario

    ROL BX,1    ; faz rotaçao de 1 bit de BX para esquerda
    JC UMb      ; se CF = 1, pula

    MOV DL,30H  ; se CF = 0, printa '0'
    INT 21H

    JMP CONTINUA_BIN; segue o loop

UMb:
    MOV DL,31H  ; printa 1 apos pulo
    INT 21H

CONTINUA_BIN:
    LOOP PRINT_BIN; loop print

FIM_SBIN:
    MOV AH, 09  ; pula linha
    LEA DX,NL
    INT 21H

    POP CX
    POP BX      ; restaura BX

    RET         ; retorna

S_BIN ENDP

E_HEX PROC
    XOR BX,BX
    XOR CX,CX   ; zera CX

    MOV CX,4    ; limita para 4 digitos

    MOV AH,09   ; printa entrada hexadecimal
    LEA DX,EHEX
    INT 21H

LER2:
    MOV AH,01   ; le caracter hexadecimal
    INT 21H

    CMP AL,0DH  ; CR = sai do loop
    JE FIM_EHEX

    CMP AL,30H  ; 30 > caracter nao hexadecimal
    JB NH

    CMP AL,39H  ; 39 >= numero hexadecimal
    JBE NUMERO

    CMP AL,41H  ; 41 > caracter nao hexadecimal
    JB NH

    CMP AL,46H  ; 46 >= letra hexadecimal (A-F)
    JBE LETRA_MAI

    CMP AL,61H  ; 61 > caracter nao hexaecimal
    JB NH  
    CMP AL,66H  ; 66 >= letra minuscula hexadecimal (a-f)
    JBE LETRA_MIN

    JMP NH      ; se nao ha jump = caracter nao hexadecimal

LETRA_MIN:
    SUB AL,20H  ; correcao minusculo para maiúscula
LETRA_MAI:
    SUB AL,07H  ; corecao letras ascii para hexadecimal (A=10)

NUMERO:
    SUB AL,30H  ; converte ascii para hexadecimal

IMPRIMIR:
    SHL BX,4    ; desloca 4 bits de BX para a esquerda

    OR BL,AL    ; imprime caracter hexadecimal em BL

    LOOP LER2   ; loop2
    JMP FIM_EHEX; encerra loop

NH:
    CALL INVALID; carcter nao hexadecimal

    LEA DX,EHEX ; printa entrada hexadecimal
    INT 21H

    JMP LER2    ; loop sem decrementar CX

FIM_EHEX:
    RET         ; retorna

E_HEX ENDP

S_HEX PROC
    PUSH BX     ; preserva BX
    PUSH CX
    PUSH DX

    MOV CX,4    ; limita contador em 4 digitos hexadecimais

    MOV AH,09   ; printa saida hexadecimal
    LEA DX,SHEX
    INT 21H

PRINT_HEX:
    MOV DL,BH   ; move byte alto de BX no byte baixo de DX

    XOR DH,DH   ; zera byte alto de DX

    ROR DX,4    ; desloca 4 bits de DX para direita (isola nibble)

    CMP DL,9    ; verifica numero
    JBE NUM

    ADD DL,07H   ; correcao para letras

NUM: 
    ADD DL,30H  ; converte numero hexadecimal para ascii

    MOV AH,02   ; printa hexadecimal
    INT 21H

    ROL BX,4    ; desloca 4 bits de BX para esquerda (prox nibble)
    LOOP PRINT_HEX

    MOV AH,09   ; nova linha
    LEA DX,NL
    INT 21H
    
    POP DX
    POP CX
    POP BX      ; restaura regs

    RET

S_HEX ENDP

E_DEC PROC
    PUSH AX     ; salva regs
    PUSH CX

    MOV total,0 ; zera variaveis
    MOV negativo,0

    XOR CH,CH   ; zera contador

    MOV BX,0AH  ; seta BX = 10

    MOV AH,09   ; printa escolha
    LEA DX,EDEC
    INT 21H

    MOV AH,01   ; le decimal inserido (tecla do teclado)
    INT 21H

    CMP AL,2DH  ; verifica sinal
    JE NEGA

LER3:
    CMP AL,0DH  ; CR = end loop
    JE SINAL

; verifica se é dígito 0-9
    CMP AL,30H
    JB ND
    CMP AL,39H  
    JA ND

    AND AL,0FH  ; converte ascii para binario
    MOV CL,AL   ; salva binario em CL

    MOV AX,total; move numero para AX
    MUL BX      ; numero x 10
    JC FIM_EDEC ; finaliza leitura se overflow

    ADD AX,CX   ; + binario
    JC FIM_EDEC ; finaliza leitura se overflow

    MOV total,AX; salva resultado em total 

    MOV AH,01   ; le decimal inserido (tecla do teclado)
    INT 21H

    JMP LER3    ; loop ler

NEGA:
    MOV negativo, 1;seta negativo = true
    MOV AH,01   ; le decimal inserido (tecla do teclado)
    INT 21H

    JMP LER3    ; loop ler

ND:
    CALL INVALID; caracter invalido

    LEA DX,EDEC;; printa escolha decimal
    INT 21H

    MOV AH,01   ; le decimal inserido (tecla do teclado)
    INT 21H

    JMP LER3    ; loop 

SINAL:
    CMP negativo,1;compara negativo = true
    JNE FIM_EDEC; pula se negativo = false
    NEG total   ; torna negativo se negativo = true

FIM_EDEC:
    MOV BX,total; guarda numero em BX

    POP CX
    POP AX      ; recupera regs

    RET         ; retorna

E_DEC ENDP

S_DEC PROC
    PUSH AX     ; guarda regs na pilha
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH,09   ; printa saida decimal
    LEA DX,SDEC
    INT 21H
    
    MOV AX,BX   ; move numero para AX
    XOR CX,CX   ; zera contador de digitos
    MOV BX,0AH  ; divisor
    
    TEST AX,AX  ; verifica se negativo
    JNS CONVERTER_DEC; pula se positivo

    NEG AX      ; se negativo, torna positivo

    PUSH AX     ; guarda AX na pilha

    MOV AH,02   ; printa sinal '-'
    MOV DL,2DH
    INT 21H

    POP AX      ; recuper AX
    
CONVERTER_DEC:
    XOR DX,DX   ; zera DX
    DIV BX      ; DX:AX / 10

    PUSH DX     ; empilha resto

    INC CX      ; incrementa contador

    CMP AX,0    ; compara quociente = 0
    JNE CONVERTER_DEC; loop converter
    
IMPRIMIR_DEC:
    POP DX      ; desempilha resto
    ADD DL,30H  ; converter para ASCII

    MOV AH,02   ; seta print numero decimal
    INT 21H  

    LOOP IMPRIMIR_DEC; loop imprimir
    
    MOV AH,09   ; nova linha
    LEA DX,NL
    INT 21H
    
    POP DX      ; recuper regs
    POP CX
    POP BX
    POP AX

    RET         ; retorna

S_DEC ENDP

END MAIN