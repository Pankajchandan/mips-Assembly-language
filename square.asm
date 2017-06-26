# Pankaj Chandan Mohapatra -- 06/21/2017
# square.asm-- A program that takes 6 inputs from user
# print the squared sum
# Registers used:
# $t0 - used to hold the number input by user.
# $t1 - used to hold the square of the user input number.
# $t2 - used to hold the sum of the $t1 and $t2

main:

	li $t0, 0					#set the value of t2 to 0
	li $t1, 0					#set value of t3 to 0
	li $t2, 6					#load 0 to t3
	
	## get numbers from user and store it in register t0
	
	loop:
		beq $t1, $t2, endloop	#check condition
		addi $t1, $t1, 1		#increment value of t3
		li $v0, 5				#load syscall read_int into v0
		syscall
		move $a0, $v0			#move the number into a0
		jal square				#jump to procedure named square and save next instruction in ra
		add $t0, $t0, $v0		#add t2 and v0 and store in t2
		b loop
		
	endloop:
		move $a0, $t0			#move the content of t2 to a0
		li $v0, 1				#load syscall print_int into v0
		syscall
		li $v0, 10				#load syscall exit into v0
		syscall
		
square:

	mul $v0, $a0, $a0			#multiply t0 with t0 and store in t1
	jr $ra						#resume with executing instruction in ra
	