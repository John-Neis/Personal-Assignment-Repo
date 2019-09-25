#include <string.h>
#include <stdlib.h>

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
