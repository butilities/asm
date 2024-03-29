; Alexander Turenko. 9.15.
INCLUDE IO\io.asm

STACK SEGMENT STACK
	DW 64 DUP (?)
STACK ENDS

SIGN MACRO X
	LOCAL ZERO, GREATER, END_OF_MACRO
	MOV AL, -1
	IF TYPE X NE DWORD
		CMP X, 0
		JL END_OF_MACRO
		JE ZERO
		;JG GREATER
	ELSE
		CMP WORD PTR X+2, 0
		JL END_OF_MACRO
		JG GREATER
		CMP WORD PTR X, 0
		JL END_OF_MACRO
		JE ZERO
		;JG GREATER
	ENDIF
GREATER:
	INC AL
ZERO:
	INC AL
END_OF_MACRO:
ENDM

CODE SEGMENT
	ASSUME SS:STACK, CS:CODE

	IRP T, <B, W, D>
		T&1 D&T -1
		T&2 D&T 0
		T&3 D&T 1
	ENDM

START:
	MOV AX, CODE
	MOV DS, AX

	XOR AH, AH
	IRP T, <B, W, D>
		IRP N, <1, 2, 3>
			SIGN <T&&N>
			OUTWORD AX, 6
		ENDM
		NEWLINE
	ENDM

	FINISH
CODE ENDS
END START
