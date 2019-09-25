/* John Neis */

#include <stdio.h>
#include <stdlib.h>

typedef struct node {
	struct tree *payload;
	struct node *next;
} LNODE;

typedef struct tree {
	int data;
	struct tree *left;
	struct tree *right;
} TNODE;

void bubbleSort(int *arr, int n);
void buildTarray(int *arr, int start, int end, int *sorted);
void treeInsert(TNODE **tree, TNODE *item);
void listInsert(LNODE **head, LNODE *item);
void preorder(TNODE *root);
void inorder(TNODE *root);
void postorder(TNODE *root);
void listtraversal(LNODE *head);
void freeStructs(LNODE *head);

int main(void) {
	// Section 1: Opens file, creates and sorts array //

	int *rawData = NULL;
	
	FILE *f;
	f = fopen("hw9.data", "r");
	if(!f) { printf("Invalid file. Terminating program.\n"); exit(0); }
	
	int count = 0;
	int temp;
	while(1) {
		fscanf(f, "%d", &temp);
		if(feof(f)) break;
		count++;
	}
	
	rewind(f);
	
	rawData = (int *)calloc(count, sizeof(int));
	
	int i = 0;
	while(1) {
		fscanf(f, "%d", &rawData[i]);
		if(feof(f)) break;
		i++;	
	}
	fclose(f);
	
	bubbleSort(rawData, count);

	// End section 1 //
	///////////////////
	// Section 2: Rearranges numbers and builds binary tree/linked list //

	int *buildArr = (int *)calloc(count, sizeof(int));
	
	buildTarray(rawData, 0, count - 1, buildArr);
	free(rawData);
	rawData = NULL;
	
	LNODE *head = NULL;
	LNODE *Litem = NULL;
	TNODE *root = NULL;
	TNODE *Titem = NULL;
	
	for(i = 0; i < count; i++) {
		Titem = (TNODE *)malloc(sizeof(TNODE));
		Litem = (LNODE *)malloc(sizeof(LNODE));
		
		Titem->data = buildArr[i];
		Titem->left = NULL;
		Titem->right = NULL;
		
		Litem->payload = Titem;
		Litem->next = NULL;
		
		listInsert( &head, Litem );
		treeInsert( &root, Titem );
	}

	// End section 2 //
	///////////////////
	// Section 3: Pre-, in-, and post-order traversals of the tree //

	printf("Pre-order traversal: \n");
	preorder(root);
	printf("\nIn-order traversal: \n");
	inorder(root);
	printf("\nPost-order traversal: \n");
	postorder(root);
	printf("\nList traversal: \n");
	listtraversal(head);
	printf("\n");

	// End section 3 //
	///////////////////
	// Section 4: Freeing data structures //

	freeStructs(head);

	// End section 4 //

	return 0;
}

void bubbleSort(int *arr, int n) {
	int i, j;
	for(i = 0; i < n - 1; i++) {
		for(j = 0; j < n - i - 1; j++) {
			if(arr[j] > arr[j + 1]) {
				int t = arr[j];
				arr[j] = arr[j + 1];
				arr[j + 1] = t;
			}
		}
	}
}

void buildTarray(int *arr, int start, int end, int *sorted) {
	int mid;
	static int cnt = 0;
	
	if(start > end) return;
	mid = (start + end)/2;
	sorted[cnt++] = arr[mid];
	buildTarray(arr, start, mid - 1, sorted);
	buildTarray(arr, mid + 1, end, sorted);
	return;
}

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
