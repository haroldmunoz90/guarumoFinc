<?php

class TelegramMsg {

	const message_help = 
	"Para usar Salam solo deber ingresar que reporte quieres, de cuando lo quieres (tomará por defecto el mes actual)
	y si lo quieres de un empleado en especial (anteponiendo la palabra empleado). \n
	Algunos ejemplos son:\n
	Quiero un reporte de marcaciones tarde del empleado Carlos Perez \n
	Quiero ver las llegadas temprano de este mes \n
	Quiero ver las llegadas tarde de esta semana";

	const message_dates = "Los tiempos que puedes utilizar son: \n
	dia de hoy, hoy, dia de ayer, ayer, semana (ultima, pasada, esta), mes(ultimo,pasado, este), 
	o puedes poner entre que fechas quieres el reporte. Para esto debes usar el formato  año(yyyy o yy), 
	mes(mm), día (dd) separadas por \"/\" \",\"  \"-\" \" \"  y anteponiendo las palabras desde y hasta\n
	Ejemplo:\n
	Marcaciones de hoy\n
	Marcaciones desde 16/01/21 hasta 16-01-25\n
	Marcaciones de la semana pasada";
	
	const message_examples = "Quiero un resumes de marcaciones \n
	Reporte de llegadas tarde del mes pasado\n
	Dame un reporte de salidas tarde de la semana pasada\n
	Marcaciones a tiempo de la semana\n
	Reporte de llegadas temprano del empleado Pedro Perez de ayer\n
        Hora de marcaciones\n
        Prenomina\n
        personal en sitio\n
        detalle del personal en sitio\n";

	const message_reports = "Los reportes que puedes obtener son: \n
	Marcaciones (temprano, tarde, a tiempo), \n
	Llegadas (temprano, tarde, a tiempo), \n
	Salidas (temprano, tarde, a tiempo), \n
	dados por horas de marcacion o en total \n
	Acumulado (en horas) de llegadas tarde,\n
        Prenomina,\n
        Novedades (total y detalle),\n
        Personal en sitio (total y detalle)\n
        
	y pronto tendrás más!";

	const message_hello = "Hola, en que puedo ayudarte hoy?";

        const message_canceled = "La operacion ha sido cancelada"; 

        const keyboard_main = '{"keyboard":[["Reportar novedad","Sacar reporte"],["Certificados","Ejemplos"]]}';

	const message_hello_array = " en que puedo ayudarte hoy?; que puedo hacer por ti?; que puedo brindarte el día de hoy?";
        
        const keyboard_HospitalMain = '{"keyboard":[["Pediatria","Oftalmología"],["Cardiologia"]]}';

        
        
        
}