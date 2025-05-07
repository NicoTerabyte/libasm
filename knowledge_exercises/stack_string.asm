section .data
	WRONG_ARGC_MSG	db "Error: expected one command-line argument", 0xa
	;; Length of the WRONG_ARGC_MSG message
	WRONG_ARGC_MSG_LEN equ 41


section .bss
	str resb 1


section .text
	global _start

_start:
	pop rsi
	cmp rsi, 2
	jne error
	pop rsi
	call take_string
error:
	;; Specify the system call number (1 is `sys_write`).
	mov rax, 1
	;; Set the first argument of `sys_write` to 1 (`stdout`).
	mov rdi, 1
	;; Set the second argument of `sys_write` to the reference of the `WRONG_ARGC_MSG` variable.
	mov rsi, WRONG_ARGC_MSG
	;; Set the third argument to the length of the `WRONG_ARGC_MSG` variable's value.
	mov rdx, WRONG_ARGC_MSG_LEN
	;; Call the `sys_write` system call.
	syscall
	;; Go to the exit of the program.
	jmp exit
take_string:
	;;procedure to do for every functions
	push rbp
	mov rsp, rbp
	cmp [rsi], byte 0


exit:
	mov rax 60
	mov rdi 0
	syscall
