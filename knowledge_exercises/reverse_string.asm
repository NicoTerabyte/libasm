section .data
	SYS_WRITE equ 1
	STD_OUT equ 1
	SYS_EXIT equ 60
	EXIT_CODE equ 0

	NEW_LINE db 0xa

section .bss
	reversed_str resb 12
	OUTPUT resb  1

section .text
	global _start

_start:
	pop rcx
	cmp rcx, 2
	jne 
