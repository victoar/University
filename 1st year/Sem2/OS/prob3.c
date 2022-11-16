#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>


int main(int argc, char** argv)
{

	int p2a[2];
	int a2p[2];
	int pid;
	int n;
	pipe(p2a);
	pipe(a2p);
	pid = fork();

	if(pid==0)
	{
		int nr;
		close(p2a[1]);
		close(a2p[0]);
		while(1)
		{
			read(p2a[0], &nr, sizeof(int));
			if(nr<=5)
				break;	
			nr = nr/3;

			printf("Child: %d\n", nr);
			write(a2p[1], &nr, sizeof(int));	
		}
		close(p2a[0]);
		close(a2p[1]);
		exit(0);
	}
	if(pid>0)
	{
		close(p2a[0]);
		close(a2p[1]);

		printf("n= ");
		scanf("%d", &n);

		printf("Parent: %d\n", n);
		write(p2a[1], &n, sizeof(int));

		while(1)
		{
			read(a2p[0], &n, sizeof(int));
			if(n<=5)
				break;
			if((n+1)%3==0)
			{
				n=n+1;
			}
			else if((n+2)%3==0)
			{
				n=n+2;
			}
			write(p2a[1], &n, sizeof(int));
			printf("Parent: %d\n", n);
		}
		
		printf("Finished\n");
		close(p2a[1]);
		close(a2p[0]);
		wait(0);
	}

	return 0;
}

