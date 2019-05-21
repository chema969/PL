#Ejemplo para probar si funcionan la sentencia if












#


escribir_cadena('Escribe un numero:\n');
leer(numero);

si (numero>0) entonces
	escribir_cadena('Tu numero es positivo\n');
si_no
	si (numero<0) entonces
		escribir_cadena('Tu numero es negativo\n');
	si_no
		escribir_cadena('Tu numero es cero\n');
	fin_si
FIN_SI
