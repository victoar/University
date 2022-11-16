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
	int v[51];
	int N;

	pipe(p2a);
	pipe(a2p);
	pid = fork();

	if(pid==0)
	{
		int elem;

		close(p2a[1]);
		close(a2p[0]);

		read(p2a[0], &elem, sizeof(int));

		while(elem>0)
		{
			int k=0,i,n;
			int div[51];
			read(p2a[0], &n, sizeof(int));
			printf("child\n");
			div[k]=1;
			k++;
			for(i=2;i<=n/2;i++)
			{
				if(n%i==0)
				{
					div[k]=i;
					k++;
				}	
			}
			div[k]=n;
			k++;

			write(a2p[1], &k, sizeof(int));
			write(a2p[1], div, k*sizeof(int));
			elem--;
		}
		close(p2a[0]);
		close(a2p[1]);
		exit(0);
	}
	if(pid>0)
	{	
		int i,j,nr;
		printf("N=");
		scanf("%d", &N);
		for(i=0;i<N;i++)
		{
			scanf("%d", &nr);
			v[i] = nr;
		}
		//for(i=0;i<N;i++)
		//	printf("%d ", v[i]);
		//printf("\n");

		close(p2a[0]);
		close(a2p[1]);

		write(p2a[1], &N, sizeof(int));
		for(i=0;i<N;i++)
		{
			int rez[51];
			printf("%d ", i);
			printf("\n");
			nr = v[i];
			write(p2a[1], &nr, sizeof(int));

			read(a2p[0], &j, sizeof(int));
		       	read(a2p[0], rez, j*sizeof(int));

			printf("%d :", nr);
			for(i=0;i<j;i++)
			{
				printf("%d ", rez[i]);
			}	
			printf("\n");
		}
		close(p2a[1]);
		close(a2p[0]);
		wait(0);
		printf("Finished\n");
	}	
	return 0;

}
