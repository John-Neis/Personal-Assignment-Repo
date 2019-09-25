/* John Neis */

#include <stdio.h>
#include <stdlib.h>
#include "hw10-A-JohnNeis.h"
#include "hw10-B-JohnNeis.h"
#include "hw10-C-JohnNeis.h"

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