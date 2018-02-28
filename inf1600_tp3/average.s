.global matrix_row_aver_asm

matrix_row_aver_asm:

        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */


        /*saving live registers/
        pushl %esi
        pushl %edi
        
       	/* Making room for r, c and elem*/
        subl $12, %esp
        movl $0, -12(%ebp)			#r
        movl $0, -16(%ebp)			#c
        
        jmp condr
        
        
        		


   for(r = 0; r < matorder; ++r) {
	  elem = 0;
      for(c = 0; c < matorder; ++c) {
         elem += inmatdata[c + r * matorder];         
      }
	  outmatdata[r] = elem/matorder;
   }
   
boucle:
		
		/*indice dans ecx*/
		movl -12(%ebp), %ecx				#r
		imull 16(%ebp), %ecx				#matorder
		addl -16(%ebp), %ecx				#c
		
		movl 8(%ebp), %esi					#inmatdata
		movl (%esi, %ecx, 4), %eax			#inmatdata[c + r * matorder] dans eax
		addl %eax, -20(%ebp)				# elem =+ eax

incc:

		addl $1, -16(%ebp)
       
condc:

		movl -16(%ebp), %eax
		movl 16(%ebp), %edx
		cmp %eax, %edx
		ja boucle
		movl $0, -16(%ebp)					#remise de c a 0
		
		movl -12(%ebp), %ecx				#r
		movl -20(%ebp), %eax				#elem
		movl 16($ebp), %edx					#matorder
		############DIVISION elem/matorder ?#################
		movl 12(%ebp), %edi					#outmatdata
		movl DIVISION!?!??, (%edi, %ecx, 4)	# outmatdata[r] = elem/matorder
		
		
incr:

		addl $1, -12(%ebp)

condr:

		movl -12(%ebp), %eax
		movl 16(%ebp), %edx
		cmp %eax, %edx				
		movl $0, -20(%ebp)					#elem = 0
		ja condc
        
		/* aucun retour, rien a mettre dans %eax */
		/* delete local vars */
		addl $12, %esp
		/* recovering registers */
		pop %edi
		pop %esi
        leave          			/* Restore ebp and esp */
        ret           			/* Return to the caller */
