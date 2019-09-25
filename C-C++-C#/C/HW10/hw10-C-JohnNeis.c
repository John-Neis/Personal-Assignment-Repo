#include <stdlib.h>
#include <stdio.h>

typedef struct tree {
	int data;
	struct tree *left;
	struct tree *right;
} TNODE;

typedef struct node {
	struct tree *payload;
	struct node *next;
} LNODE;

void listInsert(LNODE **head, LNODE *item) {
	if(!(*head)) {
		*head = item;
		return;
	}
    LNODE *current;
    current = *head;
    while(current->next != NULL) {
        current = current->next;
    }
    current->next = item;
	return;	
}

void treeInsert(TNODE **tree, TNODE *item) {
	
	if(!(*tree)) {
		*tree = item;
		return;
	}
	if(item->data < (*tree)->data)
		treeInsert( &(*tree)->left, item );
	else if(item->data > (*tree)->data)
		treeInsert( &(*tree)->right, item );
	return;
}

void listtraversal(LNODE *head) {
	
	LNODE *current = head;
	while(current) {
		printf("%d ", current->payload->data);
		current = current->next;
	}
	
}

void freeStructs(LNODE *head) {
	
	LNODE *temp, *current = head;
	while(current) {
		temp = current;
		current = current->next;
		free(temp->payload);
		temp->payload = NULL;
		free(temp);
		temp = NULL;
	}
}