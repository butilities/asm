; Alexander Turenko.
INCLUDE IO\io.asm

STACK SEGMENT STACK
	DB 128 DUP (?)
STACK ENDS

CODE SEGMENT
	ASSUME SS:STACK, CS:CODE
START:
	MOV AX, [BP]
	MOV BX, [BP]
	MOV AX, [SI]
	MOV BX, [SI]
	FINISH
CODE ENDS
END START