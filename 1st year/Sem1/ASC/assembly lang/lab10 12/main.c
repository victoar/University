#include <stdio.h>
#include <stdlib.h>

//Two strings of characters of equal length are given. 
//Calculate and display the results of the interleaving of the letters, for the two possible interlaces 
//(the letters of the first string in an even position, respectively the letters from the first string in an odd positions). 
//Where no character exist in the source string, the ‘ ’ character will replace it in the destination string.

void strings(int length, char string4[], char string3[]);
// the two given strings
char string1[] = "case" ;
char string2[] = "t8r6" ;
// the reserved space for the strings to be obtained by interlacing
char string3[201], string4[201];

// Where no character exist in the source string, the ‘ ’ character will replace it in the destination string.
int main()
{
    // the length of the given strings
    int length = strlen(string1);
    strings(length,string4,string3);
    // printing the obtained strings on the screen
    printf("The first string is: %s \n", string3);
    printf("The second string is: %s", string4);
    return 0;
}
