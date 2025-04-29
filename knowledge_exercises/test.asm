section .data
	SYS_WRITE equ 1
	STD_OUT equ 1
	SYS_EXIT equ 60
	EXIT_CODE equ 0
	ERROR_MESSAGE db "error", 0xa
	ERROR_MESSAGE_LENGHT equ 5
	NEW_LINE db 0xa

section .bss
	reversed_str resb 12
	;;my theory is proven
	;;it seems that we just need one space of memory
	;;to copy a full word in the registers
	;;maybe because we overwrite it?
	OUTPUT resb  1

section .text
	global _start


_start:
	pop rsi
	cmp rsi, 2
	jne error
	;;we are working with strings so i reset the df flag
	cld
	pop rsi
	pop rsi
	mov rdi, OUTPUT
	xor r10, r10
	call ft_strlen
ft_strlen:
	cmp [rsi], byte 0
	je print_result
	lodsb
	;;we save the letter
	mov [rdi], al
	inc rdi
	;; r10 knows how long is the string
	inc r10
	jmp ft_strlen
print_result:
	mov rax, SYS_WRITE
	mov rdi, STD_OUT
	mov rsi, OUTPUT
	mov rdx, r10	; Use r10 as the length
	syscall
	jmp exit
;;this function is just to test out a
error:
	mov rax, SYS_WRITE
	mov rdi, STD_OUT
	mov rsi, ERROR_MESSAGE
	mov rdx, ERROR_MESSAGE_LENGHT
	syscall

	mov rax, SYS_EXIT
	mov rdi, EXIT_CODE
	syscall
exit:
	mov rax, SYS_EXIT
	mov rdi, EXIT_CODE
	syscall
;;function to be able of going through the string again
resetter:
	mov rsi, r12
