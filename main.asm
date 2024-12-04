.data
welcome: .asciiz "Hello! This program will show you the difference in drug prices between different countries. Please tell us which drug you would like to see compared:\n"

.text

.globl main
main:

	move $fp, $sp
	
	li $v0, 4
	la $a0, welcome
	syscall
	
	jal prompt_user
	
	move $a0, $v0
	
	li $v0, 1
	syscall
	
	#jal graphics
		
	li $v0, 10
	syscall