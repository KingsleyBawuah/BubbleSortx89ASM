; Program template

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
INCLUDE Irvine32.inc


.data
	; declare variables here
	MIN						=		10
	MAX						=		200
	LO						=		100
	HI						=		999
	programGreeting			BYTE	"Hello, this is Kingsley and this is programming assignment of 5!",0
	instruction				BYTE	"Please enter a number between 10 and 200, and i will generate random integers in a range of 100 - 999. I will then sort the numbers in descending order, display them and the median value which will be rounded to the nearest integer",0
	unsortText				BYTE	"The unsorted numbers are : ",0
	sortText				BYTE	"The sorted numbers are : ",0
	enteredNUM				DWORD	?

.code
main proc
	; write your code here

	CALL		introduction
	CALL		getData

	invoke ExitProcess,0
main endp

;Introduces the user to the program.
introduction PROC
	MOV			EDX, OFFSET programGreeting
	CALL		WriteString
	CALL		CrlF
	MOV			EDX, OFFSET instruction
	CALL		WriteString
	CALL		CrlF
	RET

introduction ENDP



getData		 PROC
	
	start:
	CALL		ReadInt
	CMP			EAX,MIN
	JGE			greaterThan
	JL			start

	greaterThan:
	CMP			EAX,MAX
	JLE			endData
	JGE			start

	endData:
	MOV			enteredNUM, EAX
	RET

getData		 ENDP

fillArray	 PROC

fillArray	 ENDP

sortList	 PROC

sortList	 ENDP

displayMedian PROC

displayMedian ENDP

displayList	  PROC

displayList	  ENDP




end main