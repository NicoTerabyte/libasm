;this section is to initialize the variable
;!notice that the declaration and initialization
;doesn't need the comma (,) because it's not an operation
section .data
	;i define the size in bytes of the two variables
	;the name (num1) is choosen by me but the
	;the quantity of bytes is defined by db itself(look readme)
	num1 db 100
	num2 db 50
	basic_text db "yo bello"

;this section is used to say how big a variable can be but without
;having it initialized
section .bss
	small_text resb 10

; this section is to say to the computer where the code of the program will be placed
section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, basic_text
	mov rdx, 11
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
