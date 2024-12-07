.data

	prompt: .asciiz "\nEnter 1 for Viagra\nEnter 2 for Lipitor\nEnter 3 for Ventolin\nEnter 4 for Lantus\nEnter 5 for Prozac\nEnter 6 for Xanax\nPrompt: "
	error: .asciiz "\nPlease enter a number 1 - 6 or -1 to quit"
	
.text

.globl prompt_user

#preconditions: none
#postcondition: $v0 contains the integer read from the user
prompt_user:
	li $s0, -1		# min number
	li $s1, 6		# max number

	li $v0, 4		# prompt user input	
	la $a0, prompt
	syscall
	
	li $v0, 5		# read user input
	syscall

	blt $v0, $s0, error_message	# error message if input < 1
	beq $v0, $zero, error_message	# error message if input = 0
	bgt $v0, $s1, error_message	# error message if input > 6
	
	li $s0, 0		# reset $s0
	li $s1, 0		# reset $s1

	jr $ra			# return
	
error_message:
	li $v0, 4		# print error message
	la $a0, error
	syscall
	
	j prompt_user		# prompt user again
