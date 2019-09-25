/* John Neis */

#include <stdlib.h>
#include <stdio.h>

char * adjustVector(char *array, int* length, char c);

int main () {
	int length = 5;
	char *cList;
	cList = (char *)calloc(length, sizeof(char));
	int i;
	for(i = 0; i < length; i++) {
		cList[i] = '\n';
	}
	
	char temp = 'a';
	printf("Enter characters: ");
	
	while(temp != '\n') {
		
		temp = getchar();
		if(temp != '\n')
			cList = adjustVector(cList, &length, temp);
		else
			cList = adjustVector(cList, &length, '\0');
		//printf("Retain value in locat: %d\n", length);
		/*for(i = 0; i < length; i++) {
			printf("%c", cList[i]);
		}*/
		
	}
	
	
	printf("Desired output: %s\n", cList);
	
	
	
	free(cList);
	return 0;
}


