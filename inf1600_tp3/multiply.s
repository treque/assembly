.globl matrix_multiply_asm

matrix_multiply_asm:
     		push %ebp      			/* Save old base pointer */
        	mov %esp, %ebp 			/* Set ebp to current esp */


        	/*Saving live registers selon gcc calling conventions*/
       		pushl %edi
		pushl %esi
		pushl %ebx
        
       		/* Making room for r and c and initialize (local vars)*/
        	subl $16, %esp
        	movl $0, -12(%ebp)			#r
        	movl $0, -16(%ebp)			#c
        	movl $0, -20(%ebp)			#i

        	jmp condr
   



/*    for(r = 0; r < matorder; ++r) { */
/*       for(c = 0; c < matorder; ++c) { */
/*          elem = 0; */
/*          for(i = 0; i < matorder; ++i) */
/*             elem += inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder]; */
/*          outmatdata[c + r * matorder] = elem; */
/*       } */
/*    } */

boucle:

		movl $0, -24(%ebp)				#elem = 0 

		/*valeur indexation dans ecx : PREMIER TERME */
		movl -12(%ebp), %ecx				# r dans ecx
		imul 16(%ebp), %ecx				# ecx * matorder
		addl -20(%ebp), %ecx				# ecx + i
		
		movl 8(%ebp), %esi
		movl (%esi, %ecx, 4),%eax			# j'ai le premier terme dans eax

		
		
		jmp incc
		
else:
		/*affection par 0*/
		movl -12(%ebp), %ecx				# r dans ecx
		imul 16(%ebp), %ecx				# ecx * matorder
		addl -16(%ebp), %ecx				# ecx + c
		
		movl 12(%ebp), %esi
		movl $0, (%esi, %ecx, 4)

incc:

		addl $1, -16(%ebp)
       
condc:

		movl -16(%ebp), %eax
		movl 16(%ebp), %edx
		cmp %eax, %edx
		ja boucle
		movl $0, -16(%ebp)
incr:

		addl $1, -12(%ebp)

condr:

		movl -12(%ebp), %eax
		movl 16(%ebp), %edx
		cmp %eax, %edx
		ja condc
        
		/* aucun retour, rien a mettre dans %eax */
		addl $16, %esp
		
		pop %esi
		pop %edi
      		leave          /* restore ebp and esp */
        	ret            /* return to the caller */
