.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */


        /*Saving live registers selon gcc calling conventions*/
        /* none to save, only using eax, edx and ecx */
        
        /* Making room for r and c and initialize (local vars)*/
        subl $8, %esp
        movl $0, -4(%ebp)			#r
        movl $0, -8(%ebp)			#c
        
        jmp condr
   
boucle:
		
		movl -4(%ebp), %eax
		movl -8(%ebp), %edx
		cmp %eax, %edx
		jne else
		
		/*valeur indexation dans ecx, affectation sur la diagonale */
		movl -4(%ebp), %ecx				# r dans ecx
		imul 16(%ebp), %ecx				# ecx * matorder
		addl -8(%ebp), %ecx				# ecx + c
		
		movl 8(%ebp, %ecx, 4),%eax		# 8 + ebp + ecx*4 (cote droit, inmat)	
		movl %eax, 12(%ebp, %ecx, 4)	# inmat dans 12 + ebp + ecx*4 (cote gauche, outmat)
		
		jmp incc
		
else:
		/*affection par 0*/
		movl -4(%ebp), %ecx				# r dans ecx
		imul 16(%ebp), %ecx				# ecx * matorder
		addl -8(%ebp), %ecx				# ecx + c
		
		movl $0, 12(%ebp, %ecx, 4)

incc:

		addl $1, -8(%ebp)
       
condc:

		movl -8(%ebp), %eax
		movl 16(%ebp), %edx
		cmp %eax, %edx
		ja boucle						#boucle as long as matorder is above c

incr:

		addl $1, -4(%ebp)

condr:

		movl -4(%ebp), %eax
		movl 16(%ebp), %edx
		cmp %eax, %edx
		ja condc						#2e for as long as matorder is above r
        
		/* aucun retour, rien a mettre dans %eax */
		/* desalloue r et c, comme un pop sans pop */
		addl $8, %esp

        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */

