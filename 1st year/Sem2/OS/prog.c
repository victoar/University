#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#include <semaphore.h>

pthread_mutex_t mtx;
pthread_barrier_t barrier;
int sum = 0;

void* solve(void* arg)
{

	int* ind = (int*) arg;
	int nr1 = (rand()%(10-1+1)+1);
	pthread_mutex_lock(&mtx);
	sum = sum+nr1;
	pthread_mutex_unlock(&mtx);
	pthread_barrier_wait(&barrier);
	
	int nr2 = rand()%15 + 1;
	int sub = 0;

	pthread_mutex_lock(&mtx);
	if(nr2 < sum)
	{
		sum -= nr2;
		sub = 1;
	}
	printf("Index: %d, A: %d, B: %d", *ind, nr1, nr2);
	if(sub)
	{
		printf("Substracted: YES\n");
	}
	else
	{
		printf("Substracted: NO\n");
	}

	pthread_mutex_unlock(&mtx);
	free(arg);
	return NULL;

}

int main(int argc, char** argv)
{
	
	if(argc != 2)
	{
		perror("error\n");
		exit(1);
	}

	srand(time(NULL));
	int n = atoi(argv[1]);
	pthread_t t[n];
	int i;
	pthread_barrier_init(&barrier, NULL, n);
	pthread_mutex_init(&mtx, NULL);

	for(i=0;i<n;i++)
	{

		int* index = (int*)malloc(sizeof(int));
		*index = i;
		pthread_create(&t[i],NULL,solve,index);
	}
	for(i=0;i<n;i++)
	{
		pthread_join(t[i],NULL);
	}
	pthread_mutex_destroy(&mtx);
	return 0;

}
