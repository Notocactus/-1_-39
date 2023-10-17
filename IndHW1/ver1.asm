# Вариант 39

.data

incorrect_size_info: .asciz "Incorrect size!\nMust be between 1 and 10!\n"
prompt: .asciz  "Enter an array element: "
n_prompt: .asciz "Enter the size of the array: "
next_line: .asciz "\n"
arr1: .space 40
arr2: .space 40

.text
	# Сохраним s0, чтобы удовлетворять условиям 
	# ...
	# ...
	
	la 	a0, n_prompt
	li	a7, 4
	ecall
	li 	a7, 5
	ecall	# Считали инт - размер массива
	
	mv 	s0, a0  # Сохранили в "переменную" s0
	# Вызовем функцию проверки на корретность размера массива
	# Но перед этим положим переменную на стек
	addi 	sp, sp, -4
	sw  	a0, (sp)
	jal check_limits
	addi 	sp sp 4 # "Почистили" то, что положили
	# Проверим, что вернула функция
	li 	a1, 1
	beq 	a0, a1, .correct_main_size
	# Если попали сюда - значит размер не удовлетворяет нужному
	la 	a0, incorrect_size_info
	li 	a7 4
	ecall
	j .end_main # Завершаем работу программы
	
	.correct_main_size:
	# Если попали сюда - значит все четко, считывает массив
	mv 	a0, s0
	
	jal input_array
	
	mv 	a0, s0
	
	jal make_new_array
	
	mv 	a0, s0
	
	jal output_array
	
	.end_main:
	li 	a0, 0
	li 	a7, 10
	ecall


.text
multiply:
	# Функция принимает на вход два числа и умножает одно на другоею.
	# Умножение реализовано при помощи бин. сдвигов
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
		jal 	multiply
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
	# Функция проверяет, входит ли переданное число в границы от 1 до 10 включительно
	# Если удовлетворяет условию, возвращает 1(true), иначе 0(false). Значение кладется в a0
	
	# Считаем данные со стека
	mv a0, sp
	lw a1, (a0)  # Загрузили наше число
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
	lw ra (sp)    # восстановим текущий ra
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
		

	
