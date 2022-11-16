#include <stdio.h>
#include <stdlib.h>

//Read a sentence from the keyboard containing different characters (lowercase letters, big letters, numbers, special ones, etc).
//Obtain a new string with only the small case letters and another string with only the big case letters. Print both strings on the screen.

void strings(int length, char string3[], char string2[], char string1[]);
// the given string
char string1[] = "Ab, Cdka. Opasd" ;

char string2[201], string3[201];

int main()
{
    // the length of the given string
    int length = strlen(string1);
    strings(length,string3,string2,string1);
    // printing the obtained strings on the screen
    printf("The first string is: %s \n", string2);
    printf("The second string is: %s", string3);
    return 0;
}
