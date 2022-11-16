#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#include <semaphore.h>
#include <string.h>

pthread_mutex_t mtx;
int v[11];
char list[51][51];
int n;

void citire()
{
	scanf("%d", &n);
	char aux[51];
	for(int i=0;i<n;i++)
	{
		scanf("%s", aux);
		strcpy(list[i], aux);
	}
}

void* solve(void* arg)
{
	int* ind = (int*) arg;
	for(int i=0;i<strlen(list[*ind]);i++)
		if(list[*ind][i]>='0' && list[*ind][i]<='9')
		{
			pthread_mutex_lock(&mtx);
			int pos = list[*ind][i] - 48;
			if(v[pos] == 0)
				printf("Thread %d started number %d \n", *ind, pos);
			v[pos]++;
			pthread_mutex_unlock(&mtx);
		}
		else
		{
			pthread_mutex_lock(&mtx);
			if(v[10]==0)
				printf("Thread %d started charcters \n", *ind);
			v[10]++;
			pthread_mutex_unlock(&mtx);
		}
	return NULL;
}

int main(int argc, char* argv[])
{
	pthread_t t[101];
	int i;
	citire();
	pthread_mutex_init(&mtx, NULL);
	for(i=0;i<n;i++)
	{
		int* ind = (int*)malloc(sizeof(int));
		*ind = i;
		pthread_create(&t[i], NULL, solve, ind);
	}
	for(i=0;i<n;i++)
		pthread_join(t[i], NULL);
	
	for(i=0;i<=10;i++)
	{
		printf("%d: %d \n", i, v[i]);
	}

	pthread_mutex_destroy(&mtx);
	return 0;
}

