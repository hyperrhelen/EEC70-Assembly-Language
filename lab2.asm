TITLE Polynomial              (lab2.asm)

; This program computes a specific polynomial

INCLUDE Irvine32.inc

.data
	sinput  BYTE "Enter the value of x : ",0
	soutput BYTE "The value of y is    : ",0

.code
main PROC
			call crlf
			mov edx, OFFSET sinput
			call WriteString
			mov ebx, 1
			call ReadHex
			mov edx, eax
			add ebx, eax
			add ebx, eax
			add ebx, eax
			call computex2
			add ebx, eax
			add ebx, eax
			add ebx, eax
			mov eax, edx
			call computex3
			add ebx, eax
			mov eax, edx
			call computex5
			add ebx, eax
			mov edx, OFFSET soutput
			call WriteString
			mov eax, ebx
			call WriteHex
			call crlf
			exit
main ENDP

computex2 PROC
	; X is in EAX and Y=x^2 is in EAX
			push ecx
			push edx
			mov ecx, eax
			mov edx, eax		
			mov eax,0
	loop1:		add eax, edx
			loop loop1
			pop edx
			pop ecx
			ret
computex2 ENDP

computex3 PROC
	; X is in EAX and Y=x^3 is in EAX
			push ecx
			push edx
			mov ecx, eax
			call computex2
			mov edx, eax
			mov eax,0
	loop2:		add eax, edx
			loop loop2
			pop edx
			pop ecx
			ret
computex3 ENDP

computex5 PROC
	; X is in EAX and Y=x^5 is in EAX
			push ecx
			push edx
			mov ecx, eax
			call computex2
			xchg eax, ecx
			call computex3
			mov edx, eax
			mov eax,0
	loop3:		add eax, edx
			loop loop3
			pop edx
			pop ecx
			ret
computex5 ENDP

END main
