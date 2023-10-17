.include "m_mult.asm"
.macro make_new_array %a %b %n
	mv 	t1, %a
	mv 	t2, %b
	mv 	a3, %n
	addi 	sp, sp, -4
	sw  	ra, (sp)
	new_loop: 
		lw	a0, (t1) 
		multiply a0
		sw	a0, (t2)
		
		addi	t1, t1, 4
		addi	t2, t2, 4
		addi	a3, a3, -1
		bgtz	a3, new_loop
.end_macro 