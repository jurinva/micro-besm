	NAME BB
code segment at 1000h
assume	cs:code
START:
	MOV	CX,8
	MOV	DX,0C8H
	NOP
	MOV	AL,01H
C1:	OUT 	DX,AL
	INC	DX
	ROL	AL,1
	NOP
	LOOP	C1
	MOV	CX,8
	MOV	DX,0C8H
	NOP
	MOV	AH,01H
C2:	IN	AL,DX
	INC	DX
	CMP	AH,AL
	JE	C3
	MOV	CX,0FFH
	SHL	AL,CL
	MOV	AL,'!'
	OUT	0,AL
C3:	ROL	AH,1
	NOP
	LOOP	C2
	JMP	START
;	int	3
code	ends
	end
