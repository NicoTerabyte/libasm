.global _start
.intel_syntax noprefix


_start:
	//sys write call to print hello world
	mov rax, 1
	mov rdi, 1
	lea rsi, [hello_world]
	mov rdx, 14
	syscall

	// sys_exit call to exit the program
	mov rax, 60
	mov rdi, 69
	syscall

hello_world:
	.asciz "Hello, World!\n"
