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
loquesea	{letra}|{digito}
identificador1	{letra}{loquesea}*
identificador2	{identificador1}_{loquesea}+
numero		{digito}+(\.{digito}+)?(E{digito}+)?
comentario1	#.*
%x COMENTARIO
%x CADENA
%% 



 
{espacios} { }

'			{BEGIN CADENA;fprintf(yyout,"\n INICIO DE CADENA\n");}

<CADENA>'		{BEGIN 0;fprintf(yyout,"\n FIN DE CADENA\n");}

<CADENA>\\'		{fprintf(yyout,"'"); }

\(\* 			{BEGIN COMENTARIO;fprintf(yyout,"\n INICIO DE COMENTARIO\n");}

<COMENTARIO>\*\)	{BEGIN 0;fprintf(yyout,"\n FIN DE COMENTARIO\n");}

<COMENTARIO>\(\		{fprintf(yyout,"\n ERROR, inicia un comentario dentro de otro comentario\n");} 

#.*			{fprintf(yyout,"\n COMENTARIO EN LINEA: %s\n",yytext);}

(?i:inicio)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,inicio);}

(?i:fin)			{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,fin);}
		
(?i:leer)			{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,leer);}

(?i:escribir)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,escribir);}

(?i:si)			{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,si);}

(?i:entonces)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,entonces);}

(?i:si_no)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,si_no);}

(?i:fin_si)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,fin_si);}

(?i:mientras)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,mientras);}

(?i:hacer)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,hacer);}

(?i:fin_mientras)	{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,fin_mientras);}

(?i:repetir)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,repetir);}

(?i:hasta_que)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,hasta_que);}

(?i:para)			{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,para);}

(?i:desde)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,desde);}

(?i:hasta)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,hasta);}

(?i:paso)			{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,paso);}

(?i:fin_para)		{fprintf(yyout,"\n Palabra reservada: %s --> token %d\n", yytext,fin_para);}


:=		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,asignacion);}

\+		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,suma);}

\-		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,resta);}

\*		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,producto);}

\/		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,division);}

__mod		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,modulo);}

\*\*		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,potencia);}

\|\|		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,concatenacion);}

>		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,mayor_que);}

>=		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,mayor_igual_que);}

\<		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,menor_que);}

\<=		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,menor_igual_que);}

==		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,igual);}

\<>		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,distinto);}

\.o\.		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,disyuncion_logica);}

\.y\.		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,conjuncion_logica);}

\.no\.		{fprintf(yyout,"\n Operador: %s --> token %d\n", yytext,negacion_logica);}

;		{fprintf(yyout,"\n Fin de sentencia:; --> token %d\n",fin_sentencia);}

\(		{fprintf(yyout,"\n Parentesis izquierdo:( --> token %d\n",parentesis_izquierdo);}

\)		{fprintf(yyout,"\n Parentesis derecho:) --> token %d\n",parentesis_derecho);}

{identificador1}|{identificador2} {fprintf(yyout,"\n Identificador: %s\n",
			 yytext);}

{numero}	{fprintf(yyout,"\n Numero: %s \n",yytext);}

{numero}\.({digito}|{letra})*	{fprintf(yyout,"\n Numero ERRONEO: %s \n",yytext);}

{identificador1}_|_({letra}|{numero})*|{numero}+({letra}|_|{numero})* {fprintf(yyout,"\n Identificador ERRONEO: %s \n",yytext);}
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
