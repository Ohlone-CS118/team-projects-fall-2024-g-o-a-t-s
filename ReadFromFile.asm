.data

Viagra_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Viagra.txt"
Lipitor_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Lipitor.txt"
Ventolin_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Ventolin.txt"
Lantus_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Lantus.txt"
Prozac_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Prozac.txt"
Xanax_Path: .asciiz "team-projects-fall-2024-g-o-a-t-s/Xanax.txt"
buffer:	   .space 200
notGood:   .asciiz "that was not a digit"

.text

.globl readFile

readFile:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	move $fp, $sp
	
	li $t0, 1

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
	j ending

Lipitor:
	la $a0, Lipitor_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	j ending	
	
Ventolin:
	la $a0, Ventolin_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	j ending
	
Lantus:
	la $a0, Lantus_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	j ending

Prozac:
	la $a0, Prozac_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	j ending
	
Xanax:
	la $a0, Xanax_Path		# set the path
	la $a1, buffer			# set the buffer
	jal read			# call readFile
	j ending	

	
	
ending:
	la $a0, buffer
	jal convertToInt
	
	lw $ra, 0($fp)
	jr $ra