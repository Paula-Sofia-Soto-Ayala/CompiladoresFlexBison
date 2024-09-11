%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h> 
#include <time.h>

void yyerror(const char *s);
int yylex(void);

extern int yylineno;

typedef struct {
    char *name;
    int quantity;
    char *description;
    char *category;  
} Item;

typedef struct {
    char *action;
    char *name;
    int quantity;
    char *description;
    char *category;
    char *timestamp;
} Change;

Item inventory[100];
int itemCount = 0;

Change history[100];
int changeCount = 0;

void addItem(char *name, int quantity, char *description, char *category);
void removeItem(char *name);
void updateItem(char *name, int quantity);
void showInventory(void);
void saveInventory(char *filename);
void loadInventory(char *filename);
void searchByCategory(char *category);
void showHistory(void);
char* getCurrentTime(void);
void clearInventory(void);
void searchByDescription(char *description);

%}

%union {
    int num;
    char *str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token ASSIGN SEMICOLON ADD REMOVE UPDATE SHOW HISTORY DESCRIPTION SAVE LOAD CATEGORY SEARCH

%%
program:
    program statement
    | statement
    ;

statement:
    ADD IDENTIFIER ASSIGN NUMBER DESCRIPTION IDENTIFIER CATEGORY IDENTIFIER SEMICOLON { 
        printf("Ejecutando addItem\n");
        addItem($2, $4, $6, $8);
    }
    | REMOVE IDENTIFIER SEMICOLON { 
        printf("Executing removeItem\n");
        removeItem($2); 
    }
    | UPDATE IDENTIFIER ASSIGN NUMBER SEMICOLON { 
        printf("Executing updateItem\n");
        updateItem($2, $4); 
    }
    | SHOW SEMICOLON { 
        printf("Executing showInventory\n");
        showInventory(); 
    }
    | SAVE IDENTIFIER SEMICOLON { 
        printf("Executing saveInventory\n");
        saveInventory($2); 
    }
    | LOAD IDENTIFIER SEMICOLON { 
        printf("Executing loadInventory\n");
        loadInventory($2); 
    }
    | SEARCH CATEGORY IDENTIFIER SEMICOLON { 
        printf("Executing searchByCategory\n");
        searchByCategory($3); 
    }
    | SEARCH DESCRIPTION IDENTIFIER SEMICOLON { 
        printf("Executing searchByDescription\n");
        searchByDescription($3); 
    }
    | SHOW HISTORY SEMICOLON { 
        printf("Executing showHistory\n");
        showHistory(); 
    }

    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s on line %d\n", s, yylineno);
}

char* getCurrentTime() {
    time_t now = time(NULL);
    struct tm *t = localtime(&now);
    char *timeStr = malloc(20);
    strftime(timeStr, 20, "%Y-%m-%d %H:%M:%S", t);
    return timeStr;
}

void addItem(char *name, int quantity, char *description, char *category) {
    inventory[itemCount].name = strdup(name);
    inventory[itemCount].quantity = quantity;
    inventory[itemCount].description = strdup(description);
    inventory[itemCount].category = strdup(category);  
    itemCount++;

    // Registrar el cambio
    history[changeCount].action = strdup("ADD");
    history[changeCount].name = strdup(name);
    history[changeCount].quantity = quantity;
    history[changeCount].description = strdup(description);
    history[changeCount].category = strdup(category);
    history[changeCount].timestamp = getCurrentTime();
    changeCount++;

    printf("Added %d of %s (%s) to inventory in category %s.\n", quantity, name, description, category);
}

void removeItem(char *name) {
    for (int i = 0; i < itemCount; i++) {
        if (strcmp(inventory[i].name, name) == 0) {
            printf("Removed %s from inventory.\n", name);

            // Registrar el cambio
            history[changeCount].action = strdup("REMOVE");
            history[changeCount].name = strdup(name);
            history[changeCount].quantity = inventory[i].quantity;
            history[changeCount].description = strdup(inventory[i].description);
            history[changeCount].category = strdup(inventory[i].category);
            history[changeCount].timestamp = getCurrentTime();
            changeCount++;

            for (int j = i; j < itemCount - 1; j++) {
                inventory[j] = inventory[j + 1];
            }
            itemCount--;
            return;
        }
    }
    printf("Item %s not found in inventory.\n", name);
}

void updateItem(char *name, int quantity) {
    for (int i = 0; i < itemCount; i++) {
        if (strcmp(inventory[i].name, name) == 0) {
            inventory[i].quantity = quantity;
            printf("Updated %s to %d in inventory.\n", name, quantity);

            // Registrar el cambio
            history[changeCount].action = strdup("UPDATE");
            history[changeCount].name = strdup(name);
            history[changeCount].quantity = quantity;
            history[changeCount].description = strdup(inventory[i].description);
            history[changeCount].category = strdup(inventory[i].category);
            history[changeCount].timestamp = getCurrentTime();
            changeCount++;

            return;
        }
    }
    printf("Item %s not found in inventory.\n", name);
}

void showInventory(void) {
    printf("Inventory:\n");
    for (int i = 0; i < itemCount; i++) {
        printf("%s: %d (%s) [Category: %s]\n", inventory[i].name, inventory[i].quantity, inventory[i].description, inventory[i].category);
    }
}

void showHistory(void) {
    printf("Change History:\n");
    for (int i = 0; i < changeCount; i++) {
        printf("%s: %s %d (%s) [Category: %s] at %s\n", 
            history[i].action, history[i].name, history[i].quantity, 
            history[i].description, history[i].category, history[i].timestamp);
    }
}

void saveInventory(char *filename) {
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        printf("Error opening file %s for writing.\n", filename);
        return;
    }
    for (int i = 0; i < itemCount; i++) {
        fprintf(file, "%s %d %s %s\n", inventory[i].name, inventory[i].quantity, inventory[i].description, inventory[i].category);
    }
    fclose(file);
    printf("Inventory saved to %s.\n", filename);
}

void loadInventory(char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file %s for reading.\n", filename);
        return;
    }
    itemCount = 0;
    char name[100];
    int quantity;
    char description[100];
    char category[100];
    while (fscanf(file, "%s %d %s %s", name, &quantity, description, category) != EOF) {
        inventory[itemCount].name = strdup(name);
        inventory[itemCount].quantity = quantity;
        inventory[itemCount].description = strdup(description);
        inventory[itemCount].category = strdup(category);
        itemCount++;
    }
    fclose(file);
    printf("Inventory loaded from %s.\n", filename);
}

void searchByCategory(char *category) {
    printf("Items in category '%s':\n", category);
    for (int i = 0; i < itemCount; i++) {
        if (strcmp(inventory[i].category, category) == 0) {
            printf("%s: %d (%s)\n", inventory[i].name, inventory[i].quantity, inventory[i].description);
        }
    }
}

void searchByDescription(char *description) {
    printf("Items with description containing '%s':\n", description);
    for (int i = 0; i < itemCount; i++) {
        if (strstr(inventory[i].description, description) != NULL) {
            printf("%s: %d (%s) [Category: %s]\n", inventory[i].name, inventory[i].quantity, inventory[i].description, inventory[i].category);
        }
    }
}



int main(void) {
    return yyparse();
}
