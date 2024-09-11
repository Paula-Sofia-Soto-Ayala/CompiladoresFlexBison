%{
#include "parser.tab.h"
%}

extern int yylineno;

%%

"add"           { return ADD; }
"remove"        { return REMOVE; }
"show"          { return SHOW; }
"update"        { return UPDATE; }
"description"   { return DESCRIPTION; }
"save"          { printf("Token SAVE recognized\n"); return SAVE; }
"load"          { printf("Token LOAD recognized\n"); return LOAD; }
"category"      { return CATEGORY; }
"search"        { return SEARCH; }
"history"        { return HISTORY; }
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
