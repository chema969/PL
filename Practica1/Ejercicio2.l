%{
#include <string>
 std::string palabra1,palabra2;
 int palabrasSubs=0;
  /* Descripcion:


 */

%}

/* Definiciones regulares */
letra         [a-zA-Z0-9]
palabra		{letra}{letra}*

%% 

{palabra} {if(yytext==palabra1){fprintf(yyout,"%s",
			 palabra2.c_str());
			palabrasSubs++;}
           else fprintf(yyout,"%s", yytext); }



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
  fprintf(yyout," Numero de palabras substituidas=%d\n",palabrasSubs);
  return 0;
}
