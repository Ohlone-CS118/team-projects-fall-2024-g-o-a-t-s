.data

	prompt: .asciiz "\nEnter 1 for Viagra\nEnter 2 for Lipitor\nEnter 3 for Ventolin\nEnter 4 for Lantus\nEnter 5 for Prozac\nEnter 6 for Xanax\nPrompt: "
	error: .asciiz "\nPlease enter a number 1 - 6"
	
.text

prompt_user:
	li $t0, 1		# min number
	li $t1, 6		# max number

	li $v0, 4		# prompt user input	
	la $a0, prompt
	syscall
	
	li $v0, 5		# read user input
	syscall

	blt $v0, $t0, error_message	# error message if input < 1
	bgt $v0, $t1, error_message	# error message if input > 6

	jr $ra
	
error_message:
	li $v0, 4		# print error message
	la $a0, error
	syscall
	
	j prompt_user		# prompt user again
