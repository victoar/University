#include <stdio.h>
#include <stdlib.h>

//Read from file numbers.txt a string of numbers (odd and even). Build two strings using readen numbers:
//P – only with even numbers
//N – only with odd numbers
//Display the strings on the screen.

void strings(int length, char string3[], char string2[], char string1[]);

// the given string
char string1[201];

char string2[201], string3[201];

int main()
{
    // the length of the given string
    FILE *fp;
    fp = fopen("numbers.txt", "r");
    fgets(string1, 201, fp);
    fclose(fp);
    
    printf("The first string is: %s \n", string1);
    int length = strlen(string1);
    
    strings(length,string3,string2,string1);
    // printing the obtained strings on the screen
    printf("The first string is: %s \n", string2);
    printf("The second string is: %s", string3);
    return 0;
}
