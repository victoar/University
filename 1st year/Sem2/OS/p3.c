#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>

int main(int argc, char* argv[])
{
	int p[20][2];
	int i;
	char string[50];
	for(i=0;i<argc-1;i++)
	{
		strcpy(string, argv[i+1]);
		pipe(p[i]);
		if(fork()==0)
		{
			close(p[i][0]);
			printf("Process %d recieved %s \n", i, string);
			dup2(p[i][1], 1);
			execlp("./vocale", "./vocale", string, NULL);
			close(p[i][1]);
			exit(1);
		}
		close(p[i][1]);
		int nr;
		read(p[i][0], &nr, sizeof(int));
		printf("%d : %d \n", i, nr);
		close(p[i][0]);
	}
	for(i=0;i<argc;i++)
		wait(0);

	return 0;
}

