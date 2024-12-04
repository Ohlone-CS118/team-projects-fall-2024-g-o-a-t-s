.data

	prompt2: .asciiz "\nEnter 1 for Viagra\nEnter 2 for Lipitor\nEnter 3 for Ventolin\nEnter 4 for Lantus\nEnter 5 for Prozac\nEnter 6 for Xanax\nPrompt: "
	error2: .asciiz "\nThat was not a valid input"
	promptInfo: .asciiz "\nDo you want to see another drug price comparison? Press 1 to run the program again or press 2 to quit"
	
.text

.globl prompt_user_loop

#preconditions: none
#postcondition: $v0 contains the integer read from the user
prompt_user_loop:

	li $v0, 4		# print the promptInfo string
	la $a0, promptInfo
	syscall
	
	li $v0, 5		# get an integer from the user
	syscall
	
	beq $v0, 2, return		# branch to the return statement if the user enters 2
	bne $v0, 1, error_message2	# branch to the error message if the user enters anything other than 1 (or 2 thanks to the previous line)

	li $s0, 1		# min number
	li $s1, 6		# max number

	li $v0, 4		# prompt user input	
	la $a0, prompt2
	syscall
	
	li $v0, 5		# read user input
	syscall

	blt $v0, $s0, error_message2	# error message if input < 1
	bgt $v0, $s1, error_message2	# error message if input > 6
	
	li $s0, 0		# reset $s0
	li $s1, 0		# reset $s1

return:
	jr $ra			# return

error_message2:
	li $v0, 4		# print error message
	la $a0, error2
	syscall
	
	j prompt_user_loop	# prompt user again

