#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int prime(int x)
{
	int i;
	if(x==0 || x==1)
		return 0;
	for(i=2;i<=x/2;i++)
		if(x%i==0)
			return 0;
	return 1;
}

int main(int argc, char* argv[])
{

	char string[50];
	strcpy(string, argv[1]);
	int aux = atoi(string);
	if(aux==0)
	{

		int nr = strlen(string);
		write(1, &nr, sizeof(int));
	}
	else
	{
		int ans = 0;
		int p = prime(aux);
		if(p==0)
			write(1, &ans, sizeof(int));
		else
		{
			ans = aux;
			write(1, &ans, sizeof(int));
		}

	}
	return 0;
}
