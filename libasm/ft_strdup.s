;;char *strdup(const char *s);

section .note.GNU-stack noexec

section .data
	string db "ciaone", 0
	error db "error", 0
section .text
	global ft_strdup:function
	; global main

ft_strdup:
	push rbp
	mov rbp, rsp
	extern malloc
	push rdi
	call ft_strlen
	inc rax ;; +1 per la malloc
	mov rdi, rax
	call malloc wrt ..plt
	cmp rax, 0
	je .error
	pop rsi
	mov rdi, rax
	push rax
	jmp .cpy

.error:
	extern __errno_location
	;;we are gonna convert the rax register into a positive number
	;;with this one🗣️🔥
	;;because syscalls when it fails it gives us a negative number
	;;but the errno function returns positive ones so....
	call __errno_location wrt ..plt
	mov [rax], rdi
	mov rax, 0
	mov rsp, rbp
	pop rbp
	mov rax, 1
	mov rdi, 1
	lea rsi, [rel error]
	mov rdx, 5
	syscall
	ret

.cpy:
	mov cl, byte [rsi]
	mov byte [rdi], cl
	cmp cl, 0
	je .done
	inc rsi
	inc rdi
	jmp .cpy

.done:
	pop rdi
	mov rsp, rbp
	pop rbp
	ret

ft_strlen:
	push rbp
	mov rbp, rsp
	xor r10, r10

.count_size:
	cmp byte [rdi], 0
	je .doneStrlen
	inc r10
	inc rdi
	jmp .count_size

.doneStrlen:
	mov rax, r10
	mov rsp, rbp
	pop rbp
	ret

; main:
; 	push rbp
; 	mov rbp, rsp
; 	lea rdi, [rel string]
; 	call ft_strdup
; 	mov rsi, rax
; 	mov rax, 1
; 	mov	rdi, 1
; 	mov rdx, 6
; 	syscall
; 	mov rdi, rsi
; 	extern free
; 	call free wrt ..plt
; 	pop rbp
; 	mov rsp, rbp
; 	mov rax,  60
; 	mov rdi, 1
; 	syscall



;;da considerare:
;; 1 come sono riuscito a fare un codice funzionante con un proprio main?
;; 2 come sono stato in grado di utilizzare funzioni C in assembly e quale
;;	compilatore io abbia utilizzato
;; Spiegazione:
;; 1 a quanto pare non sei costretto a utilizzare ld per creare un eseguibile
;; puoi anche usufruire di gcc e compilare, gcc però si aspetta un main per avere
;; un programma INDIVIDUALE valido, ecco perché la sezione text oltre alla funzione
;; include main e poi lo tratti come una normalissima funzione assembly
;; sapendo che quando compila ed esegue parte da lì
;;
;; 2 Per rispondere alla domanda del compilatore, la risposta è gcc
;; per quanto riguarda l'utilizzo di funzioni esterne possiamo dire
;; che per utilizzarle bisogna prima "avvertire" che le stiamo per utilizzare
;; e poi quando le chiamiamo per utilizzarle (sempre con la stessa regola di come vengono passati gli argomenti)
;; per una questione di sicurezza e relatività (vai a vedere la spiegazione del PIE)
;; usufruiamo di queste flag wrt e ..plt per praticamente far capire come ricercare
;; queste funzioni per utilizzarle
;;
;;
;;
