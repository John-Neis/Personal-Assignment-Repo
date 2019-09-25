/* John Neis */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char * adjustVector(char *array, int* length, char c) {
	int i;
	
	for(i = 0; i < *length; i++) {
		if(array[i] == '\n') {
			array[i] = c;
			return array;
		} else if(array[*length - 1] != '\n') {
			char *tempArray;
			i = *length;
			//printf("Before increm: %d\n", *length);
			*length += 5;
			//printf("After increm: %d\n", *length);
			
			tempArray = (char *)calloc(*length, sizeof(char));
			memcpy(tempArray, array, sizeof(char) * (*length));
			//printf("Value of array[i - 1]: %c\n", array[i - 1]);
			//printf("Value of tempArray[i - 1]: %c\n", tempArray[i - 1]);
			
			int x;
			for(x = i; x < *length; x++) {
				tempArray[x] = '\n';
			}			
			tempArray[i] = c;
			
			free(array);
			return tempArray;
		}
	}
}

int main () {
	int length = 5;
	char *charList;
	charList = (char *)calloc(length, sizeof(char));
	int i;
	for(i = 0; i < length; i++) {
		charList[i] = '\n';
	}
	
	char temp = 'a';
	printf("Enter characters: ");
	
	while(temp != '\n') {
		
		temp = getchar();
		if(temp != '\n')
			charList = adjustVector(charList, &length, temp);
		else
			charList = adjustVector(charList, &length, '\0');
		//printf("Retain value in locat: %d\n", length);
		/*for(i = 0; i < length; i++) {
			printf("%c", cList[i]);
		}*/
		
	}
	
	
	printf("Desired output: %s\n", charList);
	
	
	
	free(charList);
	return 0;
}


