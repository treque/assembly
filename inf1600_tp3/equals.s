.globl matrix_equals_asm

matrix_equals_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */

		movl $0, %ebx # initialisation de r
		movl $0, %ecx #	et de c
		movl , %edi # maximum de r et de c 		
		
        /* Making room for r and c and initialize (local vars)*/
        
        subl %8, %esp
        movl $0, -4(%ebp)			#r
        movl $0, -8(%ebp)			#c
		jmp verificationR
	
		for:
			mov %ebx, %edx		#copie r dans edx
			imul %edi, %edx		#multiplication edx <- edi(matorder) * edx
			addl %ecx, %edx		 #addition edx <- ecx (c) + edx
			cmp 4(-4(%ebp),%edx,4), 4(-8(%ebp),%edx,4)	#compare data1[edx] et data2[edx] but not sure
			je incrementationC		#si egale, on skip le return
			movl $0, %eax				#mov cte se fait?? mise de valeur 0 pr return
			jmp fin						#des que return 0, on arrete la fct
        
        verificationR:
			cmpl %edi, %ebx  #r < max == r - max < 0
			jnge incrementationR	#si ca respecte, on verifie pr c
			movl $1, %eax			#si la boucleR a fini sans avoir rentrer dans le if, return est a 1
			jmp fin					#fin de la boucle si ne respecte pas comparaison
			 			
		verificationC:
			cmpl %edi, %ecx #c < max == c - max < 0
			jnge for				#si ca respecte, on rentre dans la boucle pr le if
			movl $0, %ecx	#remise a zero lorsquon recommence boucleR
			jmp verificationR	#il faut verifier si R continue ou non
			
		incrementationR:
			addl $1, %ebx
			jmp verificationC
			
		incrementationC:
			addl $1, %ebx
			jmp verificationC


		fin:
			#add $8, %ebp	 #depile les param --> ms non necessaire? (voir l. 9-10)
			mov -4(%ebp), %eax
			mov %ebp, %esp
			pop %ebp
			leave          /* Restore ebp and esp */
			ret            /* Return to the caller */
