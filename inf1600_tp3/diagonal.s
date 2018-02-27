.global matrix_diagonal_asm

matrix_diagonal_asm:
        	push %ebp      			/* Save old base pointer */
        	mov %esp, %ebp 			/* Set ebp to current esp */


        	/*Saving live registers selon gcc calling conventions*/
       		pushl %edi
		pushl %esi
        
       		/* Making room for r and c and initialize (local vars)*/
        	subl $8, %esp
        	movl $0, -12(%ebp)			#r
        	movl $0, -16(%ebp)			#c
        
        	jmp condr
   
boucle:
		
		movl -12(%ebp), %eax
		movl -16(%ebp), %edx
		cmp %eax, %edx
		jne else
		
		/*valeur indexation dans ecx, affectation sur la diagonale */
		movl -12(%ebp), %ecx				# r dans ecx
		imul 16(%ebp), %ecx				# ecx * matorder
		addl -16(%ebp), %ecx				# ecx + c
		
		movl 8(%ebp), %esi
		movl (%esi, %ecx, 4),%eax
		
		movl 12(%ebp), %edi
		movl %eax, (%edi, %ecx, 4)
		
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
		addl $8, %esp
		pop %esi
		pop %edi

        	leave          			/* Restore ebp and esp */
        	ret            			/* Return to the caller */

