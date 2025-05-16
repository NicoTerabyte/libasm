
section .note.GNU-stack noexec

section .text
global ft_read:function

ft_read:
	push rbp
	mov rbp, rsp
	mov rax, 0
	syscall
	cmp rax, 0
	jl .error
	jmp .done
	cmp rdx, 0
	je .doneZero
.error:
extern __errno_location
	;;we are gonna convert the rax register into a positive number
	;;with this one🗣️🔥
	;;because syscalls when it fails it gives us a negative number
	;;but the errno function returns positive ones so....
	neg rax
	mov rdi, rax
	call __errno_location wrt ..plt
	mov [rax], rdi
	mov rax, -1
	mov rsp, rbp
	pop rbp
	ret
.doneZero:
	mov rsp, rbp
	pop rbp
	mov rax, 0
	ret
.done:
	mov rsp, rbp
	pop rbp
	ret
