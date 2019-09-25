#ifndef HW10B
#define HW10B

typedef struct tree {
	int data;
	struct tree *left;
	struct tree *right;
} TNODE;

void preorder(TNODE *root);
void inorder(TNODE *root);
void postorder(TNODE *root);

#endif