.macro multiply %a
	# Функция принимает на вход два числа и умножает одно на другоею.
	mv	a0, %a
	bgez 	a0, mul_continue
	sub	a0, zero, a0
	mul_continue:
	mulhu 	t0, a0, a0
	bgtz 	t0,  mul_loop_end1
	mv 	t0, a0
	mv	a4, t0
	li 	a0, 0
	mul_loop: 
	add	a0, a0, t0
	addi	a4, a4, -1
	bgtz	a4, mul_loop
	
	b 	mul_loop_end2
	mul_loop_end1:
	mv 	%a, zero
	mul_loop_end2:
	mv	%a, a0
.end_macro