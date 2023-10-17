.macro print %a %n
.data
prompt1: .asciz "Arr A: "
space: .asciz " "
.text 
	la	a0, prompt1
	li	a7, 4
	ecall
	mv	a3, %n
	mv	t0, %a
	print_loop:
	lw	a0, (t0)
	li	a7, 1
	ecall
	la	a0, space
	li	a7, 4
	ecall
	addi 	t0, t0, 4
	addi	a3, a3, -1
	bgtz	a3, print_loop	
.end_macro

.macro fill_array_1 %a %n
	mv 	t0, %a
	sw	zero, (t0)
	addi 	t0, t0, 4
	sw	zero, (t0)
	addi 	t0, t0, 4
	sw	zero, (t0)
	li 	t0, 3
	mv	%n, t0
	print %a %n
.end_macro 

.macro fill_array_2 %a %n
	li	t1, 1
	mv 	t0, %a
	sw	t1, (t0)
	addi 	t0, t0, 4
	li	t1, -1
	sw	t1, (t0)
	addi 	t0, t0, 4
	li	t1, 1
	sw	t1, (t0)
	li 	t0, 3
	mv	%n, t0
	print %a %n
.end_macro 

.macro fill_array_3 %a %n
	li	t3, 10 
	li 	t1, 1
	mv 	t0, %a
	fill_loop:
	sw	t1, (t0)
	addi 	t0, t0, 4
	addi	t1, t1, 1
	bge	t3, t1, fill_loop
	mv	%n, t3
	print %a %n
.end_macro 


.macro fill_array_4 %a %n
	li	t1, 1
	mv 	t0, %a
	sw	t1, (t0)
	addi 	t0, t0, 4
	li	t1, 22222222
	sw	t1, (t0)
	li 	t0, 2
	mv	%n, t0
	print %a %n
.end_macro 

.macro fill_array_5 %a %n
	li	t1, -1
	mv 	t0, %a
	sw	t1, (t0)
	addi 	t0, t0, 4
	li	t1, -22222222
	sw	t1, (t0)
	li 	t0, 2
	mv	%n, t0
	print %a %n
.end_macro 