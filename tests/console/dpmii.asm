	NAME DPM
BOOT	SEGMENT AT 0FFFFH
STR	LABEL	WORD
BOOT	ENDS
code segment at 0E000h
assume	cs:code
START:
	MOV	DX,4096
	MOV	AX,0E000H
	MOV	ES,AX
	MOV	AX,0FC00H
	MOV	DS,AX
	MOV	CX,DX
	STD
	MOV	SI,03FFEH
	MOV	DI,03FFEH
C123:
	XOR	BX,BX
	MOVSW
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	LOOP C123
;	MOV	BX,01FF1H
;	MOV	AX,0C7CH
;	MOV	ES:[BX],AX
	MOV	CX,127

	MOV	DX,100H
	MOV	AX,800H
	XOR BX,BX
C1:
	OUT 	DX,AX
	ADD	DX,2
	INC AX
	NOP
	LOOP	C1
	MOV	DX,01FEH
	MOV	AX,873H
	OUT	DX,AX
	NOP
	NOP
	NOP
	CLI
	MOV	AX,1
	OUT	0AAH,AX
	NOP
	NOP
	NOP
	NOP
	NOP
;	DB	0EAH
;	DW 	0
;	DW	0FFFFH
	int	3
code	ends
	end
