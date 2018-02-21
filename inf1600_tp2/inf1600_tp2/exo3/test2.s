
.data
	i:
		.int 0
	max:
		.int 10

.global func_s

func_s:

	boucle:
        	mov i, %eax
		mov max, %ebx
		cmp %ebx, %eax   # comparaison de i et max
		ja fin           # Si i est plus grand que 10, on termine le programme
		mov d, %eax
		mov e, %ebx
		mov b, %ecx
		add %ebx, %eax   # d + e
		sub %ecx, %eax   # d + e - b
		mov %eax, a      # a = d + e - b
	
	condition:               # évaluation du premier if
		mov b, %esi
		mov c, %edi
		sub $1000, %esi  # b - 1000
		add $500, %edi   # c + 500
		
		add $10000, %esi # nous avons obtenu des erreurs de signe en testant le programme (ex. 500 n'est pas plus grand que -500)
		add $10000, %edi # ces instructions servent à conserver des nombres positifs pour les comparaisons
		
		cmp %edi, %esi   # (b - 1000) < (c + 500) ?
		jae else         # Si la condition est fausse, on saute au else
		mov c, %edx
		sub $500, %edx   # c - 500
		mov %edx, c      # c = c - 500
		mov b, %ebx      # préparation de la prochaine condition
		mov c, %ecx
		
		add $10000, %ebx # encore une fois, on élimine les possibilités d'erreurs de signe
		add $10000, %ecx # les valeurs actuelles de b et c ne sont pas modifiées
		
		cmp %ecx, %ebx   # b > c ?
		jna repeat       # Si b est plus petit ou égal à c, on termine cette itération
		mov b, %ebx
		sub $500, %ebx   # b - 500
		mov %ebx, b      # b = b - 500
		jmp repeat       # fin de l'itération
	
	else:
		mov b, %ebx
		mov e, %ecx
		sub %ecx, %ebx   # b - e
		mov %ebx, b      # b = b - e
		mov d, %edx
		add $500, %edx   # d + 500
		mov %edx, d      # d = d + 500
		jmp repeat       # fin de l'itération

	repeat:
		mov i, %eax      # à la fin de chaque itération, on passe ici
		add $1, %eax     # i + 1
		mov %eax, i      # i = i + 1
		jmp boucle       # on revient au début
		
	fin:
		ret
