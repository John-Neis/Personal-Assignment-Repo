#include <stdio.h>
#include <stdlib.h>

void function(void) {
    
    char string1[5], string2[17];
    printf("Enter text for string 1: ");
    scanf("%s", string1);
    printf("Enter text for string 2: ");
    scanf("%s", string2);
    printf("%s\n", string1);
    printf("%s\n", string2);

}

void main(void) {
    function();
    return;
}
