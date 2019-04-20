.text

.globl main


main:
j top

top:			
					#can only accept n-1 characters
	blez 0(ffff0000), key_ready 	#check if input register is less than or equal to zero

key_ready:
	la $s0, 0(ffff0000)	#read from register control
	lw $t5, 0($s0)		#extract ready bit
	bne $0, $t5, key_ready	#read reciever control register if register is equal to 0
	lb $s1, 0(ffff000c)	#get char from keyboard
	addi $t3, $t3, 1	#increment buffered pointer
		
t_ready:
	lw $t0, $0
	lw $t1, 0(ffff0008)	#read from transmitter control register
	lw $t2, 0(ffff0000)	#extract ready bit
	beq $0, $t2, t_ready	#read transmitter control register branch if zero
	li $v0, 11
	syscall			#send char to the display
	addi $t0, $t0, 1	#increment the buffer
	beq $t4, enter, null	#if char is ENTER key we are done

null:
		#pn & null character in buffer

done:		#daus' signature
li $v0, 10 	#end program
syscall		#sad :(


.data
	word: .asciiz ''
	enter: .asciiz '\n' 