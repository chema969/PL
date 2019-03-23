%{
 #include <string.h>
 char* palabra1;
 char* palabra2;
 int palabrasSubs=0;
  /* Descripcion:


 */

%}

/* Definiciones regulares */
letra         [a-zA-Z0-9]
palabra		{letra}{letra}*

%% 

{palabra} {if(strcmp(yytext,palabra1)==0){fprintf(yyout,"%s",
			 palabra2);
			palabrasSubs++;}
           else fprintf(yyout,"%s", yytext); }



%%  

extern FILE *yyin, *yyout;

int main(int argc, char **argv)
{
 
 switch(argc)
  {
   case 4:  yyin=fopen(argv[1],"r"); 
            palabra1= argv[2];
            palabra2= argv[3];
  break;
   default:
	printf(" Introduce por linea de comandos el nombre del fichero, la palabra a sustituir y la palabra por la que se sustituye\n");
	return 0;
  }
  yylex();
  fprintf(yyout," Numero de palabras substituidas=%d\n",palabrasSubs);
  return 0;
}
