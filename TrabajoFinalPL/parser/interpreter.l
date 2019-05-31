/*! 
  \file interpreter.l
  \brief Lexical or scanner file
*/
%{
#include <iostream>

/*********************/
/* NEW in example 4 */
/* atof */
#include <stdlib.h>
#include <string>
/*********************/

/* Macros for the screen */
#include "../includes/macros.hpp"

/*********************/
/* 
  NEW in example 16 
  AST class
  IMPORTANT: must be written before interpreter.tab.h
*/
#include "../ast/ast.hpp"
/*********************/

/*  interpreter.tab.h contains the numeric values of the tokens produced by the parser */
#include "interpreter.tab.h"

/********************/
/* NEW in example 3 */
#include "../error/error.hpp"
/********************/


/*********************************************/
/* NEW in example 7 */
/* Table of symbols */
#include "../table/table.hpp"

#include "../table/numericVariable.hpp"

extern lp::Table table; //!< External Table of Symbols
/*********************************************/

extern int lineNumber; //!< External line counter

std::string str;//!< Para guardar las cadenas

%}


/*! \name REGULAR DEFINITIONS  */

DIGIT  [0-9] 

LETTER [a-zA-Z]

NUMBER1 {DIGIT}+\.?([Ee][\+\-]?{DIGIT}+)?

NUMBER2 {DIGIT}*\.{DIGIT}+([Ee][\+\-]?{DIGIT}+)?

ERRORNUMBER1 {DIGIT}+\.?[Ee][\+\-]?

ERRORNUMBER2 {DIGIT}*\.{DIGIT}+[Ee][\+\-]?

ERRORNUMERO3  {DIGIT}[a-df-zA-DF-Z_]+({DIGIT}|[a-df-zA-DF-Z_])*

ERRORNUMERO4 {DIGIT}+\.?[Ee][Ee]+[\+\-]?

ERRORNUMERO5 {DIGIT}*\.{DIGIT}+[Ee][Ee]+[\+\-]?

IDENTIFIER  {LETTER}((_)?({LETTER}|{DIGIT})+)*

ERRORIDENTIFIER1  {LETTER}((_)?({LETTER}|{DIGIT})+)*_+

ERRORIDENTIFIER2  {LETTER}({LETTER}|{DIGIT})*(__+({LETTER}|{DIGIT})*)+


/* NEW in example 3 */
/* STATE  */
%x ERROR
%x COMENTARIO
%x CADENA
/*! \name REGULAR EXPRESSIONS  */
%%

[ \t] 	{ ; }    /* skip white space and tabular */

\n      { 
			/* Line counter */
           	lineNumber++; 
	
			/* MODIFIED in example 3 */
			/* COMMENTED in example 5 */
        	/* return NEWLINE; */
        }
# 			{BEGIN COMENTARIO;}

<COMENTARIO>#		{BEGIN 0;}

<COMENTARIO>.		{;}

<COMENTARIO>[ \t]	{;}

<COMENTARIO>[\n]	{           	lineNumber++; }

";"		{
			/* NEW in example 5 */
			return SEMICOLON;
		}


","		{
			/* NEW in example 14 */
			return COMMA;
		}

"'"	{BEGIN CADENA;str="";}

<CADENA>"'"		{BEGIN 0;yylval.chain=strdup(str.c_str());return CHAIN;}

<CADENA>\\'		{str=str+"'";}

<CADENA>\\n		{str=str+"\n";}

<CADENA>\\t		{str=str+"\t";}

<CADENA>.		{str=str+yytext;}

{NUMBER1}|{NUMBER2}  {
					  /* MODIFIED in example 4 */
					  /* Conversion of type and sending of the numerical value to the parser */
					   yylval.number = atof(yytext); 

                       return NUMBER; 
                      }


{IDENTIFIER}   		 {
						 /* NEW in example 7 */
						 std::string identifier(yytext);
						for(int x=0;x<identifier.size();x++){
							identifier[x]= tolower (identifier[x]);
						}
						/* 
                          strdup() function returns a pointer to a new string 
                          which  is a duplicate of the string yytext
                        */
						  yylval.identifier =  strdup(identifier.c_str()); 
 						/*Recorremos la cadena, así pasamos las mayusculas a minusculas*/

						/* If the identifier is not in the table of symbols then it is inserted */	
						 if (table.lookupSymbol(identifier) == false)
							{
								/* 
								 The identifier is inserted into the symbol table 
								 as undefined Variable with value 0.0
								*/
								lp::NumericVariable *n = new lp::NumericVariable(identifier,VARIABLE,UNDEFINED,0.0);

								/* A pointer to the new NumericVariable is inserted into the table of symbols */
								table.installSymbol(n);

								return VARIABLE;
							}

						/* MODIFIED in example 11 */
						/* 
							If the identifier is in the table of symbols then its token is returned 
								The identifier can be a variable or a numeric constant
						*/
						else 
							{
								lp::Symbol	*s = table.getSymbol(identifier);

/*
								std::cout << "lex: "<< s->getName() 
										  << "token " << s->getToken()
  										  << std::endl; 
*/

								/*  If the identifier is in the table then its token is returned  */
								return s->getToken();
							}
                     }
@.*		{}

"_div"		{ return DIVISION_ENTERA;}

"-"		{ return MINUS;  } 			/* NEW in example 3 */
"+"		{ return PLUS;   } 			/* NEW in example 3 */

"++"		{ return PLUSPLUS;}

"--"		{ return MINUSMINUS;}

"+:="		{return PLUS_ASSIGNMENT;}

"-:="		{return MINUS_ASSIGNMENT;}

"*"	    { return MULTIPLICATION; } 	/* NEW in example 3 */
"/"     { return DIVISION; } 		/* NEW in example 3 */

"("     { return LPAREN; } 			/* NEW in example 3 */
")"	    { return RPAREN; } 			/* NEW in example 3 */

\|\|	{return CONCATENACION;}

"_mod"     { return MODULO; }			/* NEW in example 5 */

"**"	    { return POWER; }			/* NEW in example 5 */

":=" 	{ return ASSIGNMENT; }		/* NEW in example 7 */


"="	{ return EQUAL; }			/* NEW in example 15 */

"<>"	{ return NOT_EQUAL; }		/* NEW in example 15 */

">="	{ return GREATER_OR_EQUAL; }/* NEW in example 15 */	

"<="	{ return LESS_OR_EQUAL; }	/* NEW in example 15 */

">"		{ return GREATER_THAN; }	/* NEW in example 15 */

"<"		{ return LESS_THAN; }		/* NEW in example 15 */

"_no"		{ return NOT; }				/* NEW in example 15 */

"_o"	{ return OR; }				/* NEW in example 15 */

"_y"	{ return AND; }				/* NEW in example 15 */

"{"		{ return LETFCURLYBRACKET; } 	/* NEW in example 17 */

"}"		{ return RIGHTCURLYBRACKET; }	/* NEW in example 17 */


(?i:_borrar)     {return BORRAR;}

(?i:_lugar)     {return LUGAR; }

{ERRORNUMBER1}|{ERRORNUMBER2} {warning("Error lexico:","Exponencial sin exponente");}

{ERRORNUMERO3}|{ERRORNUMERO5}|{ERRORNUMERO4} 	{warning("Error lexico:","Numero Erroneo");}

{ERRORIDENTIFIER1}|{ERRORIDENTIFIER2}	{warning("Error lexico:","Identificador mal escrito");}
<<EOF>> { /* The interpreter finishes when finds the end of file character */
		/*  PLACE(24,10);
	  	  std::cout <<  BICYAN;
	   	  std::cout <<  ">>>>>>> End of file <<<<<<<";
	 	  std::cout << std::endl;
	   	  std::cout << RESET;
		  PLACE(25,1);
		*/
	  	  return 0;
	}


.								{ 	
									/* Any other character */
									/* MODIFIIED in example 3 */
									/* Change to error state */
									BEGIN(ERROR); 

									/* 
										The current value of yytext 
										will be concatenated with the next character
									*/
									yymore();  
								}

<ERROR>[^0-9+\-*/()\^% \t\n\;a-zA-Z=<>!&]	{ /* MODIFIED in examples 5, 7, 15 */
								  /* NEW in example 3 */
								  /* 
									The current value of yytext 
									will be concatenated with the next character
								  */
									yymore(); 
								}

<ERROR>(.|\n)                { 
								/* NEW in example 3 */
								/* Rewind one position */
								yyless(yyleng-1); 

								/* Display the error message */
								warning("Lexical error", yytext);

								/* Restore the initial state */
   								BEGIN(INITIAL);
							}
%%

