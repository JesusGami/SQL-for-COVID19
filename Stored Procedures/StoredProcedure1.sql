-- 1. Reporte de extranjeros que fallecieron, según el país de nacionalidad y un criterio de búsqueda que se pasan como
--parámetros. 

/*
El nombre del país que se pasa como parámetro puede ser completo o sólo una parte del nombre.
Los criterios deben considerar sólo los siguientes caracteres:
‘*’ Todos los extranjeros
‘=’ Los que vinieron del mismo país de nacionalidad
‘!’ Los que vinieron de un país diferente al suyo
*/
DROP PROCEDURE IF EXISTS defExtranjeros;

DELIMITER $$

CREATE PROCEDURE defExtranjeros(IN nacionalidad varchar(50), IN criterio varchar(1))
	BEGIN
	
		IF criterio = '*' THEN
			select 
				e.id_paciente,
				p.sexo,
				p.edad,
				pn.nom_pais as 'pais_nacionalidad',
				po.nom_pais as 'pais_origen',
				p.fecha_sintomas,
				p.fecha_ingreso,
				d.fecha_defuncion,
				sino.descripcion as '¿Fue intubado?',
				sino2.descripcion as '¿Tuvo neumonia?',
				tp.nom_tipo as 'Tipo de paciente',
				r.descripcion as 'Prueba covid'
			from pacientes p 
			join extranjeros e using(id_paciente) 
			join defunciones d using(id_paciente) 
			join pais pn on e.pais_nacionalidad = pn.clave_pais
			join pais po on e.pais_origen = po.clave_pais 
			join resultado r using(clave_resultado) 
			join cat_sino sino on p.intubado = sino.clave
			join cat_sino sino2 on p.neumonia = sino2.clave 
			join tipos_paciente tp on p.tipo_paciente = tp.clave_tipo
			where pn.nom_pais like CONCAT('%',nacionalidad,'%') 
			order by 2;
		ELSEIF criterio = '=' THEN
			select 
				e.id_paciente,
				p.sexo,
				p.edad,pn.nom_pais as 'pais_nacionalidad',
				po.nom_pais as 'pais_origen',
				p.fecha_sintomas,
				p.fecha_ingreso,
				d.fecha_defuncion,
				sino.descripcion as '¿Fue intubado?',
				sino2.descripcion as '¿Tuvo neumonia?',
				tp.nom_tipo as 'Tipo de paciente',
				r.descripcion as 'Prueba covid'
			from pacientes p 
			join extranjeros e using(id_paciente) 
			join defunciones d using(id_paciente) 
			join pais pn on e.pais_nacionalidad = pn.clave_pais
			join pais po on e.pais_origen = po.clave_pais 
			join resultado r using(clave_resultado) 
			join cat_sino sino on p.intubado = sino.clave
			join cat_sino sino2 on p.neumonia = sino2.clave 
			join tipos_paciente tp on p.tipo_paciente = tp.clave_tipo
			where pn.nom_pais like concat('%',nacionalidad,'%') 
					and pn.nom_pais = po.nom_pais 
			order by 2;
		ELSEIF criterio = '!' THEN
			select 
				e.id_paciente,
				p.sexo,
				p.edad,
				pn.nom_pais as 'pais_nacionalidad',
				po.nom_pais as 'pais_origen',
				p.fecha_sintomas,
				p.fecha_ingreso,
				d.fecha_defuncion,
				sino.descripcion as '¿Fue intubado?',
				sino2.descripcion as '¿Tuvo neumonia?',
				tp.nom_tipo as 'Tipo de paciente',
				r.descripcion as 'Prueba covid'
			from pacientes p 
			join extranjeros e using(id_paciente) 
			join defunciones d using(id_paciente) 
			join pais pn on e.pais_nacionalidad = pn.clave_pais
			join pais po on e.pais_origen = po.clave_pais 
			join resultado r using(clave_resultado) 
			join cat_sino sino on p.intubado = sino.clave
			join cat_sino sino2 on p.neumonia = sino2.clave 
			join tipos_paciente tp on p.tipo_paciente = tp.clave_tipo
			where pn.nom_pais like CONCAT('%',nacionalidad,'%') 
					and pn.nom_pais <> po.nom_pais 
			order by 2;
		ELSE 
			select 'Opción no válida' as Error;
		END IF;
		
	END; $$
	
DELIMITER ;