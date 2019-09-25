/* John Neis */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

char * adjustVector(char *array, int* length, char c);

int main () {
	int clength = 5;
	int dlength = 5;
	
	char *charList;
	char *digitList;
	
	charList = (char *)calloc(clength, sizeof(char));
	digitList = (char *)calloc(dlength, sizeof(char));
	
	int i;
	for(i = 0; i < clength; i++) {
		charList[i] = '\n';
		digitList[i] = '\n';
	}
	
	char temp = 'a';
	printf("Enter characters: ");
	
	while(temp != '\n') {
		temp = getchar();
		if(temp != '\n' && !isdigit(temp))
			charList = adjustVector(charList, &clength, temp);
		else if(temp != '\n' && isdigit(temp))
			digitList = adjustVector(digitList, &dlength, temp);
		else {
			charList = adjustVector(charList, &clength, '\0');	
			digitList = adjustVector(digitList, &dlength, '\0');
		}	
	}
	
	
	printf("Midterm letters: %s\nMidterm digits: %s\n", charList, digitList);
	
	
	
	free(charList);
	return 0;
}

char * adjustVector(char *array, int* length, char c) {
	int i;
	
	for(i = 0; i < *length; i++) {
		if(array[i] == '\n') {
			array[i] = c;
			return array;
		} else if(array[*length - 1] != '\n') {
			char *tempArray;
			i = *length;
			*length += 5;
			
			tempArray = (char *)calloc(*length, sizeof(char));
			memcpy(tempArray, array, sizeof(char) * (*length));
			
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
