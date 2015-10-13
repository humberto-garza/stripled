grammar MyGrammar;

//////////////////////////////////////////////////////////////////
programa: 
			SIZE
			CTEI
			CO
			programa_1
			EOF
;			
	programa_1: 
	 			MANUAL
	 			SC
	 			programa_2
				bloque
		| 
				AUTOMATICO
				SC
	;
	programa_2: 
				varsS
		| 
				/*epsilon*/
	;
//////////////////////////////////////////////////////////////////
varsS:
		VAR
		vars_1
;
	vars_1:
			ID
			vars_2
			CO
			tipo
			SC
			vars_1
		|
			/*epsilon*/
	;
	vars_2:
			CM
			ID
			vars_2
		|
			/*epsilon*/
	;
//////////////////////////////////////////////////////////////////
tipo:
		INT
	|	
		FLOAT
	|
		BOOL
;
//////////////////////////////////////////////////////////////////
bloque:
		LC
		bloque_1
		RC
;
	bloque_1:
				estatuto
				bloque_1
			|
				/*epsilon*/
	;
//////////////////////////////////////////////////////////////////
estatuto: 
		asignacion
	|
		condicion
	| 
		ciclo
	|  
	    led_operation
;
//////////////////////////////////////////////////////////////////
asignacion:
			ID
			EQ
			expresion
			SC
;
//////////////////////////////////////////////////////////////////
condicion:
			IFC
			LB
			expresion
			RB
			bloque
			condicion_1
			SC
;
	condicion_1:
				ELSE
				bloque
			|
				/*epsilon*/
	;
//////////////////////////////////////////////////////////////////
ciclo:
			for_loop
		|
			while_loop
;

	for_loop:	
				FOR
				LB
				asignfor
				SC
				expresion
				SC
				asignfor
				RB
				bloque
				SC
	;
	asignfor:	
				ID
				EQ
				exp
	;
	while_loop:
				WHILE 
				LB
				expresion
				RB
				bloque
				SC
	;

//////////////////////////////////////////////////////////////////
expresion:
			exp
			expresion_1
;
	expresion_1:
				expresion_2
				exp
			|
				/*epsilon*/
	;
	expresion_2:
				GT
			|	
				LT
			|
				LGT
	;
//////////////////////////////////////////////////////////////////
exp:	
	termino
	exp_1 
;
	exp_1:
			exp_2 
			exp
		|
			/*epsilon*/
	;
	exp_2: 
			PL
		|
			MI
	;
//////////////////////////////////////////////////////////////////
termino:
		factor
		termino_1
;
	termino_1: 	termino_2
				termino
			|	
				/*epsilon*/
	;
	termino_2: 
				MU
			|
				DI
	; 
//////////////////////////////////////////////////////////////////
factor:
		LB
		expresion
		RB
	|
		factor_1
		var_cte
;	
	factor_1:
				exp_2
			|
				/*epsilon*/
	;
//////////////////////////////////////////////////////////////////
var_cte:
		CTEF
	|
		CTEI
	|
		ID
	|
	    CTEB
;
//////////////////////////////////////////////////////////////////
led_operation:
		LEDS
		LS
		exp
		led_operation1
		RS
		PO
		led_operation2
;
	led_operation1:	
					PP
					exp
				|
					/*epsilon*/
	;

	led_operation2:	
					led_operation3		
					LB
					exp
					CM
					exp
					CM
					exp
					RB
					SC
				|
					SET_FREQ
					LB
					exp
					RB
					SC
	;
	led_operation3:	
					COLOR_ON
				|
					COLOR_OFF
	;

//////////////////////////////////////////////////////////////////
/*////////////////////TOKENS////////////////////////////////////*/
//////////////////////////////////////////////////////////////////
PROGRAM: 	'program';	
SIZE:  		'size';
AUTOMATICO: 'AUTOMATICO';
MANUAL:    	'MANUAL';
VAR: 		'var';	
INT: 		'int';
FLOAT: 		'float';
BOOL: 		'bool';
IFC: 		'if';
ELSE:		'else';
PRINT: 		'print'; 
FOR:		'for';
LEDS:		'LEDS';
WHILE:		'while';
COLOR_ON:	'color_on';
COLOR_OFF:	'color_off';
SET_FREQ:	'set_freq';
CTEB:		('TRUE'|'FALSE');
ID: 		('a'..'z'|'A'..'Z')(('a'..'z'|'A'..'Z')|('0'..'9'))*;

SC:			';';
LS: 		'[';
RS:			']';
CO:			':';
LC:			'{';
RC:			'}';
EQ:			'=';
CM:			',';
LB:			'(';
RB:			')';
PO:			'.';
PP:			'..';
LGT:		'<>';
LT:			'<';
GT:			'>';
PL:			'+';
MI:			'-';
MU:			'*';
DI:			'/'	;
	
CTEF:		('0'..'9')*'.'('0'..'9')+;
CTEI:		('0'..'9')+;


/*Ignore all white space characters */
WS: [ ' ' | \n | \t | \r ]+ -> channel(HIDDEN);