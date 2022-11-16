#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>

int main(int argc, char* argv[])
{

	char string[50];
	strcpy(string, argv[1]);
	int voc=0;
	for(int i=0;i<strlen(string);i++)
	{

		if(strchr("aeiou",string[i])!=0)
			voc++;
	}	
	write(1, &voc, sizeof(int));

	return 0;
}
