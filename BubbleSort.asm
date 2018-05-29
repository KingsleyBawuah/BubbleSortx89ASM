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
	TWO						=		2

.data
	; declare variables here

	programGreeting			BYTE	"Hello, this is Kingsley and this is programming assignment of 5!",0
	instruction				BYTE	"Please enter a number between 10 and 200, and i will generate random integers in a range of 100 - 999. I will then sort the numbers in descending order, display them and the median value which will be rounded to the nearest integer",0
	unsortText				BYTE	"The unsorted numbers are : ",0
	sortText				BYTE	"The sorted numbers are : ",0
	medianText				BYTE	"The median of the list of generated numbers is: ",0
	wordSpace				BYTE	"   ",0
	request					DWORD	?
	array					DWORD	MAX		DUP(?)

.code
main proc
	; write your code here

	CALL		introduction
	PUSH		OFFSET request ;passing value by reference so it can be modified when getData returns a user validated value.
	CALL		getData
	CALL		Randomize    ;IS THIS OKAY TO CALL HERE? SINCE I MODIFY THE STACK FRAME.
	PUSH		OFFSET array
	PUSH		request
	CALL		fillArray
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
		;MOV			[EDI],EAX
		ADD			EDI,4
		LOOP		continue

	POP			EBP
	RET			




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


;Then
	MOV			EDI,[EBP+12] ;Move array parameter to the EDI register.
	MOV			ECX,[EBP+8] ;Bring the counter in to the ECX register.

;Divide request in half to find median.

	MOV		EAX, ECX
	CDQ
	MOV		EDX,2
	CDQ		;This is causing 0 to be placed in EDX. why?
	DIV		EDX

	POP		EBP
	RET		


displayMedian ENDP

displayList	  PROC



;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP


;Then
	MOV			EDI,[EBP+12] ;Move array parameter to the EDI register.
	MOV			ECX,[EBP+8] ;Bring the counter in to the ECX register
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


xChange	  PROC
;This procedure will 
;Procedure starter kit
	PUSH		EBP
	MOV			EBP,ESP

xChange	  ENDP



end main