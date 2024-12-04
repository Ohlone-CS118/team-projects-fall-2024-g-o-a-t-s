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
buffer2:   .space 200

.text

.globl readFile

readFile:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	move $fp, $sp

	beq $t0, 1, Viagra
	beq $t0, 2, Lipitor
	beq $t0, 3, Ventolin
	beq $t0, 4, Lantus
	beq $t0, 5, Prozac
	beq $t0, 6, Xanax

Viagra:
	la $a0, Viagra_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Viagra_Info_Path
	la $a1, buffer2
	jal read
	j ending

Lipitor:
	la $a0, Lipitor_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Lipitor_Info_Path
	la $a1, buffer2
	jal read
	j ending	
	
Ventolin:
	la $a0, Ventolin_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Ventolin_Info_Path
	la $a1, buffer2
	jal read
	j ending
	
Lantus:
	la $a0, Lantus_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Lantus_Info_Path
	la $a1, buffer2
	jal read
	j ending

Prozac:
	la $a0, Prozac_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Prozac_Info_Path
	la $a1, buffer2
	jal read
	j ending
	
Xanax:
	la $a0, Xanax_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	la $a0, Xanax_Info_Path
	la $a1, buffer2
	jal read
	j ending	

	
	
ending:
	la $a0, buffer
	jal convertToInt
	
	li $v0, 4
	la $a0, buffer2
	syscall
	
	lw $ra, 0($fp)
	jr $ra
	
	
	
	
	
	
# preconditions:
#	$a0 = file path
#	$a1 = buffer
# postcondition:
#	The buffer address hold the file text
read:

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	move $s0, $a0			# stash the file path
	move $s1, $a1			# stash the buffer address
	
	li $v0, 13			# open the file
	move $a0, $s0			# set the file path
	li $a1, 0
	li $a2, 0
	syscall

	move $s3, $v0			# save the file handler
	
	li $v0, 14			# read the file
	move $a0, $s3			# set the file handler
	move $a1, $s1			# set the buffer
	li $a2, 199			# set the max length
	syscall
	
	move $s4, $v0			# save the number of chars read
	
	add $s5, $s4, $s1
	sb $zero, 0($s5)		# insert the terminating null char (\0)
	
	li $v0, 16			# close the file
	move $a0, $s3			# set the file handler
	syscall
	
	lw $ra, 0($sp)
	
	jr $ra
	
	
#converts a string of ascii character numbers into 
#preconditions:
#	$a0 coutains the address of the null-terminated string
convertToInt:
	addi $sp, $sp, -24
	li $s7, 0
	li $s5, 13         
	move $s1, $a0
	li $s3, 10
	li $s2, 0
loop:
  lbu $s4, ($s1)       #load unsigned char from array into t1
  beq $s4, $s5, oneDone
  beq $s4, $zero, FIN     #NULL terminator found
  addi $s4, $s4, -48   #converts t1's ascii value to dec value
  mul $s2, $s2, $s3    #sum *= 10
  add $s2, $s2, $s4    #sum += array[s1]-'0'
  addi $s1, $s1, 1     #increment array address
  j loop       #jump to start of loop
FIN:
	lw $t2, -24($sp)
	lw $t3, -20($sp)
	lw $t4, -16($sp)
	lw $t5, -12($sp)
	lw $t6, -8($sp)
	lw $t7, -4($sp)
	jr $ra
oneDone:
  	#add $sp, $sp, $s7
	sw $s2, 0($sp)
	li $s2, 0
	#addi $s7, $s7, 4
	addi $sp, $sp, 4
	addi $s1, $s1, 2     #increment array address
	j loop
