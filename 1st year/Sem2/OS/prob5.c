#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

int main(int argc, char** argv)
{
	mkfifo("fifob2a", 0666);
	mkfifo("fifoa2b", 0666);
	
	int fa2b;
	int fa;

	fa = fork();

	if(fa<0)
	{
		printf("error");
		exit(0);
	}

	if(fa==0)
	{
		fa2b = open("fifoa2b", O_WRONLY);
		char c;
		printf("letter: ");
		scanf("%c", &c);
		write(fa2b, &c, sizeof(char));
		while(1)
		{
			char s[51],aux[2];
			printf("string: ");
			scanf("%s", s);
			fgets(aux,2,stdin);
			write(fa2b, &s, strlen(s)*sizeof(char));
			if(strcmp(s,"stop")==0)
				break;
		}		

		close(fa2b);
		exit(1);
	}
	else
	{
		int fb = fork();
		if(fb<0)
		{
			printf("error");
			exit(0);
		}
		if(fb==0)
		{
			fa2b = open("fifoa2b", O_RDONLY);
			char c;
			read(fa2b, &c, sizeof(char));
			while(1)
			{
				char s[51];
				read(fa2b, &s, strlen(s)*sizeof(char));
				if(strcmp(s,"stop")==0)
					break;
				int ok=0;
				for(int i=0;i<strlen(s);i++)
					if(s[i]==c)
					{
						//printf("The char is on pos %d.\n", i);
						ok=1;
					}
				if(ok==0)
					//printf("The char is not in the word.\n");
					ok = 0;
					

			}
			close(fa2b);
			exit(1);
		}


	}
	wait(0);
	wait(0);

	return 0;
}
