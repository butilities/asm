; Turenko Alexander.
; Last updates: 2010.05.11.

; Output string to symbol END_SYMBOL
; DS:DX - address of begin string
OUTSTR_MORE MACRO END_SYMBOL
	LOCAL LOOPER, TOQUIT
	PUSH DX
	PUSH AX
	PUSH BX

	MOV BX, DX
	MOV AH, 2

LOOPER:	MOV DL, [BX]
	CMP DL, END_SYMBOL
	JE TOQUIT
	INT 21h
	INC BX
	JMP LOOPER

TOQUIT:	POP BX
	POP AX
	POP DX
	ENDM
