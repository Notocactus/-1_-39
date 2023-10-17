# Variant 39

.include "m_input_array.asm" 
.include "m_output_array.asm"
.include "m_make_new_array.asm"
.include "m_fill_array.asm"

.data

incorrect_size_info: .asciz "Incorrect size!\nMust be between 1 and 10!\n"
n_prompt: .asciz "Enter the size of the array: "
next_line: .asciz "\n"
.align 2
arr1: .space 40
.align 2
arr2: .space 40

.text
	main:
	la	a1, arr1
	la	a2, arr2
	
	li	s0, 0
	# You can fill the array with test data with this command: 
	#fill_array_5 a1 s0
	#b filled_arr
	# _______________________________________________
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
	
	input_array a1 a0
	#________________________________________________
	filled_arr:
	mv 	a0, s0
	
	make_new_array a1 a2 a0
	
	mv 	a0, s0
	
	output_array a2, a0
	
	.end_main:
	li 	a0, 0
	li 	a7, 10
	ecall



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
