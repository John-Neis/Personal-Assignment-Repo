/* John Neis */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct node {
	char *word;
	struct node *next;
} NODE;

typedef struct codex {
	char *word1;
	char *word2;
	struct codex *next;
} CODEX;

void LIST_INSERT_POEM(NODE **head, NODE *new);
void LIST_INSERT_CODEX(CODEX **chead, CODEX *cnew);
void LIST_CORRECT(NODE *head, CODEX *chead);
void LIST_DISPLAY(NODE *head);
void LIST_FREE_POEM(NODE *head);
void LIST_FREE_CODEX(CODEX *chead);

int main(void) {
	FILE *stream;
	char temp[42];
	int i;
	
	/*******THIS SECTION CREATES THE LINKED LIST FOR THE DATA FILE*******/	
	NODE *head, *new;
	head = NULL;
	stream = fopen("hw8data.txt", "r");
	
	if(stream == NULL) {
		printf("Invalid data file. Terminating program.");
		exit(0);
	}
	
	while(1) {
		fscanf(stream, "%s", temp);
		if(feof(stream)) {
			fclose(stream);
			stream = NULL;
			break;
		}
		
		// Gets the length of the string in temp
		i = 0;
		while(1) {
			if(temp[i] != '\0') i++;
			else {
				i++;
				break;
			}
		}
		
        new = (NODE *)malloc(sizeof(NODE));
		new->word = (char *)calloc(i, sizeof(char));
		new->word = strncpy(new->word, temp, sizeof(char) * i);
        
        LIST_INSERT_POEM(&head, new);

		new = NULL;

		/********************************************************/
		/* NOTE: Neither n, or n->word should be freed here.    */
		/* This is because if they're freed here, then the      */
		/* links technically point to memory that's off limits. */
		/* However, n can be NULL, to avoid aliases in memory.  */
		/********************************************************/
	}
	
	/**********************END CREATION OF DATA LIST*********************/
	

	
	/*********THIS SECTION CREATES THE LINKED LIST FOR THE CODEX*********/
	
	CODEX *chead, *cnew;
	chead = NULL;
	stream = fopen("hw8codex.txt", "r");
	
	if(stream == NULL) {
		printf("Invalid codex file. Terminating program.");
		exit(0);
	}
	
	while(1) {
		
		fscanf(stream, "%s", temp);
		if(feof(stream)) {
			fclose(stream);
			stream = NULL;
			break;
		}
		
		// Gets length of first string to be put in cnew
		i = 0;
		while(1) {
			if(temp[i] != '\0') i++;
			else {
				i++;
				break;
			}
		}
		cnew = (CODEX *)malloc(sizeof(CODEX));
		cnew->word1 = (char *)calloc(i, sizeof(char));
		cnew->word1 = strncpy(cnew->word1, temp, sizeof(char) * i);
		
		fscanf(stream, "%s", temp);
		
		// Gets length of second string to be put in cnew
		i = 0;
		while(1) {
			if(temp[i] != '\0') i++;
			else {
				i++;
				break;
			}
		}
		cnew->word2 = (char *)calloc(i, sizeof(char));
		cnew->word2 = strncpy(cnew->word2, temp, sizeof(char) * i);
		
		LIST_INSERT_CODEX(&chead, cnew);
		cnew = NULL;
	}
	
	/*********************END CREATION OF CODEX LIST*********************/
	

	
	/********This section corrects data list based on codex list*********/
	
	LIST_CORRECT(head, chead);
	
	/********************END CORRECTION OF DATA LIST*********************/
	
	
	
	/****This section displays corrected data and closes the program*****/
	
	LIST_DISPLAY(head);
	LIST_FREE_POEM(head);
	LIST_FREE_CODEX(chead);
	return 0;
	
	/*****************************END PROGRAM****************************/
}

void LIST_INSERT_POEM(NODE **head, NODE *new) {
	if(*head == NULL) {
		*head = new;
        return;
	} else {
        NODE *current;
        current = *head;
		
		// Traverses to the end of the list and then inserts
        while(current->next != NULL) {
            current = current->next;
        }
        current->next = new;
		
		// Check for punctuation in word and separate it
		current = current->next;
		int i;
		char temp;
		
		// Finds what type of punctuation and replaces it with a \0
		for(i = 0; current->word[i] != '\0'; i++) {
			if(current->word[i] == ',') {
				temp = current->word[i];
				current->word[i] = '\0';
				break;
			} else if(current->word[i] == '.') {
				temp = current->word[i];
				current->word[i] = '\0';
				break;
			}
		}
		
		// Inserts proper punction into next link in the list
		// Only if ther actually is punctuation and not random garbage
        if(temp == '.' || temp == ',') {		
            NODE *pun;
		    pun = (NODE *)malloc(sizeof(NODE));
		    pun->word = (char *)calloc(3, sizeof(char));
		    pun->word[0] = temp;
		    pun->word[1] = '\n';
		    pun->word[2] = '\0';
		    
			current->next = pun;
			current->next->next = NULL;
		    pun = NULL;
        } else // This is just for safety. Gotta keep them dangling pointers in check.
			current->next = NULL;

        return;
    }
}

void LIST_INSERT_CODEX(CODEX **chead, CODEX *cnew) {
	if(*chead == NULL) {
		*chead = cnew;
		return;
	} else {
        CODEX *current;
        current = *chead;
        while(current->next != NULL) {
            current = current->next;
        }
        current->next = cnew;
		current->next->next = NULL;
		return;
	}
}

void LIST_CORRECT(NODE *head, CODEX *chead) {
	NODE *current = head;
	
	while(current != NULL) {
		
		CODEX *check = chead;
		
		// Traverses the codex, comparing against the current data node
		while(check != NULL) {
			// If the word in the data node, and first in codex node match
			if(!strcmp(current->word, check->word1)) {
				
				// If the next word isn't null, and the next second codex word is skip,
				// just delete the next data node, since it's not needed anymore
				if(check->next != NULL && !strcmp(check->next->word2, "skip")) {
					NODE *temp = current->next;
					current->next = temp->next;
					temp->next = NULL;
					free(temp);
					temp = NULL;
				}
				
				// We don't need the incorrect word anymore, so it's ok to free it
				free(current->word);
				
				// Gets length of correct word, including space for \0
				int i = 0;
				while(1) {
					if(check->word2[i] != '\0') i++;
					else {
						i++;
						break;
					}
				}
				
				// Creating new space for the data node's word, and copying it to avoid aliases
				current->word = (char *)calloc(i, sizeof(char));
				current->word = strncpy(current->word, check->word2, sizeof(char) * i);
				break;
			}
			check = check->next;
		}
		current = current->next;
	}
	
	
}

void LIST_DISPLAY(NODE *head) {
	NODE *current;
	current = head;
	
	while(current != NULL) {
		// Checks the case the node contains just punctuation, and prints it
		if(!strcmp(current->word, ".\n") || !strcmp(current->word, ",\n")) {
			printf("%s", current->word);
			current = current->next;
			continue;
		// Checks the case that the next node contains punctuation, 
		// and prints the current word with no space after it
		} else if(!strcmp(current->next->word, ".\n") || !strcmp(current->next->word, ",\n"))
			printf("%s", current->word);
		// This is the most common case. The current word doesn't
		// have punctuation after it, so it prints with a space 
		// for the next word.
		else
			printf("%s ", current->word);
		current = current->next;
	}
}

void LIST_FREE_POEM(NODE *head) {

	NODE *current = head->next;
	while(current != NULL) {
		free(head);
		head = current;
		current = head->next;
	}
	free(head);
}

void LIST_FREE_CODEX(CODEX *chead) {
	
	CODEX *current = chead->next;
	while(current != NULL) {
		free(chead);
		chead = current;
		current = chead->next;
	}
	free(chead);
	
}