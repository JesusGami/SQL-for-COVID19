/*
2. Número de casos registrados, casos positivos, casos negativos, casos sospechosos totales a la fecha de actualización, 
según el parámetro que aceptará cualquiera de las 3 opciones:

‘gral’ Para un reporte general de casos
‘sexo’ Para un reporte que desglosa los casos positivos por sexo
‘comor’ Para un reporte de número total de pacientes por comorbilidad

Cualquier otra palabra debe marcar opción no válida.


Ejemplos:
call reporteTecnico('gral');
call reporteTecnico('sexo');
call reporteTecnico('comor');
*/

DROP PROCEDURE IF EXISTS reporteTecnico;

DELIMITER $$

CREATE PROCEDURE reporteTecnico(tipo varchar(10))
	BEGIN

		IF tipo = 'gral' THEN
			select 
				fecha_actualizacion as 'Fecha de actualizacion',
				lpad(format(count(id_paciente),0),length('Casos registrados'),' ') as 'Casos registrados',
				lpad(format(sum(if(clave_resultado = 1 ,1,0)),0),length('Positivos'),' ') as 'Positivos',
				lpad(format(sum(if(clave_resultado = 2 ,1,0)),0),length('Negativos'),' ') as 'Negativos',
				lpad(format(sum(if(clave_resultado = 3,1,0)),0),length('Sospechosos'),' ') as 'Sospechosos' 
			from pacientes;
		ELSEIF tipo = 'sexo' THEN
			select 
				fecha_actualizacion as 'Fecha de actualizacion',
				lpad(format(sum(if(clave_resultado = 1 ,1,0)),0),length('Positivos'),' ') as 'Positivos',
				lpad(format(sum(if(clave_resultado = 1,if(sexo = 'H',1,0),0)),0),length('Hombres'),' ') as 'Hombres',
				lpad(format(sum(if(clave_resultado = 1,if(sexo = 'M',1,0),0)),0),length('Mujeres'),' ') as 'Mujeres' 
			from pacientes;
		ELSEIF tipo = 'comor' THEN
			select 
				c.nom_comor as 'comorbilidad',
				lpad(format(count(c.nom_comor),0),length('Total de pacientes'),' ') as 'Total de pacientes'
			from pacientes p 
			join paciente_comorbilidad pc using(id_paciente) 
			join comorbilidades c on pc.id_comorbilidad = c.id_comorbilidad
			group by 1 
			order by 2 desc;
		ELSE
			select 'Opción no válida' as Error;
		END IF;
		
	END; $$

DELIMITER ;

