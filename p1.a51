ORG 0000H 
//Se enciende el led conectado a p1.0
		CLR P1.0 
		SETB P1.1 
		SETB P1.2 
		SETB P1.3 
//Se indica la direcci�n de memoria con la que se trabajar�.
		MOV DPTR, #2000H 
		MOV R1, #20H 
//Escritura a la RAM
OUTER:  MOV R0, #00H 
INNER:  MOV A, #55H 
        MOVX @DPTR, A //Se mueve a memoria externa el #55H
//Incrementa en uno la direcci�n a la que se apunta. (2001h, 2002h, etc.)
        INC DPTR 
        DJNZ R0, INNER //Simulaci�n de for, ciclo interno.
        DJNZ R1, OUTER //Simulaci�n de for, ciclo externo.
		//Se repite para leer de la misma direcci�n en la que se escribi�, 2000h.
        MOV DPTR, #2000H 
        MOV R1, #20H 
OUTER2: MOV R0, #00H 
INNER2: MOVX A, @DPTR //Se manda al acumulador lo que hay en memoria externa, 55h
        CJNE A, #55H, ERROR //Si la direcci�n en la que se lee no es igual a #55h, lo que se escribi� se va a funci�n de error.
	    INC DPTR //En caso de no error incrementa y se sigue leyendo la siguiente direcci�n de memoria.
		DJNZ R0, INNER2 //Simulaci�n de for, ciclo interno.
		DJNZ R1, OUTER2 //Simulaci�n de for, ciclo externo.
 
		SETB P1.0 
		CLR P1.1 //Si no hay error el segundo led enciende, p1.1.
//Si no hay error no se sale de este ciclo, el 2do led se mantiene encendido.
WAIT:   SJMP WAIT
//Si hay error el led conectado a p1.2 enciende.
ERROR:  
		SETB P1.0 
		SETB P1.1 
		CLR P1.2 
		SETB P1.3 
//Se mantiene en el ciclo de error, el 3er led se mantiene encendido. 
WAIT2: SJMP WAIT2 
END