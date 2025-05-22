section .text
	global ft_strcmp:function

ft_strcmp:
	push rbp
	mov rbp, rsp
.checking_cycle:
	cmp rdi, rsi
	jg .set_result1 ;s1 bigger than s2
	jl .set_result2
	cmp byte [rdi], 0
	je .check_equal
	inc rsi
	inc rdi
	jmp .checking_cycle
.set_result1:
	sub rdi, rsi
	mov rax, rdi
	jmp .done
.set_result2:
	sub rdi, rsi
	mov rax, rdi
	jmp .done
.check_equal:
	cmp byte [rsi], 0
	jne .set_result2
	mov rax, 0
.done:
	mov rsp, rbp
	pop rbp
	ret
