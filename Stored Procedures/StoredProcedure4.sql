/*

4. Reporte de porcentaje de pacientes que son intubados

Ejemplo: call intubados();

*/

DROP PROCEDURE IF EXISTS intubados;

DELIMITER $$

CREATE PROCEDURE intubados()
	BEGIN
	
		select 
			'Sobreviven',
			lpad(format(sum(if(p.intubado = 1,if(d.fecha_defuncion is null,1,0),0)),0),length('Num. Pacientes'),' ') as 'Num. Pacientes',
			lpad(concat(format(round(sum(if(p.intubado = 1,if(d.fecha_defuncion is null,1,0),0))/sum(if(p.intubado = 1,1,0)) *100,0),1),' %'),length('Proporcion'),' ') as 'Proporcion'
		from pacientes p 
		left join defunciones d using(id_paciente) 
		where clave_resultado = 1
		union
		select 
			'Fallecen',
			lpad(format(sum(if(p.intubado = 1,if(d.fecha_defuncion is not null,1,0),0)),0),length('Num. Pacientes'),' ') as 'Num. Pacientes',
			lpad(concat(format(round(sum(if(p.intubado = 1,if(d.fecha_defuncion is not null,1,0),0))/sum(if(p.intubado = 1,1,0)) *100,0),1),' %'),length('Proporcion'),' ') as 'Proporcion'
		from pacientes p 
		left join defunciones d using(id_paciente) 
		where clave_resultado = 1
		union
		select 
			'Total',
			lpad(format(sum(if(p.intubado = 1,1,0)),0),length('Num. Pacientes'),' ') as 'Num. Pacientes',
			lpad(concat(format(round(sum(if(p.intubado = 1,1,0))/sum(if(p.intubado = 1,1,0)) *100,0),1),' %'),length('Proporcion'),' ') as 'Proporcion'
		from pacientes p 
		left join defunciones d using(id_paciente)
		where clave_resultado = 1;

	END;$$

DELIMITER ;