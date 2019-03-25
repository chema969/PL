%{
 #include <string.h>
 #include <stdlib.h>
 char *palabraClave;
 int* palabraClaveTransformada;
 int opcion;
 long unsigned int tamanyoPalabraClave;
 int cursorPalabraClave=0;
 char vector[]={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
 char findAndSet(char letra);
 char reverseFindAndSet(char letra);
  /* Descripcion:


 */

%}

/* Definiciones regulares */
letra         [a-z]
letra_mayus   [A-Z]
letra_especial (ñ|á|é|í|ó|ú|Á|É|Í|Ó|Ú)
%% 

{letra}				{if(opcion==1)
                                   {printf("%c",findAndSet(yytext[0]));cursorPalabraClave=(cursorPalabraClave+1)%tamanyoPalabraClave;}
                                 if(opcion==2){
                                   printf("%c",reverseFindAndSet(yytext[0]));cursorPalabraClave=(cursorPalabraClave+1)%tamanyoPalabraClave;}}

{letra_mayus}			{yytext[0]=tolower(yytext[0]);
				if(opcion==1)
                                   {printf("%c",toupper(findAndSet(yytext[0])));cursorPalabraClave=(cursorPalabraClave+1)%tamanyoPalabraClave;}
                                 if(opcion==2){
                                   printf("%c",toupper(reverseFindAndSet(yytext[0])));cursorPalabraClave=(cursorPalabraClave+1)%tamanyoPalabraClave;}
				}


%%  

extern FILE *yyin, *yyout;


int main(int argc, char **argv)
{
   if(argc==2){
   printf("[1] Cifrar un mensaje\n");
   printf("[2] Descifrar un mensaje\n");
   
   printf("\n\nIntroduce una opcion: ");
     if(!scanf("%d",&opcion)){printf("ERROR LEYENDO\n");return 0;};

   palabraClave=argv[1];
   tamanyoPalabraClave=strlen(palabraClave);


   int auxx;
   for(auxx=0;auxx<tamanyoPalabraClave;auxx++){
	palabraClave[auxx]=tolower(palabraClave[auxx]);
   }

   long unsigned int i;

   palabraClaveTransformada=(int*)malloc(tamanyoPalabraClave*sizeof(int));

   for( i=0;i<tamanyoPalabraClave;i=i+1){

      palabraClaveTransformada[i]=palabraClave[i]-97;      
   }

   yylex();
  }
  else{
    printf("Introduce la palabra clave por linea de comandos\n");
  }
  return 0;
}

char findAndSet(char letra){
return vector[((letra-97)+palabraClaveTransformada[cursorPalabraClave])%26];
}

char reverseFindAndSet(char letra){
return vector[(((letra-97)-palabraClaveTransformada[cursorPalabraClave])+26)%26];
}

   
  
