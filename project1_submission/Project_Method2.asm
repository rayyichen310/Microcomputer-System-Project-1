;期中Project
;P1.0, P1.1, P1.2的值是用來選取7-Segment LED的位置
;P2的值是用來控制數字的顯示(0~9)

;將顯示7-Segment LED display的數字所需的P2值,依下列順序及Student ID,先儲存
;digit-0 => digit-1 => digit-2 => digit-3 => digit-4 =>
;digit-5 => digit-6 => digit-7 
;將7-Segment LED 的位置所需的P1值,依所上列要求的順序儲存
;利用R0當作Index去選取將要顯示的LED位置及數字所需的P1.0, P1.1, P1.2值
;及P2的值,並將此些值寫入P1及P2
;使用R2當作LED位置的移動方向指標,
;當R2=0時向左移動,當R2=1時向右移動
;在程式中去檢查將要顯示的LED位置是否為digit-1,digit-6,digit-7及LED移動的方向,
;依據檢查的結果做適當的處置來完成此Project的要求

;Student ID : 01100423
StudentID:	DB	4FH	;10110000b ; 3
		DB	5BH	;10100100b ; 2
		DB	66H	;10011001b ; 4
		DB	3FH	;11000000b ; 0
		DB	3FH	;11000000b ; 0
		DB	06H	;11111001b ; 1
		DB	06H	;11111001b ; 1
		DB	3FH	;11000000b ; 0

;根據Project, LED的位置定義如下
;由左至右: Digit-7 Digit-6 Digit-5 Digit-4 Digit-3 Digit-2 Digit-1 Digit-0
;其相對應的 P1.0  P1.1  P1.2的值儲存如下
LEDPosition:	DB	0FFH	;Digit-0 
		DB	0FEH	;Digit-1
		DB	0FDH	;Digit-2
		DB	0FCH	;Digit-3
		DB	0FBH	;Digit-4
		DB	0FAH	;Digit-5
		DB	0F9H	;Digit-6
		DB	0F8H	;Digit-7


		ORG	00H

;定義 R0,R2在此程式的功能角色
;將R0當作一個index去選取將要Dislay的LED位置及數字
;使用R2當作LED位置的移動方向指標,當R2=0時向左移動,當R2=1時向右移動
StartShowDigit:	MOV	R0,#0		;將R0初始值設為0
		MOV	R2,#0		;將R2初始5值設為0, LED移動位置向左	

;Load P1的值 for LED的位置, load P2的值 for LED顯示的數字
NextDigitF:	MOV	DPTR,#LEDPosition	;將儲存LED位置相對應的P1值的起始Address放入DPTR
		MOV	A,R0		;將目前的R0值(index)放入A中
		MOVC	A,@A+DPTR	;將displaying LED位置相對應的P1值放入A中
		MOV	P1,A		;將選定要Displaying LED位置相對應的P1值放入P1

		MOV	DPTR,#StudentID	;將儲存顯示數字相對應的P2值的起始Address放入DPTR
		MOV	A,R0		;將目前的R0值(index)放入A中
		MOVC	A,@A+DPTR	;將顯示數字相對應的P2值放入A中
		MOV	P2,A		;將選定要顯示的數字相對應的P2值放入P2
			 		

		MOV	R3,#10		;R3=10時產生1秒延遲,after displaying digit
		ACALL	Delay

		MOV	P2,#000H	;To turn off displauing digit
		MOV	R3,#5		;R3=5時產生0.5秒延遲 after turn off LED

		ACALL	Delay

;以下程式,check
;1.LED顯示方向是否有改變,若有改變R2=1(向右移動),go to NextDigitBack處理
;2.LED的位置是否為從最右往左算第二個LED,若是則從頭開始(loop)
;3.Check顯示LED的位置是否為最左邊,若是則準備改變顯示LED的方向(向右)
;4.Check顯示LED的位置是否為最左邊往右第二個,若是則再往左移一個使顯示LED為最左邊的LED
;
		CJNE	R2,#0,NextDigitBack	;CheckLED顯示方向是否有改變
					;若有改變R2=1(向右移動),go to NextDigitBack處理
		CJNE	R0,#1,Check7	;Check LED顯示的位置是否為從最右往 
 		JMP	StartShowDigit	;左算第二個LED, 若是則從頭開始顯示(即從最右邊的LED開始顯示)
					;Jump to StartShowDigit從頭開始顯示數字)
Check7:		CJNE	R0,#7,Continue	;Check LED顯示的位置的位置是否為最左邊
		JMP	NextDigitBack	;若是則準備改變LED顯示的方向(向右)
					;Jump to NextDigitBack去處理
			
Continue:	CJNE	R0,#6,Forward	;Check LED顯示的位置是否為最左邊往右第二個
		INC	R0		;若是則再往左移一個使將顯示的LED為最左邊的LED,此時R0=7
		MOV	R2,#1		;設定R2=1,改變LED顯示移動的方向(向右)for
		JMP	NextDigitF	;後續檢查顯示數字移動的方向用
			
Forward:	INC	R0		;若R0不等於6或7,就會跳到這裡處理
		INC	R0		;此時顯示數字移動的方向向左(R0<6)
		JMP	NextDigitF

;以下程式是處理顯示數字移動向右的方向
NextDigitBack:	DEC	R0		;將R0當作一個index去選取將要顯示的LED位置及數字
		DEC	R0		;將R0減2

		CJNE	R0,#1,NextDigitF	;Check 顯示LED的位置是否為從最右往
					;左算第二個LED, 若是則顯示目前的數字完
					;後從頭開始(即最右邊的LED開始顯示)
						
		MOV 	R2,#0		;若目前的LED位置為從最右往左算第二個
					;LED,則在顯示目前的數字前將顯示的方向
					;改為向左準備從頭開始(即最右邊的LED開始顯示)
		JMP	NextDigitF

;以下為依據指令的執行時間乘上重複執行的次數來計算出delay的時間U有使用多重loop
Delay:		MOV	R4,#200;#200	;設定 R4=200 產生延遲0.1秒
Delay1:		MOV	R5,#248;#248	;設定 R5=248 產生延遲0.000496秒
		DJNZ	R5,$		;延遲時間:2 machine cycle x 248(R5)=0.000002秒 x 248=0.000496秒
		DJNZ	R4,Delay1	;延遲時間:0.000496+0.000002x2(2指令:MOV,DJNZ)=0.0005x200(R4)=0.1秒
		DJNZ	R3,Delay	;延遲時間:0.1 x(R3)秒,R3=10 =>延遲1秒, R3=5 =>延遲0.5秒
		RET
	
		END			