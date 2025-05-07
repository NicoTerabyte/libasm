section .text
	global ft_strcmp

ft_strcmp:
	push rbp
	mov rbp, rsp
.checking_cycle:
	cmp rdi, rsi
	jg .set_result1
	jl .set_result2
	cmp byte [rdi], 0
	je .check_equal
	inc rsi
	inc rdi
	jmp .checking_cycle
.set_result1:
	mov rax, 1
	jmp .done
.set_result2:
	mov rax, -1
	jmp .done
.check_equal:
	cmp byte [rsi], 0
	jne .set_result2
	mov rax, 0
.done:
	pop rbp
	ret
