;期中Project
;P1.0, P1.1, P1.2的值是用來選取7-Segment LED的位置
;P2的值是用來控制數字的顯示(0~9)

;將顯示7-Segment LED display的數字所需的P2值,依所要求的順序及Student ID儲存,
;順序 digit-0 => digit-2 => digit-4 => digit-6 => digit-7 => 
;digit-5 => digit-3 => digit-1 => digit-0 (repeat)
;將選取7-Segment LED 的位置所需的P1值,依所上列要求的順序儲存
;利用R0當作Index去選取將要顯示的LED位置及數字所需的
;P1.0, P1.1, P1.2值及P2的值,並將此些值寫入P1及P2,
;在要求的LED位置去顯示要求的數字來完成此Project的Requirement.

DisplayDigit:	DB	4FH,66H,3FH,06H,3FH,06H,3FH,5BH

;將7-Segment LED display的位置所需的P1值,依所上列要求的順序,先予儲存
LEDPosition:	DB	0FFH,0FDH,0FBH,0F9H,0F8H,0FAH,0FCH,0FEH

		ORG	00H

Loop:		MOV	A,#0		;設定A=0,初始值
		MOV	R0,#0		;設定R0=0,初始值,R0<8,利用R0當作index及counter)

Start:		MOV	A,R0
		MOV	DPTR,#LEDPosition	;將儲存LED位置相對應的P1值的起始Address放入DPTR
		MOVC	A,@A+DPTR		;將displaying LED位置相對應的P1值放入A中
		MOV	P1,A			;將選定要Displaying LED位置相對應的P1值放入P1

		MOV	A,R0
		MOV	DPTR,#DisplayDigit	;將儲存display digit相對應的P2值的起始Address放入DPTR
		MOVC	A,@A+DPTR		;將要顯示的數字相對應的P2值放入A中
		MOV	P2,A			;將選定顯示的數字相對應的P2值放入P2以顯示數字

		MOV	R3,#10		;R3=10時產生1秒延遲,after displaying digit
		ACALL	Delay

		MOV	P2,#000H	;To turn off displauing digit
		MOV	R3,#5		;R3=5時產生0.5秒延遲 after turn off LED
		ACALL	Delay

		INC	R0		;R0增加1,指向下一個要顯示的數字及位置
		CJNE	R0,#8,Start	;若目前未顯示完8次數字,則跳到Start利用R0當作index
					;去取得下一個要顯示的數字及LED位置
						
		JMP	Loop		;若目前已顯示完8次數字(每一循環顯示8次)則跳到Loop,從最右邊的
					;LED重複開始顯示

;以下為依據指令的執行時間乘上重複執行的次數來計算出delay的時間],有使用多重loop
Delay:		MOV	R4,#200;#200	;設定 R4=200 產生延遲0.1秒
Delay1:		MOV	R5,#248;#248	;設定 R5=248 產生延遲0.000496秒
		DJNZ	R5,$		;延遲時間:2 machine cycle x 248(R5)=0.000002秒 x 248=0.000496秒
		DJNZ	R4,Delay1	;延遲時間:0.000496+0.000002x2(2指令:MOV,DJNZ)=0.0005x200(R4)=0.1秒
		DJNZ	R3,Delay	;延遲時間:0.1 x(R3)秒,R3=10 =>延遲1秒, R3=5 =>延遲0.5秒
		RET

		END
