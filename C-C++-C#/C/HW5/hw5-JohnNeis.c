/* John Neis */

#include <stdlib.h>
#include <stdio.h>

int * push(int *array, int line) {
	int i;
	for(i = 0; i < 100; i++) {
		if(array[i] == -1) {
			array[i] = line;
			break;
		}
	}
	return array;
}

int * pop(int *array, int *ptr) {
	int i;
	for(i = 0; i < 99; i++) {
		if(array[i] == -1)
			break;
		else if(array[i + 1] == -1) {
			array[i] = -1;
			if(*ptr - 1 > -1)
				*ptr -= 1;
			break;
		}
	}
	return array;
}

int main() {
	
	int stack[100];
	int i;
	for(i = 0; i < 100; i++) {
		stack[i] = -1;
	}
	
	char file[50];
	printf("Please type the name of the file you'd like to read: ");
	scanf("%s", file);
	
	FILE *stream;
	stream = fopen(file, "r");
	
	if(stream == NULL) {
		printf("The file entered is empty. Terminating process.\n");
		exit(1);
	}
	
	char c;
	int line = 1;
	int x = 0;
	for(c = getc(stream); c != EOF; c = getc(stream)) {
		
		if(c == '\n') {
			
			for(x; x < 99; x++) {
				if(stack[x] == stack[x + 1] && stack[x] == line) {
					printf("There are too many { in line %d.\n", line);
				} else {
					break;
				}
			}
			line++;
		}
		else if(c == '{') push(stack, line);
		else if(c == '}') {
			if(stack[0] == -1) printf("There are too many } in line %d.\n", line);
			else pop(stack, &x);
		}
		
	}
	printf("End of file.\n");
	fclose(stream);
	
	return 0;
}