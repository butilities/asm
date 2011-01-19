; Turenko Alexander. 4.21(a, b).
INCLUDE IO\io.asm

STACK SEGMENT STACK
	DB 128 DUP (?)
STACK ENDS

DATA SEGMENT
	ERR_MESS DB '*ERROR*$'
	X DB 26 DUP (0)
DATA ENDS

CODE SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE
START:	MOV AX, DATA
	MOV DS, AX

	OUTCH '>'
	OUTCH ' '

	MOV CX, 26
	MOV BX, 0
L:	MOV X[BX], 0
	INC BX
	LOOP L

	MOV BH, 0
LL:	INCH BL
	CMP BL, '.'
	JE TOOUT
	CMP BL, 'a'
	JB ERR_L
	CMP BL, 'z'
	JA ERR_L
	SUB BL, 'a'
	INC X[BX]
	JMP LL

TOOUT:	OUTCH 'a'
	OUTCH ')'
	OUTCH ' '

	MOV AL, 0
	MOV BX, 0
	MOV CX, 26
L1:	CMP X[BX], 0
	JNA SKIP
	INC AL
SKIP:	INC BX
	LOOP L1

	MOV AH, 0
	OUTWORD AX
	NEWLINE
	JMP B_L

ERR_L:	LEA DX, ERR_MESS
	OUTSTR
	NEWLINE
	FINISH

B_L:	OUTCH 'b'
	OUTCH ')'
	OUTCH ' '

	MOV AL, 0
	MOV AH, X
	MOV BX, 1
	MOV CX, 25
L2:	CMP X[BX], AH
	JNA SKIP2
	MOV AL, BL
	MOV AH, X[BX]
SKIP2:	INC BX
	LOOP L2

	CMP AL, 0
	JNA ERR_L
	ADD AL, 'a'
	OUTCH AL
	NEWLINE
	FINISH
CODE ENDS
END START