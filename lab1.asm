TITLE First Lab              (lab1.asm)

; This program computes f(n)=n!+n*n+1 for n=1 to 10

INCLUDE Irvine32.inc

.code
main PROC
			; initialize registers
			
			mov edx, 1			; edx contains the (n-1)!
			mov ebx, 1			; ebx contains n
	loop1:	mov eax, 0			; clear accumulator

			; Step1 -- compute n!

			mov ecx, ebx		; set loop counter to n
	loop2:	Add eax, edx		; calculate partial sums
			loop loop2			; Go back to compute the sum

			; At this time, eax holds n!

			mov edx, eax		; store n! in edx for next computation

			; Step2 -- compute n*n and add it to eax

			mov ecx, ebx
	loop3:	Add eax, ebx		; calculate partial sums
			loop loop3			; Go back to compute the sum
			
			; At this time, eax holds n!+n*n
			
			inc eax

			; At this time, eax holds f(n)
			; Print registers ebx = n and eax = f(n)

			call DumpRegs		

			; Prepare registers for next iteration

			mov ecx,11
			sub ecx, ebx
			inc ebx			; n = n+1

			loop loop1			; Repeat the above for next n

			exit

main ENDP
END main