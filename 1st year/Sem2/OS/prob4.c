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
	pipe(p2a);
	pipe(a2p);
	pid = fork();

	if(pid==0)
	{
		close(p2a[1]);
		close(a2p[0]);

		int k=0,n,asc[101],nr=0;
		while(1)
		{	
			read(p2a[0], &n, sizeof(int));
			if(n==0)
				break;
			if(nr==0)
			{
				asc[nr]=n;
				nr++;
			}
			else
			{
				nr++;
				k=nr-1;
				while(asc[k-1] > n && k-1>=0)
				{
					asc[k] = asc[k-1];
					k--;
				}
				asc[k]=n;
			}
		}
		write(a2p[1], &nr, sizeof(int));
		write(a2p[1], asc, nr*sizeof(int));
		exit(1);
	}

	if(pid>0)
	{
		close(p2a[0]);
		close(a2p[1]);

		int nr, v[101];
		while(1)
		{
			printf("number: ");
			scanf("%d", &nr);
			write(p2a[1], &nr, sizeof(int));
			if(nr==0)
				break;
		}
		read(a2p[0], &nr, sizeof(int));
		read(a2p[0], v, nr*sizeof(int));
		
		for(int i=0;i<nr;i++)
		{
			printf("%d ", v[i]);
		}
		printf("\n");
		close(p2a[1]);
		close(a2p[0]);
		wait(0);
	}

	return 0;
}
