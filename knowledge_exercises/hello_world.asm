;we have declared the data section
;what i can understand is that a data section's logevitiy is the same
;as the program longevity
section .data
	msg db "ciao bello"
;the text section contains instructions for the program
;every program is a set of instructions that are told to
;the computer to perform specific tasks

;;about global
;here we define the _start which is actually
;from where the code is gonna be read.
;AND only with the global suffix we are making
;it visible to the linker
section .text
	global _start

_start:
	mov rax, 1 ;this is not related to the function call it's literally what function are you calling!!!
	mov rdi, 1
	mov rsi, msg
	mov rdx, 11
	syscall

	;calling the exit function with the rax syscall
	mov rax, 60
	mov rdi, 0
	syscall
