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
        	movl $0, -16(%ebp)			#r
        	movl $0, -20(%ebp)			#c
        	movl $0, -24(%ebp)			#i

        	jmp condr
        	
bouclec:
	
			movl $0, -28(%ebp)			#elem = 0
			jmp condi
			
bouclei:

			/*valeur indexation dans ecx : PREMIER TERME */
			movl -16(%ebp), %ecx				# r dans ecx
			imull 20(%ebp), %ecx				# ecx * matorder
			addl -24(%ebp), %ecx				# ecx + i
		
			movl 8(%ebp), %esi					# in1 dans esi
			movl (%esi, %ecx, 4),%eax			# j'ai le premier terme dans eax
		
			/* DEUXIEME TERME */
			movl -24(%ebp), %ecx				# i dans ecx
			imull 20(%ebp), %ecx				# ecx * matorder
			addl -20(%ebp), %ecx				# ecx + c
			movl 12(%ebp), %edi					# in2 dans edi
			imull (%edi, %ecx, 4), %eax			# multiplication des deux termes et stores dans %eax
			
			addl %eax ,-28(%ebp)				# additionne eax et elem et met le res dans elem (elem += eax)

inci:

			addl $1, -24(%ebp)
			
condi:

			movl -24(%ebp), %eax
			movl 20(%ebp), %edx
			cmp %eax, %edx
			ja bouclei							# revient a la boucle de i
			movl $0, -24(%ebp)					# remise de i a 0
			
			movl -16(%ebp), %ecx				
			imul 20(%ebp), %ecx
			addl -20(%ebp), %ecx				# c + r*matorder dans %ecx
			
			movl 16(%ebp), %esi					# outmatdata dans esi
			movl -28(%ebp), %eax
			movl %eax, (%esi, %ecx, 4)			# outmatdata[c + r * matorder] = elem
			
			
incc:
			addl $1, -20(%ebp)
condc:

			movl -20(%ebp), %eax
			movl 20(%ebp), %edx
			cmp %eax, %edx
			movl $0, -24(%ebp)					#elem = 0 
			ja bouclec
			movl $0, -20(%ebp)					#remise de c 0
			
incr:

			addl $1, -16(%ebp)

condr:

			movl -16(%ebp), %eax
			movl 20(%ebp), %edx
			cmp %eax, %edx
			ja condc


			/* aucun retour, rien a mettre dans %eax */
			
			addl $16, %esp
			pop %ebx							#on ne s'est pas servies de ebx, mais on aura au moin
			pop %esi							#suivi les calling conventions de gcc
			pop %edi
			
      		leave          /* restore ebp and esp */
        	ret            /* return to the caller */
