.macro input_array %a %n
.data 
prompt: .asciz  "Enter an array element: "
.text 
	mv 	a3, %n
	mv 	t0, %a
	input_loop:
		la 	a0, prompt
		li 	a7, 4
		ecall
		li	a7, 5
		ecall
		sw	a0, (t0)
		addi	t0, t0, 4
		addi 	a3, a3, -1
		bgtz 	a3, input_loop
.end_macro 
