section .text
	global ft_strcpy


ft_strcpy:
	push rbp
	mov rbp, rsp

	mov rax, rdi
.copy:
	mov cl, BYTE [rsi] ;;get a character from src
	mov byte [rdi], cl ;;save the char to the destination
	test cl, cl ;;i check if we reached the end of the string
	jz .done

	inc rsi
	inc rdi
	jmp .copy

.done:
	pop rbp
	ret
