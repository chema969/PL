#
Programa EJEMPLO 2 de ipe.exe
Este programa recibe un numero, lo pasa a entrero, calcula el numero de cifras de este número y mira si es palindromo o no.



#

_borrar;
_lugar(10,0);
escribir_cadena('Introduce un número:');
leer(numero);


numero:= numero _div 1;

i:=0;
aux:=false;
 mientras(_no aux)
   hacer
     si((numero _div (10**i)) <> 0)
	entonces
	 i++;
     si_no
	aux:=true;
     fin_si
 fin_mientras

escribir_cadena('El número tiene \'');
escribir(i);
escribir_cadena('\' cifras \n');

copia:=numero;

numero_inverso:=0;
mientras(copia<>0)
hacer
	lo_que_queda:=copia _mod 10;
	numero_inverso:=numero_inverso*10 +lo_que_queda;
	copia:=copia _div 10;
fin_mientras


si(numero_inverso=numero)
entonces
  escribir_cadena('El número es un palindromo\n');	
si_no
  escribir_cadena('El número no es un palindromo\n');	
fin_si

