
;		Digit	EQU	P2	;8051 Board
;	LEDselection	EQU	P1	;8051 Board
;
;		Number:	DB	3FH	;Number 0  
;			DB	06H	;Number 1
;			DB	5BH	;Number 2
;			DB	4FH	;Number 3
;			DB	66H	;Number 4
;			DB	6DH	;Number 5
;			DB	7DH	;Number 6
;			DB	07H	;Number 7
;			DB	7FH	;Number 8
;			DB	6FH	;Number 9


;Below defination will be used at 8051-IDE		

		Digit	EQU	P1	; 8051-IDE
	LEDselection	EQU	P3	; 8051-IDE

		Number:	db	11000000b ; 0   C0H
			db	11111001b ; 1	F9H
			db	10100100b ; 2	A4H
			db	10110000b ; 3	B0H
			db	10011001b ; 4	99H
			db	10010010b ; 5	92H
			db	10000010b ; 6	82H
			db	11111000b ; 7	F8H	
			db	10000000b ; 8	80H	
			db	10010000b ; 9	90H
			
		;Student ID : 01100423
	StudentID:	db	10110000b ; 3	B0H
			db	10100100b ; 2	A4H
			db	10011001b ; 4	99H
			db	11000000b ; 0   C0H
			db	11000000b ; 0   C0H
			db	11111001b ; 1	F9H
			db	11111001b ; 1	F9H
			db	11000000b ; 0   C0H	

			ORG	00H
			
			MOV	DPTR,#StudentID
			
	ShowDigit:	MOV	LEDselection,#0FEH	
			;MOV	LEDselection,#0FDH	
			;MOV	LEDselection,#0FBH	
			;MOV	LEDselection,#0F7H	

			MOV	R0,#0
			MOV	R1,#0
			JMP	Here

	NextDigitF:	MOV	A,LEDselection		
			RL	A
			CJNE	R1,#0,Selection		
			RL	A
			
	Selection:	MOV	LEDselection,A
	
	Here:		MOV	A,R0			
			MOVC	A,@A+DPTR
			
			MOV	Digit,A

			MOV	R2,#2	;10
			ACALL	Delay

			MOV	Digit,#0FFH	

			MOV	R2,#1	;5 
			ACALL	Delay
			CJNE	R0,#1,Continue
			JMP	ShowDigit
			
	Continue:	CJNE	R0,#3,THERE
			DEC	R0
			DEC	R0
			JMP	NextDigitBack
			
	THERE:		INC	R0
			INC	R0
			CJNE	R0,#4,NextDigitF		;#6,NextDigit
			DEC	R0
			INC	R1
			JMP	NextDigitF

	NextDigitBack:	MOV	A,LEDselection
			RR	A
			CJNE	R1,#1,Selection		;NextDigitBack
			RR	A
			
			JMP	Selection
	Delay:		MOV	R3,#5	;200		
	Delay1:		MOV	R4,#6	;248	
			DJNZ	R4,$		
			DJNZ	R3,Delay1	
			DJNZ	R2,Delay
			RET
	
			END			