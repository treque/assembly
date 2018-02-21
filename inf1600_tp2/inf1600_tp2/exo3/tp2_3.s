.data
	i: 
		.int 0

.global func_s

func_s:
	
	jmp next

	boucle:
		
		add $1, %edi
		mov %edi, i

		mov b, %ebx
		mov d, %edx
		mov e, %eax
		add %edx, %eax
		sub %ebx, %eax
		mov %eax, a
		mov e, %eax
		
		sub $1000, %ebx
		add $500, %ecx
		cmp %ebx, %ecx
		
		mov b, %ebx
		mov c, %ecx
		
		ja si
		jmp sinon
		jmp next

	si:
		
		sub $500, %ecx
		mov %ecx, c

		cmp %ebx, %ecx
		jnae sisi
		jmp next
	
	sisi:

		sub $500, %ebx
		mov %ebx, b
		jmp next

	sinon:

		mov e, %esi
		sub %esi, %ebx
		mov %ebx, b
		
		add $500, %edx
		mov %edx, d

		jmp next		
		
	next:
		mov i, %edi
		cmp $9, %edi
		ja done
		jmp boucle

	done:	
		mov a, %eax
		mov %eax, a
		ret

