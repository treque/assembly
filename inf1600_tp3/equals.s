.globl matrix_equals_asm

matrix_equals_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */
		
		subl $4, %esp #espace pr valeur de retour
		
		pushl 8(%esp)  #empile inmatdata1 
		pushl 12(%ebp) #empile inmatdata2

		mov $0, %ebx # initialisation de r
		mov $0, %ecx #	et de c
		mov matorder, %edi # maximum de r et de c 
		
		jmp incrementationR	#pcq ++r... so r incrementer avant de rentrer dans boucle? not sure
	
		for:
			mov %ebx, %edx	#copie r dans edx
			imul %edi, %edx	#multiplication edx <- edi(matorder) * edx
			addl %ecx, %edx #addition edx <- ecx (c) + edx
			cmp 4(-4(%ebp),%edx,4), 4(-8(%ebp),%edx,4)	#compare data1[edx] et data2[edx] but not sure
			je incrementationC	#si egale, on skip le return
			mov $0, %eax			#mov cte se fait?? mise de valeur 0 pr return
			jmp fin					#des que return 0, on arrete la fct
        
        verificationR:
			cmpl %edi, %ebx  #r < max == r - max < 0
			jnge incrementationC	#si ca respecte, on verifie pr c
			mov $1, $eax			#si la boucleR a fini sans avoir rentrer dans le if, return est a 1
			jmp fin					#sinon, c la fin
			 			
		verificationC:
			cmpl %edi, %ecx #c < max == c - max < 0
			jnge for				$si ca respecte, on rentre dans la boucle pr le if
			mov $0, %ecx	#remise a zero lorsquon recommence boucleR
			jmp verificationR	#il faut verifier si R continue ou non
			
		incrementationR:
			addl $1, %ebx
			jmp verificationR
			
		incrementationC:
			addl $1, %ebx
			jmp verificationC


		fin:
			add $8, %ebp	 #depile les param
			mov -4(%ebp), %eax
			mov %ebp, %esp
			pop %ebp
			leave          /* Restore ebp and esp */
			ret            /* Return to the caller */
