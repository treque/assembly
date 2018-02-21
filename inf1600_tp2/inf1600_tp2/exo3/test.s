.data
	i: .int 0
	max: .int 10
.global func_s

func_s:
	
	boucle: 

		mov i, %eax
		mov max, %ebx
		cmp %ebx, %eax		#compare i et max (max - i)
		mov a, %eax
		ja done			#si max est depasse, on est done

		mov e, %eax			
		mov d, %edx			#edx = d
		mov b, %ebx			#ebx = b
		mov c, %ecx			#ecx = c
		add %edx, %eax			# d+e en registre
		sub %ebx, %eax			# d+e-b en registre
		mov %eax, a			#sauvegarde de a dans eax
		
		mov b, %ebx
		mov c, %ecx
		sub $1000, %ebx	
		add $500, %ecx			
		cmp %ebx, %ecx

		ja si
		jna sinon

	si:
		mov c, %ecx
		sub $500, %ecx
		mov %ecx, c

		mov b, %ebx
		cmp %ebx, %ecx		# c-b

		jnae sisi
		jmp inc
		
	sisi:
		mov b, %ebx
		sub $500, %ebx
		mov %ebx, b
		jmp inc

	sinon:
		mov e, %ecx
		mov b, %ebx
		sub %ecx, %ebx
		mov %ebx, b

		mov d, %edx
		add $500, %edx
		mov %edx, d
		jmp inc
		
	inc:
		mov i, %eax
		add $1, %eax
		mov %eax, i
		jmp boucle
		
	done:
		ret
