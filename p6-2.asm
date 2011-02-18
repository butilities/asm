; Alexander Turenko. 5.3.2.
INCLUDE IO\io.asm
INCLUDE IO\moreio.asm

STACK SEGMENT STACK
	DB 256 DUP (?)
STACK ENDS

DATA SEGMENT
	MAX_SYMBOLS EQU 100
	SYMBOLS DB MAX_SYMBOLS DUP (?), '.'
DATA ENDS

CODE SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE

; DX - address of first symbol
; CX - count of symbols
PR1 PROC
	CMP CX, 0
	JE Q1

	PUSH CX
	PUSH BX
	PUSH SI
	PUSH AX

	MOV SI, DX
	ADD SI, CX
	MOV BL, 10

L3:	DEC SI
	MOV AL, [SI]

	CMP AL, 'A'
	JB NOCHG
	CMP AL, 'Z'
	JA NOCHG

	SUB AL, 'A'-1; 'A' -> 1, 'Z' -> 26
	MOV AH, 0
	DIV BL; AH = AL DIV 10
	ADD AH, '0'; 1 -> '1'

	MOV [SI], AH
NOCHG:	LOOP L3

	POP AX
	POP SI
	POP BX
	POP CX
Q1:	RET
PR1 ENDP

; DX - address of first symbol
; CX - count of symbols
PR2 PROC
	CMP CX, 0
	JE Q2

	PUSH CX
	PUSH BX
	PUSH SI
	PUSH AX

	MOV BX, DX ; address of first symbol
	MOV SI, DX
	ADD SI, CX
	DEC SI     ; address of last symbol
	SHR CX, 1  ; (count_symbols mod 2) iterations

L4:	; exchange [BX] with [SI]
	MOV AL, [BX]
	XCHG AL, [SI]
	MOV [BX], AL
	; shift BX and SI
	INC BX
	DEC SI
	LOOP L4

	POP AX
	POP SI
	POP BX
	POP CX
Q2:	RET
PR2 ENDP

START:	MOV AX, DATA
	MOV DS, AX

	OUTCH '>'
	OUTCH ' '

	MOV CX, MAX_SYMBOLS
	MOV SI, 0
L1:	INCH AH
	MOV SYMBOLS[SI], AH
	CMP AH, '.'
	JE NXT1
	INC SI
	LOOP L1

NXT1:	; Output symbols
	OUTCH '<'
	OUTCH ' '
	LEA DX, SYMBOLS
	OUTSTR_MORE '.'
	NEWLINE

	MOV AL, 0; For count of upper symbols
	MOV AH, 0; For count of lower symbols
	MOV CX, SI; Count symbols
	MOV SI, 0; Current index in symbols

	CMP CX, 0
	JE NXT2

L2:	CMP SYMBOLS[SI], 'A'
	JB BELOW
	CMP SYMBOLS[SI], 'Z'
	JA BELOW
	INC AL
	JMP CONTIN
BELOW:	CMP SYMBOLS[SI], 'a'
	JB CONTIN
	CMP SYMBOLS[SI], 'z'
	JA CONTIN
	INC AH
CONTIN:	INC SI
	LOOP L2

	OUTCH '<'
	OUTCH ' '
NXT2:	MOV CX, SI; Count of symbols
	CMP AL, AH
	JNE TWO
	OUTCH '1'
	NEWLINE
	CALL PR1
	JMP OUTS
TWO:	OUTCH '2'
	NEWLINE
	CALL PR2

OUTS:	OUTCH '<'
	OUTCH ' '
        LEA DX, SYMBOLS
	OUTSTR_MORE '.'
	NEWLINE

	FINISH
CODE ENDS
END START
