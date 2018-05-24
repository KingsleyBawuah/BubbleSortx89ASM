; Program template

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

.data
	; declare variables here

	programGreeting			BYTE	"Hello, this is Kingsley and this is programming assignment of 5!",0
	instruction				BYTE	"Please enter a number between 10 and 200, and i will generate random integers in a range of 100 - 999. I will then sort the numbers in descending order, display them and the median value which will be rounded to the nearest integer",0
	unsortText				BYTE	"The unsorted numbers are : ",0
	sortText				BYTE	"The sorted numbers are : ",0
	request					DWORD	?
	array					DWORD	MAX		DUP(?)

.code
main proc
	; write your code here

	CALL		introduction
	PUSH		OFFSET request ;passing value by reference so it can be modified when getData returns a user validated value.
	CALL		getData
	PUSH		request
	PUSH		OFFSET array
	CALL		fillArray

	invoke ExitProcess,0
main endp

;Introduces the user to the program. Then push request param onto stack, then call getData for validation.
introduction PROC
	MOV			EDX, OFFSET programGreeting
	CALL		WriteString
	CALL		CrlF


	
	RET

introduction ENDP


;Display instructions to user and validate entered number.
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

fillArray	 PROC

;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP

fillArray	 ENDP

sortList	 PROC

;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP

sortList	 ENDP

displayMedian PROC

;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP

displayMedian ENDP

;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP

displayList	  PROC

;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP

displayList	  ENDP




end main