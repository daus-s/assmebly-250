.text

		#prompts for integer value
		get_integer:
			li $v0, 4				#gets ready to print string

			la $a0, prompt	#loads parameter 1 with prompt
			syscall					#print

			li $v0, 5				#get ready for int input
			syscall					#wait for input
			jr $ra					#return

		check:
			blez $s0, loop
			jr $ra

		loop:
			add $t1, $t1, $s0  #sum+=index
			sub $s0, $s0, 1 #index--
			jal check

		output:
			move $v0, $t1
			li $v0, 4

.globl main
	main:
	 	jal get_integer	#calling the method
		move $s0, $v0		#moves value received to stored register
		jal check 			#contains loop
		jal output			#print (n+1)n/2 but not actually cuz the lööp
		li $v0, 10			#exit


	.data

		prompt: .asciiz "Enter an int:"
