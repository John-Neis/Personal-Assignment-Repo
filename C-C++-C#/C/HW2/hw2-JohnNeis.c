/* John Neis */

#include <stdlib.h>
#include <stdio.h>

typedef int bool;
#define true 1
#define false 0

struct information {
    char dat1[30];
    float dat2;
    int dat3;
    char dat4[20];
    bool isNUL;
};

struct information * initializeData() {

    static struct information trucks[100];
    
    int i;
    for (i = 0; i < 100; i++) {
        
        trucks[i].isNUL = true;

    }

    FILE *data;
    data = fopen("hw2.data", "r");
    i = 0;
    while(fscanf(data, "%s %f %d %s", trucks[i].dat1, &trucks[i].dat2, &trucks[i].dat3, trucks[i].dat4) != EOF) {
        trucks[i].isNUL = false;
        i++;

    }
    
    fclose(data);
    return trucks;

}

void sortFloat(struct information *trucks, int hilo) {
    
    int i;
    bool done = false;
    struct information buffer;

    //Bubble Sort
    while(!done) {

        done = true;
        for(i = 0; i < 99; i++) {
            if(!trucks[i].isNUL) {

                if(trucks[i].dat2 > trucks[i + 1].dat2) {
                    done = false;
                    buffer = trucks[i];
                    trucks[i] = trucks[i + 1];
                    trucks[i + 1] = buffer;
                }
            }   
        }
    }

    if(hilo) {
        for (i = 99; i >= 0; i--) {

            if(!trucks[i].isNUL) {
                printf("\nString 1: %s\n", trucks[i].dat1);
                printf("Float:    %.1f\n", trucks[i].dat2);
                printf("Int:      %d\n", trucks[i].dat3);
                printf("String 2: %s\n", trucks[i].dat4);
            }
        
        }
    } else {
        for (i = 0; i < 100; i++) {

             if(!trucks[i].isNUL) {
                printf("\nString 1: %s\n", trucks[i].dat1);
                printf("Float:    %.1f\n", trucks[i].dat2);
                printf("Int:      %d\n", trucks[i].dat3);
                printf("String 2: %s\n", trucks[i].dat4);
            }
        }
    }  
}

void sortInt(struct information *trucks, int hilo) {

    int i;
    bool done = false;
    struct information buffer;

    //Bubble Sort
    while(!done) {

        done = true;
        for(i = 0; i < 99; i++) {
            if(!trucks[i].isNUL) {

                if(trucks[i].dat3 > trucks[i + 1].dat3) {
                    done = false;
                    buffer = trucks[i];
                    trucks[i] = trucks[i + 1];
                    trucks[i + 1] = buffer;
                }
            }   
        }
    }

    if(hilo) {
        for (i = 99; i >= 0; i--) {

            if(!trucks[i].isNUL) {
                printf("\nString 1: %s\n", trucks[i].dat1);
                printf("Float:    %.1f\n", trucks[i].dat2);
                printf("Int:      %d\n", trucks[i].dat3);
                printf("String 2: %s\n", trucks[i].dat4);
            }
        
        }
    } else {
        for (i = 0; i < 100; i++) {

             if(!trucks[i].isNUL) {
                printf("\nString 1: %s\n", trucks[i].dat1);
                printf("Float:    %.1f\n", trucks[i].dat2);
                printf("Int:      %d\n", trucks[i].dat3);
                printf("String 2: %s\n", trucks[i].dat4);
            }
        
        }

    }

}

int main() {

    int choice = -1;
    do {
        printf("\n1. Sort data by the float value & print high to low\n");
        printf("2. Sort data by the float value & print low to high\n");
        printf("3. Sort data by the int value & print high to low\n");
        printf("4. Sort data by the int value & print low to high\n");
        printf("5. Exit\n");
        printf("Please enter your choice (1-5): ");
        scanf("%d", &choice);

        if(choice < 1 || choice > 5) {
            printf("\nYou have entered a value out of range.\n");
            continue;
        }

        switch(choice) {
            case 1:
                sortFloat(initializeData(), 1);
                break;
            case 2:
                sortFloat(initializeData(), 0);
                break;
            case 3:
                sortInt(initializeData(), 1);
                break;
            case 4:
                sortInt(initializeData(), 0);
                break;
            case 5:
                printf("\nYou've elected to exit the program. Goodbye! :)\n");
                exit(EXIT_SUCCESS);
                break;
        }
        
    } while(1);

    return 0;

}
