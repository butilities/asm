INCLUDE IO\io.asm

VAREQ MACRO A, B
	LOCAL NOT_E
	PUSH AX
IF TYPE A EQ DWORD
	MOV AX, A
	CMP AX, B
	JNE NOT_E
	MOV AX, A+2
	CMP AX, B+2
	JNE NOT_E
	POP AX
	MOV AL, 0FFh
ELSE
	MOV AX, A
	CMP AX, B
	JNE NOT_E
	POP AX
	MOV AL, 0FFh
ENDIF
NOT_E:	POP AX
	MOV AL, 0
ENDM

STACK SEGMENT STACK
	DB 128 DUP (?)
STACK ENDS

CODE SEGMENT
	ASSUME CS:CODE
START:	MOV AX, CODE
	MOV DS, AX

	MOV AX, -1
	VAREQ AX, 0FFFFh
	OUTWORD AL
	FINISH
CODE ENDS
END START
