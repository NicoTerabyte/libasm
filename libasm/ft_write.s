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
default rel


section .data
	SEEK_SET equ 0
	SEEK_CUR equ 1
	SEEK_END equ 2
	; strin db "ciao"
	; TEXT_LEN equ 8



section .note.GNU-stack noexec

section .text
	global _start
	global ft_write

ft_write:
	mov rax, 1
	syscall
	cmp rax, 0
	jl .error
	ret
.error:
	extern __errno_location
	neg rax
	mov rdi, rax
	call __errno_location wrt ..plt
	mov [rax], rdi
	mov rax, -1
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
