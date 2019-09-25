#include <stdio.h>

typedef struct tree {
	int data;
	struct tree *left;
	struct tree *right;
} TNODE;

void preorder(TNODE *root) {
	
	if(!root) return;
	printf("%d ", root->data);
	preorder(root->left);
	preorder(root->right);
	
}

void inorder(TNODE *root) {
	
	if(!root) return;
	inorder(root->left);
	printf("%d ", root->data);
	inorder(root->right);
	
}

void postorder(TNODE *root) {
	
	if(!root) return;
	postorder(root->left);
	postorder(root->right);
	printf("%d ", root->data);
	
}