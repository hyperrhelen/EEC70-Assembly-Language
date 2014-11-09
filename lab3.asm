TITLE lab3              (lab3.asm)

; labs 25%
; Hw 15%
; ex1 10%
; ex2 20%
; ex3 30%


INCLUDE Irvine32.inc


.data

	Labs	BYTE	6	DUP(?)
	Hws	BYTE	6	DUP(?)
	Exams	BYTE	3	DUP(?)
	
	linput 	BYTE "Enter the six lab grades: ",0
	lgrade	BYTE "Lab0: ",0

	hinput 	BYTE "Enter the six Hw grades: ",0
	hgrade	BYTE "Hw0: ",0

	einput 	BYTE "Enter the three exam grades: ",0
	egrade	BYTE "Exam0: ",0

	total	BYTE "Total Grade = ",0
	letter	BYTE "Letter Grade = ",0
	
.code

main PROC

	; ---------------- Read lab grades ---------------

		mov edx, OFFSET linput
		call WriteString
		call crlf

		mov edi, OFFSET Labs		
		mov ecx, 6
				
	loop1:	
		inc [lgrade+3]
		mov edx, OFFSET lgrade
		call WriteString

		call Readint
		mov [edi], al
		add edi, 1
		loop loop1

	; ---------------- Read Hw grades ---------------

		mov edx, OFFSET hinput
		call WriteString
		call crlf

		mov edi, OFFSET Hws		
		mov ecx, 6
				
	loop2:	
		inc [hgrade+2]
		mov edx, OFFSET hgrade
		call WriteString

		call Readint
		mov [edi], al
		add edi, 1
		loop loop2


	; ---------------- Read Exams grades ---------------

		mov edx, OFFSET einput
		call WriteString
		call crlf

		mov edi, OFFSET exams		
		mov ecx, 3
				
	loop3:	
		inc [egrade+4]
		mov edx, OFFSET egrade
		call WriteString

		call Readint
		mov [edi], al
		add edi, 1
		loop loop3


	; ---------------- Compute the total grade ---------

	
		mov esi, OFFSET Labs
		mov bl, [esi]
		mov dl, bl
		movzx ax, bl
		inc esi
		mov ecx, 5

	loop4:	
		movzx bx, BYTE PTR [esi]
		add ax, bx
		cmp bl, dl
		jg next4
		mov dl, bl
	next4:	
		inc esi
		loop loop4
		movzx dx, dl
		sub ax, dx
		
		; multiply LT by 5

		mov dx, ax
		add ax, ax
		add ax, ax
		add ax, dx
				
		push ax

		mov esi, OFFSET Hws
		mov bl, [esi]
		mov dl, bl
		movzx ax, bl
		inc esi
		mov ecx, 5

	loop5:	
		movzx bx, BYTE PTR [esi]
		add ax, bx
		cmp bl, dl
		jg next5
		mov dl, bl
	next5:	
		inc esi
		loop loop5
		movzx dx, dl
		sub ax, dx

		; multiply HT by 3
		
		mov bx, ax
		add ax, ax
		add ax, bx
		
		pop bx
		add ax, bx


		push ax
		mov esi, OFFSET Exams
		movzx dx, BYTE PTR [esi]
		mov ax, dx

		; multiply E1 by 10

		add ax, ax
		add ax, ax
		add ax, ax
		add ax, dx
		add ax, dx 
		
		pop bx
		add ax, bx


		push ax
		mov esi, OFFSET Exams
		inc esi
		movzx ax, BYTE PTR [esi] 		
			
		; multiply E2 by 20

		add ax, ax
		add ax, ax
		mov dx, ax
		add ax, ax
		add ax, ax
		add ax, dx 

		pop bx
		add ax, bx


		push ax
		mov esi, OFFSET Exams
		add esi, 2
		movzx ax, BYTE PTR [esi]
		
		; multiply EF by 30

		add ax, ax
		mov dx, ax
		add ax, ax
		add ax, ax
		add ax, ax
		add ax, ax
		sub ax, dx
		
		pop bx
		add ax, bx

		mov bl, 100
		div bl

		mov edx, OFFSET total
		call WriteString

		movzx eax, al
		call WriteInt
		call crlf

	; ---------------- Compute the letter grade ---------

		mov edx, OFFSET letter
		call WriteString

		cmp al, 85
		jg Alabel
		cmp al, 75
		jg Blabel
		cmp al, 65
		jg Clabel
		cmp al, 59
		jg Dlabel

		
		mov al, 'F'
		jmp done

	Alabel:	
		mov al, 'A'
		jmp done

	Blabel:	
		mov al, 'B'
		jmp done

	Clabel: 
		mov al, 'C'
		jmp done

	Dlabel:	
		mov al, 'D'
	
	done:	call WriteChar
		call crlf

		exit
main ENDP

END main