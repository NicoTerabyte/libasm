;;notes for the function:
;; remember to use the actual write of assembly that is settable
;; with the syscall calls (write is 1)
;; you can use the getrlimit function with the syscall as well
;; to have that macro value and check if the file is valid for writing in it
;; reminder for this and the other functions: setting up the errno in case of failure
;; there's sure a way for it

;;so the kernel enforces it's own "soft limits?" in this case would be
;;remember that the rax register saves the results of the syscall

;;This defined data is to help define the
;;lseek behaviour with the defined macro you can find in it's
;;man page
section .data
	SEEK_SET equ 0
	SEEK_CUR equ 1
	SEEK_END equ 2


section .bss
	rlim_buf: resq 2 ;;this are the variable of the struct 8 byte each (there's two in it)


section .text
	global ft_write

ft_write:
	;;function prologue
	push rbp
	mov rbp, rsp
	;;we have three arguments in this function
	;;rdi first, rsi second, rdx third
	;;we use lseek to know where to write
	;;syscall 8
	;;we don't use rdi because it should have the fd in it already
	mov r10, rsi
	mov r8, rdx
	mov rax, 8
	mov rsi, 0
	mov rdx, SEEK_CUR
	syscall
	;;i save the offset
	mov r9, rax

	mov rax, 97


