#ifndef HW10C
#define HW10C

typedef struct node {
	struct tree *payload;
	struct node *next;
} LNODE;

void treeInsert(TNODE **tree, TNODE *item);
void listInsert(LNODE **head, LNODE *item);
void listtraversal(LNODE *head);
void freeStructs(LNODE *head);

#endif