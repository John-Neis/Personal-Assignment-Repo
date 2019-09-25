/* John Neis */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node {
	char name[10];
	struct node *next;
} NODE;

void listInsert(NODE **head, NODE *item);
void listDelete(NODE **head, NODE *item);
void listTraversal(NODE *head);
void freeStructs(NODE *head);

int main(void) {
	/*********************************************************/
	/*Section 1: Reads file to build linked list with opcodes*/
	/*********************************************************/
	NODE *head = NULL;
	FILE *stream = NULL;
	stream = fopen("final.data", "r");
	if(!stream) {
		printf("Invalid file. Terminating program.\n");
		exit(0);
	}
	
	int i;
	char c;
	char op_code;
    char *temp = NULL;
    size_t n = 0;

	while(1) {
		if(getline(&temp, &n, stream) == -1) { 
			fclose(stream);
			break;
		}
		
		NODE *item = malloc(sizeof(NODE));
		item->next = NULL;
        
        strncpy(item->name, strtok(temp, " "), 10);
        
		strncpy(&op_code, strtok(NULL, " "), 1);
		
		if(op_code == 'a') {
			listInsert(&head, item);
		}
		else if(op_code =='d') {
			listDelete(&head, item);
		}
        free(temp);
        temp = NULL;

	}
	/*********************************************************/
	/*                     End section 1                     */
	/*********************************************************/
	
	/*********************************************************/
	/*   Section 2: Displays completed list and frees list   */
	/*********************************************************/
	listTraversal(head);
	freeStructs(head);

	return 0;
	
	/*********************************************************/
	/*               End Section 2 / End Program             */
	/*********************************************************/
}

void listInsert(NODE **head, NODE *item) {	
	if(!(*head)) {
		*head = item;
		return;
	}
	if(strcmp(item->name, (*head)->name) < 0) {
		NODE *temp = *head;
		*head = item;
		(*head)->next = temp;
		return;
	}
	
    NODE *current;
    current = *head;
	
    while(1) {
		if(!current->next && strcmp(item->name, current->name) > 0) {
			current->next = item;
			return;
		}
		else if(current->next && strcmp(item->name, current->next->name) < 0) {
			NODE *temp = current->next;
			current->next = item;
			current->next->next = temp;
			return;
		}
		else if(current->next && strcmp(item->name, current->name) > 0) {
			current = current->next;
			continue;
		}
		else if(!strcmp(item->name, current->name)) {
			free(item);
			return;
		}
    }
    
	return;	
}

void listDelete(NODE **head, NODE *item) {
	
	if(!strcmp(item->name, (*head)->name)) {
		NODE *temp = *head;
		*head = (*head)->next;
		temp->next = NULL;
		free(temp);
		return;
	}
	
	NODE *current = *head;
	while(current) {
		if(current->next && !strcmp(item->name, current->next->name)) break;
		else current = current->next;
	}
	
	if(current) {
		NODE *temp = current->next;
		current->next = current->next->next;
		temp->next = NULL;
		free(temp);
		return;
	}
	return;
}

void listTraversal(NODE *head) {
	
	NODE *current = head;
	while(current) {
		printf("%s\n", current->name);
		current = current->next;
	}
	
}

void freeStructs(NODE *head) {
	
	NODE *temp, *current = head;
	while(current) {
		temp = current;
		current = current->next;
		free(temp);
		temp = NULL;
	}
}
