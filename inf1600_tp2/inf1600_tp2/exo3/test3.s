.data
	i:	.int 0

.global func_s

func_s:
	jmp cmp
	boucle: 
		add $1, %edi
		mov %edi, i
		
		mov e, %eax
		mov d, %ebx
		mov b, %ecx
		mov c, %edx
		mov e, %esi
		
		add %ebx, %eax
		sub %ecx, %eax
		mov %eax, a
		
		sub $1000, %ecx
		add $500,  %edx
		cmp %ecx, %edx	
		add $1000, %ecx
		sub $500, %edx
		ja si
		jna sinon
	si:
		sub $500, %edx
		mov %edx, c
		cmp %ecx, %edx	
		jnae sisi
		jmp cmp
	
	sisi:
		sub $500, %ecx
		mov %ecx, b
		jmp cmp
	
	sinon:
		sub %esi, %ecx
		mov %ecx, b
		add $500, %ebx
		mov %ebx, d
		jmp cmp
	
	cmp:
		mov i, %edi
		cmp $10, %edi
		jna boucle
		ja done
	
	done:
		ret
