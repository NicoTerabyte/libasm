//we have declared the data section
//what i can understand is that a data section's logevitiy is the same
//as the program longevity
section .data

//the text section contains instructions for the program
//every program is a set of instructions that are told to
//the computer to perform specific tasks
section .text

//here we define the _start which is actually
//from where the code is gonna be read.
//AND only with the global suffix we are making
//it visible to the linker
	global _start
