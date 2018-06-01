TITLE Bubble Sort  (BubbleSort.asm)

; Kingsley Bawuah
; Description: This program prints out a random list of user requested numbers between a range, then sorts them and displays them with the median of the values.. Written for CS 271.

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
INCLUDE Irvine32.inc


;Equality directives
	MIN						=		10
	MAX						=		200
	LO						=		100
	HI						=		999
	TWO						=		2

.data

	programGreeting			BYTE	"Hello, this is Kingsley and this is programming assignment of 5!",0
	instruction				BYTE	"Please enter a number between 10 and 200, and i will generate random integers in a range of 100 - 999. I will then sort the numbers in descending order, display them and the median value which will be rounded to the nearest integer",0
	unsortText				BYTE	"The unsorted list of random numbers  : ",0
	sortText				BYTE	"The sorted list of numbers (Descending) : ",0
	medianText				BYTE	"The median of the list of random numbers is: ",0
	wordSpace				BYTE	"   ",0
	request					DWORD	?
	array					DWORD	MAX		DUP(?)
	insideLCount			DWORD	?

.code
main proc

	CALL		introduction
	PUSH		OFFSET request ;passing value by reference so it can be modified when getData returns a user validated value.
	CALL		getData
	CALL		Randomize    ;IS THIS OKAY TO CALL HERE? SINCE I MODIFY THE STACK FRAME.
	PUSH		OFFSET array
	PUSH		request
	CALL		fillArray
	CALL		CrlF
	MOV			EDX, OFFSET unsortText
	CALL		WriteString
	CALL		CrlF
	PUSH		OFFSET array
	PUSH		request
	CALL		displayList

	PUSH		OFFSET array
	PUSH		request
	CALL		sortList
	CALL		CrlF
	MOV			EDX, OFFSET sortText
	CALL		WriteString
	CALL		CrlF
	PUSH		OFFSET array
	PUSH		request
	CALL		displayList

	PUSH		OFFSET array
	PUSH		request
	CALL		displayMedian

	invoke ExitProcess,0
main endp

;Introduces the user to the program. Then push request param onto stack, then call getData for validation.
introduction PROC
	MOV			EDX, OFFSET programGreeting
	CALL		WriteString
	CALL		CrlF


	
	RET

introduction ENDP


;Display instructions to user and validate entered number. Accepts no paramaters.
getData		 PROC

	;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP


	start:
	MOV			EDX, OFFSET instruction
	CALL		WriteString
	CALL		CrlF
	CALL		ReadInt
	CMP			EAX,MIN
	JGE			greaterThan
	JL			start

	greaterThan:
	CMP			EAX,MAX
	JLE			endData
	JG			start

	endData:
	MOV			EBX,[EBP + 8] ;This moves the address for request into thw EBX register
	MOV			[EBX],EAX ;Access the value in EBX (Which is request) and set it to the validated number.
	POP			EBP
	RET
	

getData		 ENDP


;fillArray is passed the Array by reference and Request by value.
fillArray	 PROC

;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP


;Then
	MOV			EDI,[EBP+12] ;Move array parameter to the EDI register.
	MOV			ECX,[EBP+8] ;Bring the counter in to the ECX register.


	continue:
		;Code to generate a random numbers goes here.
		MOV			EAX,900
		CALL		RandomRange
		ADD			EAX,LO
		MOV			[EDI],EAX ;Moves random int from EAX into EDI referenced as value.


		;Move through each element
		ADD			EDI,4
		LOOP		continue

	POP			EBP
	RET			




fillArray	 ENDP

;sortList is passed the Array by reference and Request by value.
sortList	 PROC

;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP

	

	;Set up outer counter.
	MOV			ECX,[EBP+8] ;Bring the counter in to the ECX register

	DEC			ECX

	L1:
	;This will save the outer loop counter.
	PUSH		ECX
	MOV			EDI,[EBP+12] ;Move array parameter to thge EDI register.

	; Take array value and do comparisons and or exhange values.
	L2: 
	MOV			EAX,[EDI]
	CMP			[EDI+4],EAX
	Jl			L3
	XCHG		EAX,[EDI+4]
	MOV			[EDI],EAX
	;Proceed through the array
	L3: 
	ADD			EDI,4
	LOOP		L2
	;Loop Control.
	POP			ECX
	LOOP		L1
	L4:
	POP			EBP
	RET			8
sortList	 ENDP

;displayMedian is passed the Array by reference and Request by value.
displayMedian PROC





;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP


;Then
	MOV			EDI,[EBP+12] ;Move array parameter to the EDI register.
	MOV			ECX,[EBP+8] ;Bring the counter in to the ECX register.

;Divide request in half to find median.
	MOV		EAX, ECX
	CDQ
	MOV		EBX,2
	CDQ		
	DIV		EBX
	DEC		EAX
	MOV		EDX,4
	IMUL	EAX,EDX
	ADD		EDI,EAX
	MOV		EAX,[EDI]
	CALL	CrlF
	MOV		EDX,OFFSET medianText
	CALL	WriteString
	CALL	WriteInt ;median will still be in EAX.
	CALL	CrlF



;Ends the procedure.
	POP		EBP
	RET		


displayMedian ENDP

displayList	  PROC



;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP


;Then
	MOV			EDI,[EBP+12] ;Move array parameter to the EDI register.
	MOV			ECX,[EBP+8] ;Bring the counter in to the ECX register.
	MOV			EBX,9 ;Move line counter to EBX


		continue:
		MOV			EAX,[EDI] ;Moves random int from EAX into EDI referenced as value.
		CALL		WriteDec ;TESTING array is filled.
		MOV			EDX,OFFSET wordSpace
		CALL		WriteString

		CMP			EBX,0
		JE			nextline
		JG			nextElement


		nextLine:
		CALL		CrlF
		MOV			EBX,10
		JMP			nextElement


		;Move through each element
		nextElement:
		DEC			EBX
		ADD			EDI,4
		LOOP		continue


		

	POP			EBP
	RET			8
			
displayList	  ENDP





end main