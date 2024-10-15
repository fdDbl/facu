ORG 1000H
VECTOR DW 50,14,24,12,1,5,7,9
MSJ1 DB "GANAN LOS PARES"
MSJ2 DB "GANAN LOS IMPARES"
PARES DB 0
IMPARES DB 0

ORG 3000H
CONTAR_PARES: MOV BX, SP
  ADD BX, 2
  MOV DX, [BX]
  ADD BX, 2
  MOV BX, [BX]
  LOOP: CALL ES_PAR
    DEC DX
    JNZ SIGUE
    JMP FIN_RUT1
  SIGUE: ADD BX, 2
    JMP LOOP
  FIN_RUT1: MOV AL, PARES
RET

ORG 3100H
ES_PAR: AND BYTE PTR[BX], 1
  JZ PAR
  MOV CX, 0
  INC IMPARES
  JMP FIN_RUT2
  PAR: MOV CX, 1
    INC PARES
  FIN_RUT2: RET

ORG 2000H
MOV BX, OFFSET VECTOR
PUSH BX
MOV DX, 9
PUSH DX
CALL CONTAR_PARES

CMP AL, IMPARES
JNS GANA_PAR
MOV BX, OFFSET MSJ2
MOV AL, OFFSET PARES - OFFSET MSJ2
INT 7
JMP FIN
GANA_PAR: MOV BX, OFFSET MSJ1
MOV AL, OFFSET MSJ2 - OFFSET MSJ1
INT 7
FIN: INT 0
END
