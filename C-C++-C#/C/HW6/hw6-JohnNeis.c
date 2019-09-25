
/* John Neis */
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

struct words {
	char word[50];
	int occurence;
} template;

void removePunctuation(struct words *element);
void bubbleSort(struct words *list, int length);

int main(int argc, char *argv[]) {
	
	if(argc == 2) {
		
		/*************************************************************************/
		/*            Reads through the file and allocates memory                */
		/*            to store the words of the file.                            */
		/*************************************************************************/
		int wordNum = 0;
		
		FILE *stream;
		stream = fopen(argv[1], "r");
		
		if(stream == NULL) {
			printf("Invalid file. Terminating program.");
			fclose(stream);
			exit(0);
		}
		
		while(1) {
			fscanf(stream, "%s ", template.word);
			wordNum++;
			if(feof(stream)) break;
		}
		rewind(stream);
		
		struct words *list;
		list = (struct words *)calloc(wordNum, sizeof(template));
		
		int i = 0;
		while(1) {
			fscanf(stream, "%s ", list[i].word);
			removePunctuation(&list[i]);
			list[i].occurence = 0;
			i++;
			if(feof(stream)) break;
		}
		fclose(stream);
		
		/*************************************************************************/
		/*     Reads through the list of words to and adjusts the occurences     */
		/*     as required, and also nullifies any repeated word to avoid repeat */
		/*     occurences that would provide inaccurate counts.                  */
		/*************************************************************************/
		
		int j;
		for(i = 0; i < wordNum; i++) {
			for(j = 0; j < wordNum; j++) {
				if(list[i].word[0] == '\0') break;
				if(list[j].word[0] == '\0') continue;
				if(strcmp(list[i].word, list[j].word) == 0 && i == j) {
					list[i].occurence++;
				}
				else if(strcmp(list[i].word, list[j].word) == 0 && i != j) {
					list[i].occurence++;
					list[j].word[0] = '\0';
				}
			}
		}
		
		bubbleSort(list, wordNum);
		
		printf("The 10 most occurring words are:\n");
		for(i = 0; i < 10; i++) {
			if(list[i].word[0] != '\0')
				printf("%50s\tOccurs: %d\n", list[i].word, list[i].occurence);
		}
		
		free(list);
		list = NULL;
		return 0;
	}
	else {
		printf("Usage: Enter a filename to open.\n");
		return 0;
	}
}

void removePunctuation(struct words *element) {
	element->word[0] = tolower(element->word[0]);
	
	int i;
	for(i = 0; element->word[i] != '\0'; i++) {
		if(element->word[i] == ',' || element->word[i] == '.') {
			element->word[i] = '\0';
			break;
		}
	}
}

void bubbleSort(struct words *list, int length) {
	// This particular bubble sort will sort in descending order
	int i, j;
	for(i = 0; i < length - 1; i++) {
		for(j = 0; j < length - i - 1; j++) {
			if(list[j].occurence < list[j + 1].occurence) {
				struct words temp = list[j];
				list[j] = list[j + 1];
				list[j + 1] = temp;
			}
		}
	}
}
