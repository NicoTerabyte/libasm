;; exercise create a program that takes your name and it displays it on the terminal
section .bss
	usr_name resb 50

section .rodata
	input_request db "Inserisci il tuo nome per favore", 0Ah
	welcome_msg db "Felice di conoscerti "

section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, input_request
	mov rdx, 33
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, usr_name
	mov rdx, 50
	syscall

	;; to avoid having garbage memory hanging with the lenght
	;; of the string took by input i save it in a register that i don't use
	mov r10, rax

	mov rax, 1
	mov rdi, 1
	mov rsi, welcome_msg
	mov rdx, 21
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, usr_name
	mov rdx, r10
	syscall


	mov rax, 60
	mov rdi, 0
	syscall

