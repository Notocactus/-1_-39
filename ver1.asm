# Variant 39

.data

incorrect_size_info: .asciz "Incorrect size!\nMust be between 1 and 10!\n"
prompt: .asciz  "Enter an array element: "
n_prompt: .asciz "Enter the size of the array: "
next_line: .asciz "\n"
arr1: .space 40
arr2: .space 40

.text
	# array size 
	la 	a0, n_prompt
	li	a7, 4
	ecall
	li 	a7, 5
	ecall	
	
	mv 	s0, a0  # Saving the size to s0
	# Saving the number to stack 
	addi 	sp, sp, -4
	sw  	a0, (sp)
	# Checking the limits
	jal check_limits
	addi 	sp sp 4 # Cleaning up
	li 	a1, 1
	beq 	a0, a1, .correct_main_size
	# Incorrect size branch
	la 	a0, incorrect_size_info
	li 	a7 4
	ecall
	j .end_main # Shutting down the program
	
	.correct_main_size:
	# Saving the correct size 
	mv 	a0, s0

	# Reading values from the console and saving them in arr1
	jal input_array 
	
	mv 	a0, s0

	# Reading values from arr1 and saving the squared values in arr2
	jal make_new_array
	
	mv 	a0, s0

	# Writing the values in the console
	jal output_array
	
	.end_main:
	li 	a0, 0
	li 	a7, 10
	ecall


.text
multiply:
	# The multiplication done with addition in a loop
	lw	a0, (sp)
	bgez 	a0, mul_continue
	sub	a0, zero, a0
	mul_continue:
	mulhu 	t1, a0, a0
	bgtz 	t1,  mul_loop_end1
	mv 	t2, a0
	mv	a4, t2
	li 	a0, 0
	mul_loop: 
	add	a0, a0, t2
	addi	a4, a4, -1
	bgtz	a4, mul_loop
	
	b 	mul_loop_end2
	mul_loop_end1:
	mv 	a0, zero
	mul_loop_end2:
	sw	a0, (sp)
	ret

.text 
make_new_array:
	la	a1, arr1
	la	a2, arr2
	mv 	a3, a0
	addi 	sp, sp, -4
	sw  	ra, (sp)
	new_loop: 
		lw	a0, (a1) 
		addi 	sp, sp, -4
		sw	a0, (sp)
		jal 	multiply
		lw	a0, (sp)
		addi 	sp, sp, 4
		sw	a0, (a2)
		
		addi	a1, a1, 4
		addi	a2, a2, 4
		addi	a3, a3, -1
		bgtz	a3, new_loop
	lw ra (sp)    # восстановим текущий ra
	addi 	sp, sp, 4
	ret

.text
check_limits:
	# This function checks whether the size is >0 and <11
	# If true returns 1, else 0 (a0) 
	
	# Stack
	mv a0, sp
	lw a1, (a0)  # Loading word
	li a0, 1 # bool res = true
	
	li a2, 1
	blt a1, a2, .incorrect_check_size
	
	li a2, 11
	bge a1, a2, .incorrect_check_size
	
	b end_check
	
	.incorrect_check_size:
	li a0, 0
	
	end_check:
	ret


.text
input_array:
	addi 	sp, sp, -4
	sw  	ra, (sp)
	mv 	a1, a0
	la 	t0, arr1
	input_loop:
		la 	a0, prompt
		li 	a7, 4
		ecall
		li	a7, 5
		ecall
		sw	a0, (t0)
		addi	t0, t0, 4
		addi 	a1, a1, -1
		bgtz 	a1, input_loop
	lw 	ra (sp)   # returning the ra of this program
	addi 	sp, sp, 4
	ret

.text 
output_array: 
	mv 	a3, a0
	la	a2, arr2
	output_loop:
	la	a0, next_line
	li 	a7 4
	ecall
	lw	a0, (a2)
	li	a7, 1
	ecall
	addi	a2, a2, 4
	addi 	a3, a3, -1
	bgtz	a3, output_loop
	ret
		

	
