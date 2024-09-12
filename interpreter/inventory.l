%{
#include "parser.tab.h"
%}

extern int yylineno;

%%

"add"           { printf("Token ADD recognized\n"); return ADD; }
"remove"        { printf("Token REMOVE recognized\n"); return REMOVE; }
"show"          { printf("Token SHOW recognized\n"); return SHOW; }
"update"        { printf("Token UPDATE recognized\n"); return UPDATE; }
"description"   { printf("Token DESCRIPTION recognized\n"); return DESCRIPTION; }
"save"          { printf("Token SAVE recognized\n"); return SAVE; }
"load"          { printf("Token LOAD recognized\n"); return LOAD; }
"category"      { printf("Token CATEGORY recognized\n"); return CATEGORY; }
"search"        { printf("Token SEARCH recognized\n"); return SEARCH; }
"history"       { printf("Token HISTORY recognized\n"); return HISTORY; }
"sort"          { printf("Token SORT recognized\n"); return SORT; }
"by"            { printf("Token BY recognized\n"); return BY; }
"name"          { printf("Token NAME recognized\n"); return NAME; }
"help"          { printf("Token HELP recognized\n"); return HELP; }
"="             { return ASSIGN; }
";"             { return SEMICOLON; }
[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_\.]*  { printf("Token IDENTIFIER recognized: %s\n", yytext); yylval.str = strdup(yytext); return IDENTIFIER; }
[ \t\r\n]+      { /* Ignore white spaces and line breaks */ }
.               { printf("Character not recognized: %s on line %d\n", yytext, yylineno); return yytext[0]; 
}

%%

int yywrap(void) {
    return 1;
}
