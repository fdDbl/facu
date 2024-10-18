PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000H
MSJ1 DB "ARQUITECTURA DE COMPUTADORAS "
MSJ2 DB "FIN DE PROGRAMA "
FIN_MSJ DB ?
FIN_PROGRAM DB 0

ORG 3000H
INI_PIO: MOV AL, 0FFH
OUT CA, AL
MOV AL, 0
OUT CB, AL
RET

ORG 3100H
A: IN AL, PA
PUSH AX
XOR AL, 0FFH
OUT PB, AL
POP AX
RET

ORG 3200H
B: MOV AH, AL
AND AH, 1
JZ RET_SUBRUT_B
  MOV BX, OFFSET MSJ1
  MOV AL, OFFSET MSJ2 - OFFSET MSJ1
  INT 7
RET_SUBRUT_B: RET

ORG 3300H
C: CMP AL, 0
JNZ RET_SUBRUT_C
  MOV FIN_PROGRAM, 1
RET_SUBRUT_C: RET

ORG 2000H
CALL INI_PIO

MAIN:
  CALL A
  CALL B
  CALL C
  CMP FIN_PROGRAM, 0
  JZ MAIN

MOV BX, OFFSET MSJ2
MOV AL, OFFSET FIN_MSJ - OFFSET MSJ2
INT 7
INT 0
END