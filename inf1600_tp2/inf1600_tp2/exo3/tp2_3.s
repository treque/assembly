.data
	i: .int 0

.global func_s			#par respect des conventions,
				#eax et edx sont utilise pour
				#les operations, puis ecx pour
				#le compteur

func_s:

        movl    i, %ecx
        jmp     comp

boucle:

        movl    d, %edx
        movl    e, %eax
        addl    %eax, %edx

        movl    b, %eax
        subl    %eax, %edx
        movl    %edx, %eax
        movl    %eax, a		#sauvegarde de a

        movl    b, %edx
	subl	$1000, %edx

        movl    c, %eax
        addl    $500, %eax

	addl	$50000, %edx  	#car les operateurs imposés concernent des chiffres non-signés
	addl	$50000, %eax	#et que nous voulons respecter les consignes et utiliser ces opérateurs
				#tout en respectant le fait que a, b, c, d et e sont signés sur 32 bits.
				#idéalement, on aurait utilisé les opérateurs jge plutôt que jae, et par
				#extension, remplacé tout les "a" des jump par des "g", parce qu'above et
				#greater sont deux choses complètement différentes.
		
        cmpl    %eax, %edx
        jae     sinon		#saute si edx est plus grand que eax

        movl    c, %eax
        subl    $500, %eax
        movl    %eax, c

        movl    b, %edx
        movl    c, %eax
        
        addl	$50000, %edx
	addl	$50000, %eax
        
        cmpl    %eax, %edx
        jna     inc		# saute si b est plus petit que c

        movl    b, %eax
        subl    $500, %eax
        movl    %eax, b

        jmp     inc

sinon:

        movl    b, %edx
        movl    e, %eax
        subl    %eax, %edx
        movl    %edx, b

        movl    d, %eax
        addl    $500, %eax
        movl    %eax, d

inc:

        addl    $1, %ecx

comp:

        cmpl    $10, %ecx
        jna     boucle		#retourne dans la boucle si i est plus petit ou egal a 0

        ret
