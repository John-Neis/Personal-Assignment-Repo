#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void main(void) {
	char s1[10] = "Samuel";
	char s2[10] = "Samantha";
	
	printf("%d\n", strcmp(s2, s1));
}