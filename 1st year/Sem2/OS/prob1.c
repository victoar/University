#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char** argv) {

	int a2p[2];
	int p2a[2];
	int pid;
	int N;
	int v[101];

	pipe(a2p);
	pipe(p2a);

	pid = fork();

	if(pid==0)
	{
		int ok, i, j, n, k=0;
		close(p2a[1]); //writing p2a
		close(a2p[0]); //reading a2p

		read(p2a[0], &n, sizeof(int));

		printf("N= %d\n", n);

		for(i=2;i<n;i++)
		{
			ok = 1;
			for(j=2;j<=i/2;j++)
				if(i%j==0)
					ok = 0;
			if(ok==1)
			{
				v[k] = i;
				k++;
			}
		}
		write(a2p[1], &k, sizeof(int));
		write(a2p[1], v, k*sizeof(int));
		close(p2a[0]);
		close(a2p[1]);
		exit(0);

	}
	if(pid>0)
	{
		printf("N= \n");
		scanf("%d", &N);
		
		close(p2a[0]);
		close(a2p[1]);

		write(p2a[1], &N, sizeof(int));

		int k;
		read(a2p[0], &k, sizeof(int));
		read(a2p[0], v, k*sizeof(int));

		for(int i=0;i<k;i++)
			printf("%d ", v[i]);
		printf("\n");
		close(a2p[0]);
		close(p2a[1]);
	}
	wait(0);
	return 0;


}
