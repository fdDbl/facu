; 1.  Contar letras
ORG 1000H
MENSAJE DB "Hola, me llamo Fede Dobal"
LETRA DB "e"
CANT DB ?

ORG 2000H
MOV AL, LETRA
MOV CH, 0
MOV CL, OFFSET LETRA-OFFSET MENSAJE
MOV BX, OFFSET MENSAJE

LOOP: CMP [BX], AL
JNZ ACTUALIZAR
INC CH

ACTUALIZAR: INC BX
DEC CL
JNZ LOOP
MOV CANT, CH

HLT
END

; 2. Es mayúscula
ORG 1000H
CAR DB "@"
A DB 40H
Z DB 5BH
RES DB ?

ORG 2000H
MOV AH, CAR

MOV AL, A
MOV CH, Z
SUB CH, A
MOV CL, 0

CHECK: 
INC AL
INC CL
CMP CL, CH
JZ FIN

LOOP: CMP AH, AL
JNZ CHECK

ES_MAYUS: MOV RES, 0FFH

FIN:
HLT
END

; 3. Mayúscula a minúscula
ORG 1000H
CAR DB "@"
A DB 40H
Z DB 5BH
RES DB ?

ORG 2000H
MOV AH, CAR

MOV AL, A
MOV CH, Z
SUB CH, A
MOV CL, 0

CHECK: 
INC AL
INC CL
CMP CL, CH
JZ FIN

LOOP: CMP AH, AL
JNZ CHECK

ADD AH, 20h ; SI ES UNA LETRA MAYUSCULA...
MOV RES, AH

FIN:
HLT
END
