.data
	i: .int 0
	max: .int 10
.global func_s

func_s:

	boucle:	mov i, %eax
		cmp max, %eax	#comparaison pour la continuation ou l'arret de la boucle 
		ja done
		
		mov a, %eax
		mov b, %ebx
		mov c, %ecx
		mov d, %edx

		mov d, %eax
		add e, %eax
		sub b, %eax
		mov %eax, a

		sub $1000, %ebx
		add $500, %ecx
		cmp %ebx, %ecx
		sub $1000, %ecx
		add $1000, %ebx
		ja si
		jna sinon

	si:	cmp %ebx, %ecx
		jnae sisi
		jmp inc

	sisi:	sub $500, %ebx
		jmp inc

	sinon:	sub e, %ebx
		add $500, %edx
		jmp inc
		
	inc:	mov i, %eax	#redonner a eax la valeur de i initiale
		add $1, %eax	#incrementation
		mov %eax, i	#sauvegarder la nv valeur ds i
		jmp boucle

	done:	ret

