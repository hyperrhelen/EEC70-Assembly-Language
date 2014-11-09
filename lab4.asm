TITLE lab4              (lab4.asm)

INCLUDE Irvine32.inc

.data
	instrg		BYTE "Enter the value of n in Hex: ", 0
	outstr1 		BYTE "Hex value of F(n) using Fib1: ", 0
	outstr2 		BYTE "Hex value of F(n) using Fib2: ", 0
	execstr2 		BYTE "Execution time of Fib2 in ms: ", 0

.code
main PROC
			mov edx, OFFSET instrg
			call WriteString
			call ReadHex
			mov esi, eax
			
			push esi
			call Fib1
			mov edx, OFFSET outstr1
			call WriteString
			call WriteHex
			call crlf

			call GetMseconds
			mov edi, eax
			
			push esi
			call Fib2

			push eax
			call GetMseconds
			sub eax, edi
			mov edi, eax
			pop eax

			mov edx, OFFSET outstr2
			call WriteString
			call WriteHex
			call crlf

			mov eax, edi
			mov edx, OFFSET execstr2
			call WriteString
			call WriteDec
			call crlf
			exit
main ENDP


Fib1 PROC
			push ebp
			mov ebp, esp
			mov ecx, [ebp+8]
			cmp ecx, 2
			jbe done
			mov ebx, 1
			mov edx, 1
			sub ecx, 2
	again:		
			mov eax, ebx
			add eax, edx
			mov edx, ebx
			mov ebx, eax			
			loop again
			jmp quit
	done:		mov eax, 1
	quit:		pop ebp
			ret 4
Fib1 ENDP

Fib2 PROC
			push ebp
			mov ebp, esp
			push ebx
			mov eax, [ebp+8]
			cmp eax, 2
			jbe done
			sub eax, 1
			push eax
			call Fib2 
			mov ebx, eax
			mov eax, [ebp+8]
			sub eax, 2
			push eax
			call Fib2
			add eax, ebx	
			jmp quit
	done:		mov eax, 1
	quit:		pop ebx
			pop ebp
			ret 4
Fib2 ENDP

END main
