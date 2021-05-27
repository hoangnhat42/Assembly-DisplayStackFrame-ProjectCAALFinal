#include <stdio.h>
#include <string.h>
extern int display_memory();
void main()
{
	const	int LINESIZE=16;
	char 	str[80] = "This string is initialized in C, ABCDEFabcdef0123456789ABCDEFGHIJ";
	int 	l = strlen(str);
	display_memory(str,l);
/*	int 	row_count =  l / LINESIZE;
	int	last_count = l % LINESIZE;
	char*	p = str;
	for (int i=0; i<row_count;i++){
		mem_line(p,LINESIZE);
		p = p + LINESIZE; 
	}
	mem_line(p,last_count);	
*/
}