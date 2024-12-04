.text


playSound:

li $a2, 33	# load an instrument
li $a3, 100	# set the volume


li $a0, 64	# play E   1)
li $a1 400 	# play for 400 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 200	# for 200 miliseconds
syscall



li $a0, 62	# play D    2)
li $a1 400 	# play for 300 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 200	# for 200 miliseconds
syscall



li $a0, 66	# play F#    3)
li $a1 500 	# play for 400 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 400	# for 400 miliseconds
syscall



li $a0, 68	# play G#     4)
li $a1 500 	# play for 500 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 400	# for 400 miliseconds
syscall



li $a0, 61	# play C#    5)
li $a1 400 	# play for 500 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 400	# for 200 miliseconds
syscall



li $a0, 71	# play B   6)
li $a1 400 	# play for 400 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 300	# for 200 miliseconds
syscall



li $a0, 62	# play D    7)
li $a1 400 	# play for 500 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 400	# for 300 miliseconds
syscall



li $a0, 64	# play E    8)
li $a1 500 	# play for 500 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 400	# for 300 miliseconds
syscall



li $a0, 71	# play B     9)
li $a1 400 	# play for 400 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 200	# for 200 miliseconds
syscall



li $a0, 69	# play A      10)
li $a1 400 	# play for 400 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 200	# for 200 miliseconds
syscall



li $a0, 61	# play C#    11)
li $a1 400 	# play for 400 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 200	# for 200 miliseconds
syscall



li $a0, 64	# play E    12)
li $a1 300 	# play for 400 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it

li $v0, 32	# sleep
li $a0, 200	# for 200 miliseconds
syscall



li $a0, 69	# play A   13)
li $a1 400 	# play for 400 miliseconds

li $v0 31 	# play midi sound
syscall 	# do it




li $v0, 31
syscall

jr $ra

