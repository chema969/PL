%{
 #include <string.h>
 int registros=0;
 int aux;
 int aux2=0;
 char* usuario;
 char* fecha;
  /* Descripcion:


 */

%}

/* Definiciones regulares */
letra		[a-z]
numero		[0-9]
nom_registro	(p|i){numero}2{letra}{letra}{letra}{letra}{letra}
fecha		{numero}{numero}\/{numero}{numero}\/{numero}{numero}{numero}{numero}
hora		{numero}{numero}:{numero}{numero}
fichero		({letra}|{numero})+\.({letra}|{numero})+
espacios	[ \t]+
%x ESTADO_REGISTRO
%% 

<ESTADO_REGISTRO>\n 		{BEGIN 0;}
<ESTADO_REGISTRO>{fecha} {
			   if((aux==4)&&(aux2==1)){
			         aux2=0;
				 if(strcmp(fecha,yytext)==0) registros++;
			   }
			}
<ESTADO_REGISTRO>{hora} {	}
<ESTADO_REGISTRO>{fichero} {	}
^{nom_registro}|^{espacios}{nom_registro}	{
 			BEGIN ESTADO_REGISTRO;
				if((strcmp(usuario,yytext)==0)&&(aux==3)) registros++;
                                if((strcmp(usuario,yytext)==0)&&(aux==4)) aux2=1;
			}
{espacios}		{ }
<ESTADO_REGISTRO>{espacios} {}

%%  

extern FILE *yyin, *yyout;

int main(int argc, char **argv)
{
 
 switch(argc)
  {
   case 3:  yyin=fopen(argv[1],"r"); 
	    usuario=argv[2];
	break;
   case 4:  yyin=fopen(argv[1],"r"); 
	    usuario=argv[2];
	    fecha=argv[3];
	break;
   default: 
	return 0;	  
  }
  aux=argc;
  yylex();
  fprintf(yyout," Numero de registros con esas condiciones=%d\n",registros);
  return 0;
}
