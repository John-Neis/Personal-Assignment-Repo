/* John Neis */

#include <stdlib.h>
#include <stdio.h>

int getSize(char *fileName) {
	
	char c;
	int lineCount = 0;
	FILE *data;
	data = fopen(fileName, "r");
	if(data == NULL) {
		
		printf("File is empty. Terminating program.");
		exit(EXIT_FAILURE);
	
	}
	
	for(c = getc(data); c != EOF; c = getc(data)) {
		if(c == '\n') 
			lineCount += 1;
	}
	
	fclose(data);
	
	return lineCount;
}

void loadArray(char **array, int s1, int s2, int s3) {
	int i = 0;
	FILE *data;
	
	data = fopen("american0.txt", "r");
	while(!feof(data)) {
		fscanf(data, "%s", array[i]);
		if(i < s1) i++;
	}
	fclose(data);
	
	data = fopen("american1.txt", "r");
	while(!feof(data)) {
		fscanf(data, "%s", array[i]);
		if(i < s1 + s2) i++;
	}
	fclose(data);
	
	data = fopen("american2.txt", "r");
	while(!feof(data)) {
		fscanf(data, "%s", array[i]);
		if(i < s1 + s2 + s3 - 1) i++;
	}
	fclose(data);
}

void sortArray(char **array, int length) {
	int done = 0;
	int i;
	char *buffer;
	while(!done) {
		
		done = 1;
		for(i = 0; i < length - 1; i++) {
				
			if(array[i][0] > array[i + 1][0]) {
				done = 0;
				buffer = array[i];
				array[i] = array[i + 1];
				array[i + 1] = buffer;
			}
		}
	}
}

int main() {
	
	char **wordList;
	int list1, list2, list3;
	list1 = getSize("american0.txt");
	list2 = getSize("american1.txt");
	list3 = getSize("american2.txt");
	
	int i, x;
	x = list1 + list2 + list3;
	#define length x
	
	wordList = (char **)calloc(length, sizeof(*wordList));	
	for(i = 0; i < length; i++) {
		wordList[i] = (char *)calloc(50, sizeof(char));
	}
	
	loadArray(wordList, list1, list2, list3);
	sortArray(wordList, length);
	FILE *output;
	
	output = fopen("words.txt", "w");
	
	for(i = 0; i < length; i++) {
		fprintf(output, "%s\n", wordList[i]);	
	}
	
	fclose(output);
	
	for(i = 0; i < length; i++) {
		free(wordList[i]);
	}
	free(wordList);
	return 0;
}