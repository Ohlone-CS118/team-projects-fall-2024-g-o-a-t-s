.data
welcome: .asciiz "Hello! This program will show you the difference in drug prices between different countries. Please tell us which drug you would like to see compared:\n"
goodbye: .asciiz "\nThank you for using our program. Have a nice day! :)"

.text

.globl main
main:

beginning:
	move $v1, $sp			# stash the stack pointer because it gets messy in all the other files
	move $fp, $v1			# set up the frame pointer
	
	li $v0, 4			# print the welcome string
	la $a0, welcome
	syscall
	
	jal prompt_user			# call prompt_user
	
	beq $t0, -1, shutdown		# branch if the user enters -1
	
	move $t0, $v0			# stash the user input in $t0
	
	jal readFile			# call readFile
	
	jal playSound			# call playSound
	
	jal graphics			# call graphics
		
shutdown:
	li $v0, 4			# print the goodbye string
	la $a0, goodbye
	syscall
	
	li $v0, 10			# exit safely
	syscall
