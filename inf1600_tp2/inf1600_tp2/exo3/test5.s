.data
	i:	.int 0

.global func_s

func_s:
	jmp comp
	boucle: 
		addl $1, %edi
		movl %edi, i
		
		movl e, %eax
		movl d, %ebx
		movl b, %ecx
		movl c, %edx
		movl e, %esi
		
		addl %ebx, %eax
		subl %ecx, %eax
		movl %eax, a
		
		add $50000, %ecx
		add $50000, %edx
		subl $1000, %ecx
		addl $500,  %edx
		cmpl %ecx, %edx	
		
		jna sinon
		
		mov c, %edx
		subl $500, %edx
		movl %edx, c
		
		add $50000, %ecx
		add $50000, %edx
		cmpl %ecx, %edx	
		jae comp
		
		add $50000, %ecx
		add $50000, %edx	
		mov b, %ecx
		subl $500, %ecx
		mov %ecx, b
		jmp comp
	
	sinon:
		sub %esi, %ecx
		mov %ecx, b
		add $500, %ebx
		mov %ebx, d
		jmp comp
	
	comp:
		mov i, %edi
		cmp $6, %edi
		jna boucle
		ja done
	
	done:
		ret
