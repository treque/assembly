/********************************************
* Titre:	Travail pratique #5 - tp5.c
* Date:		09-04-2018
* Auteures: Huyen Trang Dinh (1846776), Helene Jiang (1854909)
**************************************************/
#include <stdio.h>
unsigned int Decryption_fct(unsigned int le)
{
	unsigned int be;
	/*
	 * Remplacez le code suivant par de l'assembleur en ligne
	 * en utilisant le moins d'instructions possible
	 
	 be = (le & 0xff000000) | (le&0xff) << 16  | (le & 0xff00) | (le & 0xff0000) >> 16;

	 */
	

	asm volatile (					//Le code aurait pu aussi ete ecrit en 5 lignes avec rot et xchg
		"movl %1, %0\n\t"			// le dans be
		"and $0xff000000,%0\n\t" 	// le & 0x0ff000000 dans be
		"movl %1, %%edx\n\t"		// le dans %edx
		"and $0xff, %%edx\n\t"		// 1e&0xff dans %edx
		"shl $16, %%edx\n\t"		// (le&0xff) << 16 dans %edx
		"or %%edx, %0\n\t"			//la premiere moitie de l'equation dans be
		"movl %1, %%edx\n\t"		//le dans %edx
		"and $0xff00, %%edx\n\t"	//(le & 0xff00) dans edx
		"or %%edx, %0\n\t"			//be = (le & 0xff000000) | (le&0xff) << 16  | (le & 0xff00) 
		"movl %1, %%edx\n\t"		// le dans %edx
		"and $0xff0000, %%edx\n\t"	// 1e&0xff0000 dans %edx
		"shr $16, %%edx\n\t"		// (le&0xff) >> 16 dans %edx
		"or %%edx, %0\n\t"			//be = (le & 0xff000000) | (le&0xff) << 16  | (le & 0xff00) | (le & 0xff0000) >> 16;
		: "=r"(be) 					//%0 output. 
		: "g"(le)					// %1 input. permet d'utiliser la memoire (avec un acces 8(%ebp)
		: "%edx"
	);

	return be;
}

int main()
{
	unsigned int data = 0xeeaabbff;

	printf("Représentation crypte en little-endian:   %08x\n"
	       "Représentation decrypte en big-endian:    %08x\n",
	       data,
	       Decryption_fct(data));

	return 0;
}
