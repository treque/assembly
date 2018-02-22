.data
	i: 
		.int 0

.global func_s

func_s:
	
	
	mov i, %edi
	jmp next

	boucle:

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
		
		jmp sinon
		
		sub $500, %ecx
		mov %ecx, c

		cmp %ebx, %ecx
		jae inc

		sub $500, %ebx
		mov %ebx, b
		jmp inc

	sinon:
		mov b, %ebx
		mov e, %esi
		sub %esi, %ebx
		mov %ebx, b
		
		mov d, %edx
		add $500, %edx
		mov %edx, d

	inc:
		add $1, %edi
		
	next:
		cmp $10, %edi
		jae boucle

		mov a, %eax
		mov %eax, a

		ret

