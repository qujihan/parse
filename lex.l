/*! @file lex.l
 * @brief Lexical Analysis
 *********************************************************************
 * a simple calculator with variables
 * 
 * sample-files for a artikel in developerworks.ibm.com
 * Author: Christian Hagen, chagen@de.ibm.com
 * 
 * @par lex.l & lex.c
 * input for flex the lexical analysis generator
 * 
 *********************************************************************
 */
%option noyywrap

%{
/*--------------------------------------------------------------------
 * 
 * includes
 * 
 *------------------------------------------------------------------*/
#include "ccalc.h"

/*--------------------------------------------------------------------
 * 
 * global variables
 * 
 *------------------------------------------------------------------*/

/*--------------------------------------------------------------------
 * 
 * defines
 * 
 *------------------------------------------------------------------*/
#define YY_INPUT(buf,result,max_size)  {\
    result = GetNextChar(buf, max_size); \
    if (  result <= 0  ) \
      result = YY_NULL; \
    }

%}

/*--------------------------------------------------------------------
 * 
 * flex definitions
 * 
 *------------------------------------------------------------------*/
DIGIT    [0-9]
ID       [_a-zA-Z][_a-zA-Z0-9]*

%%

[ \t\r\n]+  {
    /* eat up whitespace */
    if (lex_debug) {
        // printf("lex.l \\t \\r \\n: %s\n", yytext);
    }
    BeginToken(yytext); 
    }
{DIGIT}+  {
    if (lex_debug) {
        printf("lex.l value: %s\n", yytext);
    }
    BeginToken(yytext); 
    yylval.value = atof(yytext);
    return VALUE;
    }
{DIGIT}+"."{DIGIT}*        {
    if (lex_debug) {
        printf("lex.l value: %s\n", yytext);
    }
    BeginToken(yytext);
    yylval.value = atof(yytext);
    return VALUE;
    }
{DIGIT}+[eE]["+""-"]?{DIGIT}*        {
    if (lex_debug) {
        printf("lex.l value: %s\n", yytext);
    }
    BeginToken(yytext);
    yylval.value = atof(yytext);
    return VALUE;
    }
{DIGIT}+"."{DIGIT}*[eE]["+""-"]?{DIGIT}*        {
    if (lex_debug) {
        printf("lex.l value: %s\n", yytext);
    }
    BeginToken(yytext);
    yylval.value = atof(yytext);
    return VALUE;
    }
{ID}        {
    if (lex_debug) {
        printf("lex.l identifier: %s\n", yytext);
    }
    BeginToken(yytext);
    yylval.string = malloc(strlen(yytext)+1);
    strcpy(yylval.string, yytext);
    return IDENTIFIER;
    }
"+"       { 
    if (lex_debug) {
        printf("lex.l add: %s\n", yytext);
    }
    BeginToken(yytext); return ADD; 
    }
"-"       { 
    if (lex_debug) {
        printf("lex.l sub: %s\n", yytext);
    }
    BeginToken(yytext); return SUB; 
    }
"*"       { 
    if (lex_debug) {
        printf("lex.l mult: %s\n", yytext);
    }
    BeginToken(yytext); return MULT; 
    }
"/"       { 
    if (lex_debug) {
        printf("lex.l div: %s\n", yytext);
    }
    BeginToken(yytext); return DIV; 
    }
"("       { 
    if (lex_debug) {
        printf("lex.l l_brace: %s\n", yytext);
    }
    BeginToken(yytext); return LBRACE; 
    }
")"       { 
    if (lex_debug) {
        printf("lex.l r_brace: %s\n", yytext);
    }
    BeginToken(yytext); return RBRACE; 
    }
";"       { 
    if (lex_debug) {
        printf("lex.l semicolon: %s\n", yytext);
    }
    BeginToken(yytext); return SEMICOLON; 
    }
"="       { 
    if (lex_debug) {
        printf("lex.l assign: %s\n", yytext);
    }
    BeginToken(yytext); return ASSIGN; 
    }

.         {
    if (lex_debug) {
        printf("lex.l .: %s\n", yytext);
    }
    BeginToken(yytext);
    return yytext[0];
    }
%%

/*--------------------------------------------------------------------
 * lex.l
 *------------------------------------------------------------------*/
