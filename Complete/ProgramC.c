#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int stackwalk();

void test( int a, int b) {
	int x =9 ,y=10,m=2,u=0,z=8;
	stackwalk();
}

void main(int argc, char* argv[]) {
int end_arg2 = 0x9;
char w = 'd';
char l = 'c';
char q = 'b';
char r = 'a';
	int x =9 ,y=10,m=2,u=0,z=8;

for(int i=0;i<argc;i++) {
	printf("%p  ",argv[i]);
	printf("%s",argv[i]);
	printf("\n");

}	

	
	stackwalk();
	//test(3,3,1000000,1);

}

