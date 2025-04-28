section .data
	SYS_WRITE equ 1
	STD_OUT equ 1
	SYS_EXIT equ 60
	EXIT_CODE equ 0

	NEW_LINE db 0xa
	given_input db "hello world!"

section .bss
	reversed_str resb 12

section .text
	_start

_start:
		mov rsi, given_input
		xor rcx, rcx
		;; cld è un po' sospetta
		cld
		;;anche il calcolo con il $
		mov rdi, $ + 15
		call calculateStrLength
		xor rax, rax
		xor rdi, rdi
		jmp reverseStr
