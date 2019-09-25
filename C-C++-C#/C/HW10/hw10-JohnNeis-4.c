/* John Neis */

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "hw10-A-JohnNeis.h"
#include "hw10-B-JohnNeis.h"
#include "hw10-C-JohnNeis.h"

int main(void) {
	void *handle;
	handle = dlopen("libhw10.so", RTLD_LAZY);
	if(!handle) {
		printf("%sxn", dlerror());
		exit(0);
	}
	
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
	
	// Dynamically used bubbleSort //
	void (*bSort)(int *arr, int n);
	bSort = dlsym(handle, "bubbleSort");
	
	(*bSort)(rawData, count);
	
	// End section 1 //
	///////////////////
	// Section 2: Rearranges numbers and builds binary tree/linked list //
	int *buildArr = (int *)calloc(count, sizeof(int));
	
	// Dynamically used buildTarray //
	void (*bTA)(int *arr, int start, int end, int *sorted);
	bTA = dlsym(handle, "buildTarray");
	
	(*bTA)(rawData, 0, count - 1, buildArr);
	
	free(rawData);
	rawData = NULL;
	
	LNODE *head = NULL;
	LNODE *Litem = NULL;
	TNODE *root = NULL;
	TNODE *Titem = NULL;
	
	// Dynamically used listInsert //      // Dynicamally used treeInsert //
	void (*LI)(LNODE **head, LNODE *item); void (*TI)(TNODE **tree, TNODE *item);
	LI = dlsym(handle, "listInsert");	   TI = dlsym(handle, "treeInsert");
	
	for(i = 0; i < count; i++) {
		Titem = (TNODE *)malloc(sizeof(TNODE));
		Litem = (LNODE *)malloc(sizeof(LNODE));
		
		Titem->data = buildArr[i];
		Titem->left = NULL;
		Titem->right = NULL;
		
		Litem->payload = Titem;
		Litem->next = NULL;
		
		(*LI)( &head, Litem );
		(*TI)( &root, Titem );
	}
	// End section 2 //
	///////////////////
	// Section 3: Pre-, in-, and post-order traversals of the tree //
	printf("Pre-order traversal: \n");
	
	// Dynamically used preorder //
	void (*pre)(TNODE *root);
	pre = dlsym(handle, "preorder");
	
	(*pre)(root);
	
	printf("\nIn-order traversal: \n");
	
	// Dynamically used inorder //
	void (*IN)(TNODE *root);
	IN = dlsym(handle, "inorder");
	
	(*IN)(root);
	
	printf("\nPost-order traversal: \n");
	
	// Dynamically used postorder //
	void (*post)(TNODE *root);
	post = dlsym(handle, "postorder");
	
	(*post)(root);
	
	printf("\nList traversal: \n");
	
	// Dynamically used listtraversal //
	void (*LTRAV)(LNODE *head);
	LTRAV = dlsym(handle, "listtraversal");
	
	(*LTRAV)(head);
	
	printf("\n");
	// End section 3 //
	///////////////////
	// Section 4: Freeing data structures //
	
	// Dynamically used freeStructs //
	void (*fS)(LNODE *head);
	fS = dlsym(handle, "freeStructs");
	
	(*fS)(head);
	// End section 4 //
	
	dlclose(handle);
	return 0;
}