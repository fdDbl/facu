PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000H
MSJ DB "Estoy usando la impresora a través del PIO"
FIN DB ?

ORG 3000H
INI_PIO: MOV AL, 0
OUT CB, AL
MOV AL, 11111101B
OUT CA, AL
RET

ORG 3100H
POLL: IN AL, PA
AND AL, 1
JNZ POLL
RET

ORG 3200H
STROBE_1: IN AL, PA
OR AL, 2
OUT PA, AL
RET

ORG 3300H
STROBE_0: IN AL, PA
AND AL, 1
OUT PA, AL
RET

ORG 3400H
IMPRIMIR_CAR: PUSH AX
CALL POLL
POP AX
OUT PB, AL
CALL STROBE_1
CALL STROBE_0
RET

ORG 2000H
CALL INI_PIO
CALL STROBE_0

MOV BX, OFFSET MSJ
MOV CL, OFFSET FIN - OFFSET MSJ

LOOP: MOV AL, [BX]
CALL IMPRIMIR_CAR
INC BX
DEC CL
JNZ LOOP

INT 0
END
