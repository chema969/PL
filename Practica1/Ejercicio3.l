%{
  #include "Ejercicio3.h"
  /* Descripcion:


 */

%}

/* Definiciones regulares */
espacio		[ \t\n]
espacios	{espacio}+
digito		[0-9]
letra_may	[A-Z]
letra_min	[a-z]
letra		[a-zA-Z]
identificador1	{letra}[{letra}|{digito}]*
identificador2	{identificador1}_[{letra}|{digito}]+
numero		{digito}+(\.{digito}+)?(E{digito}+)?
comentario1	#.*

%% 
{espacios} { }
{identificador1}|{identificador2} {fprintf(yyout,"%s",
			 yytext);}



%%  

extern FILE *yyin, *yyout;

int main(int argc, char *argv[])
{
 
 switch(argc)
  {
   case 2:  yyin=fopen(argv[1],"r"); 
            break;
  }
  yylex();

  return 0;
}
