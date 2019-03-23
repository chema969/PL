%{
 #include <string.h>
 #include <stdlib.h>
 char palabraClave[]="";
 int* palabraClaveTransformada;
 int opcion;
 long unsigned int tamanyoPalabraClave;
 int cursorPalabraClave=0;
 char vector[]={'a','b','c','d','e','f','g','h','i','j','k','l','m','n',164,'o','p','q','r','s','t','u','v','w','x','y','z'};
 char findAndSet(char letra);
 char reverseFindAndSet(char letra);
  /* Descripcion:


 */

%}

/* Definiciones regulares */
letra         [a-zA-Z]
letra_especial (ñ|á|é|í|ó|ú|Á|É|Í|Ó|Ú)
%% 

{letra}|{letra_especial}	{if(opcion==1)
                                   {printf("%c",findAndSet(yytext[0]));cursorPalabraClave=(cursorPalabraClave+1)%tamanyoPalabraClave;}
                                 if(opcion==2){
                                   printf("%c",reverseFindAndSet(yytext[0]));cursorPalabraClave=(cursorPalabraClave+1)%tamanyoPalabraClave;}}




%%  

extern FILE *yyin, *yyout;


int main(int argc, char **argv)
{
   printf("[1] Cifrar un mensaje\n");
   printf("[2] Descifrar un mensaje\n");
   
   printf("\n\nIntroduce una opcion: ");
     if(!scanf("%d",&opcion)){printf("ERROR LEYENDO\n");return 0;};
   
   printf("Introduce la palabra clave:");
     if(!scanf("%s",palabraClave)){printf("ERROR LEYENDO\n");return 0;};


   long unsigned int t,i,j;
   tamanyoPalabraClave=t=strlen(palabraClave);
   palabraClaveTransformada=(int*)malloc(tamanyoPalabraClave*sizeof(int));
   for( i=0;i<tamanyoPalabraClave;i=i+1){
    int f=0;
     for( j=0;(j<27)&&(f==0);j++){
       if(palabraClave[i]==vector[j]){
         palabraClaveTransformada[i]=j;
         f++;
       } 
     }
   }

   yylex();

  return 0;
}

char findAndSet(char letra){
int i;
  for(i=0;i<27;i++){
	if(letra==vector[i]){
	    return vector[(i+palabraClaveTransformada[cursorPalabraClave])%27];
	}
  }
  return ' ';
}

char reverseFindAndSet(char letra){
  int i;
  for(i=0;i<27;i++){
	if(letra==vector[i]){
	    return vector[((i-palabraClaveTransformada[cursorPalabraClave])+27)%27];
	}
  }
  return ' ';
}

   
  
