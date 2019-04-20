.text


.globl main

main:
la $t0, 0(ffff0000) 	#load box address of memory mapped device
move $s0, word 		#move the message to a register from data


top:
	lb $t1, 0(ffff000c)	#get char from buffer
	addi $t2, $t2, 1	#increment buffer pointer
	beq $t1, null, done	#if char is null we are done

check_ready:
	la $t3, $t2(ffff000c)		#read from transmitter control
	lw $t0, 0($t3)			#extract ready bit
	beq 0, 0($t3), check_ready 	#if ready bit is clear read transmitter control signal
	li $v0, 11			#load print char arg to call syscall
	syscall				#send char to display
	j top				#get another char from buffer


done:
li $v0, 10 	#end program
syscall		#sad :(


.data
	word: .asciiz 'lol help'
	null: .asciiz ''