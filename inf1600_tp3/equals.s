.globl matrix_equals_asm

matrix_equals_asm:

       		push %ebp      /* Save old base pointer */
        	mov %esp, %ebp /* Set ebp to current esp */


		pushl %edi
		pushl %esi

        	subl $8, %esp
        	movl $0, -12(%ebp)			#r
        	movl $0, -16(%ebp)			#c
        
        	jmp condr
   
boucle:

		/* valeur indexation dans ecx */	
		movl -12(%ebp), %ecx				# r dans ecx
		imul 16(%ebp), %ecx				# ecx * matorder
		addl -16(%ebp), %ecx				# ecx + c
		
		/* comparaison if */
		movl 8(%ebp), %esi
		movl 12(%ebp), %edi

		movl (%esi, %ecx, 4), %eax			
		movl (%edi, %ecx, 4), %edx
		cmp %eax, %edx

		je incc

		addl $8, %esp
		movl $0, %eax
		leave
		ret

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

		movl -12(%ebp), %eax		#r
		movl 16(%ebp), %edx		#matorder 
		cmp %eax, %edx
		ja condc			#2e for as long as matorder is above r
        
		addl $8, %esp
		pop %esi
		pop %edi
		
		movl $1, %eax
			
		leave          /* Restore ebp and esp */
		ret            /* Return to the caller */
