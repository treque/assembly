.globl matrix_equals_asm

matrix_equals_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */	
		
        /* Making room for r and c and initialize (local vars)*/
        
                subl $8, %esp
        movl $0, -4(%ebp)			#r
        movl $0, -8(%ebp)			#c 
        
		jmp verificationR
	
		for:
			movl -4(%ebp), %edx		#copie r dans edx
			imul 16(%ebp), %edx		#multiplication edx <- edi(matorder) * edx
			addl -8(%ebp), %edx		 #addition edx <- ecx (c) + edx
			movl 8(%ebp,%edx,4), %ecx
			movl 12(%ebp,%edx,4), %edx
			cmp %ecx, %edx
			je incrementationC		#si egale, on skip le return
			movl $0, %eax				#mov cte se fait?? mise de valeur 0 pr return
			jmp fin						#des que return 0, on arrete la fct
        
        verificationR:
			movl 16(%ebp), %eax
			movl -4(%ebp), %edx
			cmpl %eax, %edx  #r < max == r - max < 0
			jnge incrementationR	#si ca respecte, on verifie pr c
			movl $1, %eax			#si la boucleR a fini sans avoir rentrer dans le if, return est a 1
			jmp fin					#fin de la boucle si ne respecte pas comparaison
			 			
		verificationC:

			movl 16(%ebp), %eax
			movl -8(%ebp), %edx
			cmpl %eax,%edx #c < max == c - max < 0
			jnge for				#si ca respecte, on rentre dans la boucle pr le if
			movl $0, -8(%ebp)	#remise a zero lorsquon recommence boucleR
			jmp verificationR	#il faut verifier si R continue ou non
			
		incrementationR:
			addl $1, -4(%ebp)
			jmp verificationC
			
		incrementationC:
			addl $1, -8(%ebp)
			jmp verificationC


		fin:
			addl $8, %esp
			mov %eax, -4(%ebp)
			movl -4(%ebp), %eax
			
			leave          /* Restore ebp and esp */
			ret            /* Return to the caller */
