section .data
	;; Number of the `sys_write` system call
	SYS_WRITE equ 1
	;; Number of the `sys_exit` system call
	SYS_EXIT equ 60
	;; Number of the standard output file descriptor
	STD_OUT	equ 1
	;; Exit code from the program. The 0 status code is a success.
	EXIT_CODE equ 0
	;; ASCII code of the new line symbol ('\n')
	NEW_LINE db 0xa
	;;text to test ft_strlen
	given_text db "ciao"


section .text
	global _start



_start:
	cld
	mov rdi, given_text
	xor r10, r10
	jmp ft_strlen
	jmp exit
ft_strlen:
	cmp [rdi], byte 0
	je exit
	inc rdi
	inc r10
	jmp ft_strlen
exit:
	mov rax, SYS_EXIT
	mov rdi, EXIT_CODE
	syscall
