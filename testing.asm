section .dataExpl
	;i define the size in bytes of the two variables
	;the name (num1) is choosen by me but the
	;the quantity of bytes is defined by db itself(look readme)
	num1 db, 100
	num2 db, 50

section .program
	global _start

_start:
	
