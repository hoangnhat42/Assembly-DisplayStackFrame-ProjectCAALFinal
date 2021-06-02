#include <stdio.h>
#include <stdlib.h>

extern int stackwalk();

void main(int argc, char* argv[]) {

	char d = 'd';
	char c = 'c';
	char b = 'b';
	char a = 'a';

	int x = 9 ,y = 10, z = 2, t = 0;


	stackwalk();
		for(int i=0;i<argc;i++) {
	printf("%p  ",argv[i]);
	printf("%s",argv[i]);
	printf("\n");

}

}

