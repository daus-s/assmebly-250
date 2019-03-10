.text

		#prompts for integer value
		get_integer:
			li $v0, 4				#gets ready to print string

			la $a0, prompt	#loads parameter 1 with prompt
			syscall					#print

			li $v0, 5				#get ready for int input
			syscall					#wait for input
			jr $ra					#return

		#checks whether it is still OK to add n-value
		check:
			beq $t0, $t1, second
      loop

    second:
      beq $t2, $t3, escape

    escape:
			jr $ra

		#loops through and does add components and increment
		loop:
			add
      jal check

		#essentially i built system.out.print(int) but not really cuz it doesnt work
		output:
			li $v0, 4
			move $a0, $t1
			#sw $a0, 0($t1)
			syscall

			li, $v0 10			#exit
			syscall


.globl main
	main:
	 	jal get_integer	#calling the method
	 	move $s0, $v0		#moves value received to stored register
		jal check 			#contains loop
		jal output			#print (n+1)n/2 but not actually cuz the lööp


	.data

		prompt: .asciiz "Enter an int:"
