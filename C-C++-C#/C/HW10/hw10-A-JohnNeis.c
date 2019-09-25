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