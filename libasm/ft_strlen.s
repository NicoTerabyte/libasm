;;remember rax saves the return value of the assembly function
;;CODDDUE

section .text
	global ft_strlen

ft_strlen:
	push rbp
	mov rbp, rsp
	xor r10, r10
.count_size:
	cmp byte [rdi], 0
	je .done
	inc r10
	inc rdi
	jmp .count_size
.done:
	mov rax, r10
	mov rsp, rbp
	pop rbp
	ret
