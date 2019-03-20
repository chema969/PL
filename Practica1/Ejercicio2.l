%{
#include <string>
 std::string palabra1,palabra2;
  /* Descripcion:


 */

%}

/* Definiciones regulares */
letra         [a-zA-Z]
palabra		{letra}{letra}*

%% 

{palabra} {fprintf(yyout,"%s",
			 yytext);}



%%  

extern FILE *yyin, *yyout;

int main(int argc, char *argv[])
{
 
 switch(argc)
  {
   case 4:  yyin=fopen(argv[1],"r"); 
            palabra1=argv[2];
            palabra2=argv[3];
  }
  yylex();

  return 0;
}
