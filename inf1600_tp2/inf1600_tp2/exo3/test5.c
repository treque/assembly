#include <stdio.h>
#include <stdlib.h>

/* Modifiez ces définitions à votre guise afin de tester toutes les
conditions; elles correspondent aux valeurs initiales de a, b, c, d et e : */
#define INIT_A	0
#define INIT_B	55
#define INIT_C	34
#define INIT_D	54
#define INIT_E	13

int a, b, c, d, e;

extern void func_s(void);

static void func_c(void) {
	int i;
	for (i=0; i<=6; i++){
		a = d + e - b;
		if ((b-1000) < (c+500)) {
			c = c - 500;
	}
}
}

int main(void) {
	a = INIT_A;
	b = INIT_B;
	c = INIT_C;
	d = INIT_D;
	e = INIT_E;

	printf("a = %d    b = %d    c = %d    d = %d    e = %d\n", a, b, c, d, e);
	printf("Le résultat devrait être le même les 3 fois :\n\n");
	func_c();
	printf("Version en langage C : %i %i %i %i %i \n", a, b, c, d, e);
	a = INIT_A;
	b = INIT_B;
	c = INIT_C;
	d = INIT_D;
	e = INIT_E;
	func_s();
	printf("Version en assembleur : %i %i %i %i %i\n", a, b, c, d, e);
	a = INIT_A;
	b = INIT_B;
	c = INIT_C;
	d = INIT_D;
	e = INIT_E;
	func_c();
	printf("Version en langage C : %i %i %i %i %i\n", a, b, c, d, e);

	return 0;
}