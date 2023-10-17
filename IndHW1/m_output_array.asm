.macro output_array %a %n
	mv 	a3, %n
	mv	t0, %a
	output_loop:
	la	a0, next_line
	li 	a7 4
	ecall
	lw	a0, (t0)
	li	a7, 1
	ecall
	addi	t0, t0, 4
	addi 	a3, a3, -1
	bgtz	a3, output_loop
.end_macro