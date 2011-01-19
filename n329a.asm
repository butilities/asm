; Turenko Aexander. 3.29(a).
INCLUDE IO\io.asm
INCLUDE IO\moreio.asm

STACK SEGMENT STACK
	DB 128 DUP (?)
STACK ENDS

DATA SEGMENT
	N EQU 100
	X DB N DUP (?), '.'
DATA ENDS

CODE SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE
START:	MOV AX, DATA
	MOV DS, AX

	OUTCH '>'
	OUTCH ' '

	MOV CX, N
	MOV SI, 0
LL:	INCH AL
LLL:	MOV X[SI], AL
	INC SI
	CMP AL, '.'
	JE TOOUT
	CMP AL, 'P'
	JNE NEXT
	INCH AL
	CMP AL, 'H'
	JNE NEXT2
	MOV X[SI-1], 'F'
	JMP NEXT
NEXT2:	LOOP LLL
NEXT:	LOOP LL

TOOUT:	OUTCH '<'
	OUTCH ' '
	LEA DX, X
	OUTSTR_MORE '.'

	FINISH
CODE ENDS
END START
