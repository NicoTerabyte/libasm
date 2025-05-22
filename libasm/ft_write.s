;;notes for the function:
;; remember to use the actual write of assembly that is settable
;; with the syscall calls (write is 1)


;;most of the error described in the man page are handled by the kernel

section .note.GNU-stack noexec

section .text
	global _start
	global ft_write:function

ft_write:
	push rbp
	mov rbp, rsp
	mov rax, 1
	syscall
	cmp rax, 0
	jl .error
	mov rsp, rbp
	pop rbp
	ret
ft_write.error:
	extern __errno_location
	;;we are gonna convert the rax register into a positive number
	;;with this one🗣️🔥
	;;because syscalls when it fails it gives us a negative number
	;;but the errno function returns positive ones so....
	;;wrt stands for with respect to that says the method on how the
	;;address of the function should be calculated
	;;that's why we are using plt that respects the position independent code idea
	neg rax
	mov rdi, rax
	call __errno_location wrt ..plt
	mov [rax], rdi
	mov rax, -1
	mov rsp, rbp
	pop rbp
	ret



; _start:
; 	mov rdi, 1
; 	mov rsi, strin
; 	mov rdx, TEXT_LEN
; 	call ft_write
; 	mov rax, 60
; 	mov rdi, 1
; 	syscall

;;for the future if you want you can add a checker to avoid
;; an user that puts a count that is too big. BUT for the checks i did
;; for now it seems to work properly
