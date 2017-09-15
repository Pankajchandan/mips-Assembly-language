#######################################################################################
# Pankaj Chandan Mohapatra
# CMPE200
# HW 1: Design a linked list append function 
# this program initializes two nodes and an empty list and appends those nodes into 
# the empty list, append can be from head side or tail side
#######################################################################################
	
	.data
	
msg0:	.asciiz "initialized empty linked list... \n"
msg1:	.asciiz	"initialized and appended node 1... \n"
msg2:	.asciiz	"initialized and appended node 2... \n"
print:	.asciiz	"\nprinting done... \n"
link:	.asciiz "-->"
linkend:.asciiz "null"
dbg:	.asciiz "inside emptylist function... \n"
dbg1:	.asciiz "not inside emptylist function... \n"

	.text
	
##main function:	
main:
	##initialize an empty list
	##call function node to create the head node
	##move contents of v0 to s1, now s1 is the head node
	##call function to create tail node
	##move contents of v0 to s1, now s1 is the head node
	jal	node 		
	move	$s0,$v0 	
	jal	node 		
	move	$s1,$v0 	
	
	##print msg0
	la	$a0, msg0
	li	$v0, 4
	syscall
	
	##initializing node1
	jal 	node
	
	##move a non-zero value into node1
	li	$t0, 10
	sw	$t0, 0($v0)
	
	##append node1 to list
	move	$a0, $v0
	jal	append_tail
	
	##print msg1
	la	$a0, msg1
	li	$v0, 4
	syscall
	
	##initializing node2
	jal 	node
	
	##move a non-zero value into node2
	li	$t0, 20
	sw	$t0, 0($v0)
	
	##append node2 to list
	move	$a0, $v0
	jal	append_tail
	
	##print msg2
	la	$a0, msg2
	li	$v0, 4
	syscall
	
	##print list
	jal	print_list
	
	##print msg print
	la	$a0, print
	li	$v0, 4
	syscall
	
	##exit program
	li $v0, 10 
	syscall

#allocate node space in the heap
node:
	li	$v0, 9
	li	$a0, 8 				# allocates 8 bytes, 4 for data and 4 for next
	syscall
	sw	$0, 0($v0) 			#load value zero to the int place
	sw	$0, 4($v0) 			#load value zero to the address place
	jr	$ra
	
##print list
print_list:
	move	$t0, $s0 			#copy head address to temp reg 0
	loop: 
		beq	$t0, $0, done
		lw	$a0, 0($t0)
		li	$v0, 1
		syscall
		la	$a0, link
		li	$v0, 4
		syscall
		lw	$t0, 4($t0)
		j	loop
	done:
		la	$a0, linkend
		li	$v0, 4
		syscall
		jr	$ra

##append from head:
append_head:
	lw	$t0, 0($s0)
	beq	$t0, $0, emptylist 		#branch if list is empty
	sw	$s0, 4($a0) 			#new node->next=head
	move	$s0, $a0 			#head =new node
	jr	$ra


##append from tail:
append_tail:
	lw	$t0, 0($s1)
	beq	$t0, $0, emptylist 		#branch if list is empty
	sw	$a0, 4($s1) 			#tail->next=new node
	move	$s1, $a0 			#tail=new node
	jr	$ra

##if list is empty	
emptylist:
	lw	$t1, 0($a0) 			#load data value of new node
	sw	$t1, 0($s0) 			#save new node data value into head node data field
	move	$s1, $s0 			#head=tail
	jr	$ra		
