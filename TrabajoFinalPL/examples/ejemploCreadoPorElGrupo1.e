#
Programa EJEMPLO de ipe.exe
En este ejemplo nuestro programa puede hacer dos acciones distintas mostrando todas las capacidades de nuestro lenguaje:
Calcular fibonacci



#
_borrar;

_lugar(10,10);

escribir_cadena('Introduce tu nombre --> ');

leer_cadena(nombre);

_borrar;
_lugar(10,10);

escribir_cadena(' Bienvenido/a '||nombre||' al intérprete de pseudocódigo en español:\'ipe.exe\'.');

_lugar(40,10);
escribir_cadena('Pulsa una tecla para continuar');
esperar_tecla;

repetir 

 @ Opciones disponibles

 _borrar;

 _lugar(10,10);
 escribir_cadena(' Calcular fibonacci --> 1 ');

 _lugar(11,10);
 escribir_cadena(' Numeros primos menores que un numero dado ----> 2 ');

 _lugar(12,10);
 escribir_cadena(' Finalizar ---------------> 0 ');

 _lugar(15,10);
 escribir_cadena(' Elige una opcion ');

 leer(opcion);

 _borrar;

 si (opcion  = 0)        @ Fin del programa
    entonces  
        _lugar(10,10);
        escribir_cadena(nombre);
        escribir_cadena(': gracias por usar el intérprete ipe.exe ');

   si_no
       @ Calcular fibonacci 
	si (opcion = 1)
   	    entonces
                _lugar(10,10);
		escribir_cadena('Fibonacci ');

                _lugar(11,10);
		escribir_cadena(' Introduce el numero de iteraciones de fibonacci ');
		leer(N);
		si (N>0)
		entonces
        		fibonacci_1 := 1;
			fibonacci_2 := 0;

       			para i desde 1 hasta N-1 paso 1 hacer
		  	 aux:=fibonacci_2;
		  	 fibonacci_2 := fibonacci_1;
	          	 fibonacci_1 +:= aux;
        		fin_para;

        		@ Resultado
	       	 	_lugar(15,10);
			escribir_cadena(' El numero fibonacci con ');
			escribir(N);
			escribir_cadena(' iteraciones es ');
			escribir(fibonacci_1);
    		si_no
	       	 	_lugar(15,10);
			escribir_cadena(' Error: el numero debe ser positivo');
		fin_si			
   	@ Máximo común divisor
	si_no 
		si (opcion = 2)
			entonces
                	_lugar(10,10);
			escribir_cadena('Numeros primos menores que uno dado ');

               		_lugar(11,10);
			escribir_cadena(' Introduce el numero ');
			leer(N);
			si (N>0)
				entonces
				mientras(N>1)
				hacer
					aux:=(N _div 2)+1;
					aux2:=false;
					repetir
						si(N _mod aux = 0 _y aux <> N)
						entonces
							@escribir(N);
							@escribir_cadena('/');
							@escribir(aux);
							@escribir_cadena('\n');
							aux2:=true;
						fin_si
						aux--;


					hasta (aux=1 _o aux2)
					si(_no aux2)
					entonces
						escribir(N);
						escribir_cadena(' , ');		

					fin_si
				N--;
				fin_mientras 
			escribir_cadena('1\n');				
			si_no
	       	 		_lugar(15,10);
				escribir_cadena(' Error: el numero debe ser positivo');
			fin_si			
			@ Resto de opciones
 			si_no  
				_lugar(15,10);
			    	escribir_cadena(' Opcion incorrecta ');

 			fin_si;   
  	fin_si;                 

  fin_si;                          

 _lugar(40,10); 
 escribir_cadena('\n Pulse una tecla para continuar --> ');
esperar_tecla;
 
hasta (opcion = 0);             

