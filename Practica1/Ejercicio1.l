%{
  int numero;
  /* Descripcion:


 */

%}

/* Definiciones regulares */
digito         [0-9]
digitos		{digito}{digito}*

%% 

{digitos} {if(atoi(yytext)%numero!=0){fprintf(yyout,"%s",
			 yytext);}}



%%  

extern FILE *yyin, *yyout;

int main(int argc, char *argv[])
{
 
 switch(argc)
  {
   case 3:  yyin=fopen(argv[2],"r"); 
            break;
   case 4:  yyin=fopen(argv[2],"r"); 
            yyout=fopen(argv[3],"w"); 
  }
  numero=atoi(argv[1]);
  yylex();

  return 0;
}
