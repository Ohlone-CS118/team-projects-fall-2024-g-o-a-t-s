.data

Viagra_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Viagra.txt"
Lipitor_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Lipitor.txt"
Ventolin_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Ventolin.txt"
Lantus_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Lantus.txt"
Prozac_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Prozac.txt"
Xanax_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Xanax.txt"
Viagra_Info_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/ViagraInfo.txt"
Lipitor_Info_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/LipitorInfo.txt"
Ventolin_Info_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/VentolinInfo.txt"
Lantus_Info_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/LantusInfo.txt"
Prozac_Info_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/ProzacInfo.txt"
Xanax_Info_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/XanaxInfo.txt"
buffer:	   .space 200
buffer2:   .space 400

.text

.globl readFile

readFile:

	addi $sp, $sp, -4		# make room for 1 word on the stack
	sw $ra, 0($sp)			# store the return address
	move $fp, $sp			# set up the frame pointer

	beq $t0, 1, Viagra		# branch to the label which corresponds with the number entered by the user
	beq $t0, 2, Lipitor
	beq $t0, 3, Ventolin
	beq $t0, 4, Lantus
	beq $t0, 5, Prozac
	beq $t0, 6, Xanax

Viagra:
	la $a0, Viagra_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Viagra_Info_Path	# set the path
	la $a1, buffer2			# set the buffer
	jal read			# call read
	j ending			# jump to ending

Lipitor:
	la $a0, Lipitor_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Lipitor_Info_Path	# set the path
	la $a1, buffer2			# set the buffer
	jal read			# call read
	j ending			# jump to ending
	
Ventolin:
	la $a0, Ventolin_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Ventolin_Info_Path	# set the path
	la $a1, buffer2			# set the buffer
	jal read			# call read
	j ending			# jump to ending
	
Lantus:
	la $a0, Lantus_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Lantus_Info_Path	# set the path
	la $a1, buffer2			# set the buffer
	jal read			# call read
	j ending			# jump to ending

Prozac:
	la $a0, Prozac_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Prozac_Info_Path	# set the path
	la $a1, buffer2			# set the buffer
	jal read			# call read
	j ending			# jump to ending
	
Xanax:
	la $a0, Xanax_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Xanax_Info_Path		# set the path
	la $a1, buffer2			# set the buffer
	jal read			# call read
	j ending			# jump to ending

	
	
ending:
	la $a0, buffer			# load the address of the buffer
	jal convertToInt		# call convertToInt
	
	li $v0, 4			# print the message in buffer2
	la $a0, buffer2
	syscall
	
	lw $ra, 0($fp)			# reset the return address
	jr $ra				# return
	
	
	
	
	
	
# preconditions:
#	$a0 = file path
#	$a1 = buffer
# postcondition:
#	The buffer address hold the file text
read:

	addi $sp, $sp, -4		# make room on the stack for 1 word
	sw $ra, 0($sp)			# store the return address

	move $s0, $a0			# stash the file path
	move $s1, $a1			# stash the buffer address
	
	li $v0, 13			# open the file
	move $a0, $s0			# set the file path
	li $a1, 0			# open for reading
	li $a2, 0			# mode is ignored
	syscall

	move $s3, $v0			# save the file handler
	
	li $v0, 14			# read the file
	move $a0, $s3			# set the file handler
	move $a1, $s1			# set the buffer
	li $a2, 399			# set the max length
	syscall
	
	move $s4, $v0			# save the number of chars read
	
	add $s5, $s4, $s1		# add the buffer and the number of characters read to get to the address of last character
	sb $zero, 0($s5)		# insert the terminating null char (\0)
	
	li $v0, 16			# close the file
	move $a0, $s3			# set the file handler
	syscall
	
	lw $ra, 0($sp)			# reset the return address
	
	jr $ra				# return
	
	
#converts a string of ascii character numbers into 
#preconditions:
#	$a0 coutains the address of the null-terminated string
convertToInt:
	addi $sp, $sp, -24		# make room for 6 words on the stack
	li $s7, 0			# incrementor starts at 0
	li $s5, 13         		# store 13 in $s5 (the ascii value for carriage return is 13)
	move $s1, $a0			# store the address of the string in $s1
	li $s3, 10			# store 10 in $s3
	li $s2, 0			# store 0 in $s2
loop:
  lbu $s4, ($s1)       # load char from string into t1
  beq $s4, $s5, oneDone   # when the character read is the newline character branch to oneDone because we have reached the end of a number
  beq $s4, $zero, FIN     # check for the terminating character
  addi $s4, $s4, -48   # convert the ascii character to its integer value
  mul $s2, $s2, $s3    # value = value * 10
  add $s2, $s2, $s4    # value = value + converted_int
  addi $s1, $s1, 1     # point to the next char in the string
  j loop      	       # loop
FIN:
	lw $t2, -24($sp)		# store the numbers in registers for graphics to use
	lw $t3, -20($sp)
	lw $t4, -16($sp)
	lw $t5, -12($sp)
	lw $t6, -8($sp)
	lw $t7, -4($sp)
	
	jr $ra				# return
oneDone:
	sw $s2, 0($sp)			# store the number on the stack
	li $s2, 0			# reset $s2
	addi $sp, $sp, 4		# move the stack pointer over by 1 word
	addi $s1, $s1, 2     		# increment array address
	j loop				# jump to loop
