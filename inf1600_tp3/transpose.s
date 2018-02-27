.globl matrix_transpose_asm

matrix_transpose_asm:

        	push %ebp      /* save old base pointer */
        	mov %esp, %ebp /* set ebp to current esp */
        
        
        	/*Saving live registers selon gcc calling conventions*/
        	pushl %edi
		pushl %esi
        
        	/* Making room for r and c and initialize (local vars)*/
        	subl $8, %esp
        	movl $0, -12(%ebp)			#r
        	movl $0, -16(%ebp)			#c
        
        	jmp condr
   
boucle:

		/* valeur indexation dans ecx */
		movl -16(%ebp), %ecx				# c dans ecx
		imul 16(%ebp), %ecx				# ecx * matorder
		addl -12(%ebp), %ecx				# ecx + r -- in
		
		movl 8(%ebp), %esi
		movl (%esi, %ecx, 4), %eax			#mettre cote gauche dans eax pour l'affectation
		
		movl -12(%ebp), %ecx				# r dans ecx
		imul 16(%ebp), %ecx				# ecx * matorder
		addl -16(%ebp), %ecx				# ecx + c -- out
		
		/* affectation */
		movl 12(%ebp), %edi
		movl %eax, (%edi, %ecx, 4)			# P O RU QOIO

incc:

		addl $1, -16(%ebp)
       
condc:

		movl -16(%ebp), %eax
		movl 16(%ebp), %edx
		cmp %eax, %edx
		ja boucle					#boucle as long as matorder is above c
		movl $0, -16(%ebp)

incr:

		addl $1, -12(%ebp)

condr:

		movl -12(%ebp), %eax
		movl 16(%ebp), %edx
		cmp %eax, %edx
		ja condc					#2e for as long as matorder is above r
        
		/* aucun retour, rien a mettre dans %eax */
		addl $8, %esp
		popl %esi
		popl %edi

       		leave          /* restore ebp and esp */
        	ret            /* return to the caller */
