/*

3. Id del paciente, sexo, edad, fecha de síntomas, fecha de ingreso, días transcurridos, entidad de la unidad médica, tipo de
paciente, si fue intubado, si tuvo neumonía y resultado de la prueba covid de los pacientes que más tardaron en ingresar al
hospital después de sentir síntomas.

Ejemplo: call tardanza();

*/

DROP PROCEDURE IF EXISTS tardanza;

DELIMITER $$

CREATE PROCEDURE tardanza()
	BEGIN
		select 
			id_paciente,
			sexo,
			edad,
			fecha_sintomas,
			fecha_ingreso,
			datediff(fecha_ingreso,fecha_sintomas) as 'Dias transcurridos',
			e.nom_estado as 'Entidad de la UM',
			tp.nom_tipo as 'Tipo de paciente',
			sino.descripcion as 'Fue intubado?',
			sino2.descripcion as 'Neumonia',
			r.descripcion as 'Diagnóstico'
		from pacientes p 
		join estados e on p.edo_um = e.clave_edo 
		join tipos_paciente tp on p.tipo_paciente = tp.clave_tipo
		join cat_sino sino on p.intubado = sino.clave
		join cat_sino sino2 on p.neumonia = sino2.clave 
		join resultado r using(clave_resultado)
		where datediff(fecha_ingreso,fecha_sintomas) = (select max(datediff(fecha_ingreso,fecha_sintomas)) 
														from pacientes 
														where clave_resultado = 2)
		union
		select 
			id_paciente,
			sexo,
			edad,
			fecha_sintomas,
			fecha_ingreso,
			datediff(fecha_ingreso,fecha_sintomas) as 'Dias transcurridos',
			e.nom_estado as 'Entidad de la UM',
			tp.nom_tipo as 'Tipo de paciente',
			sino.descripcion as 'Fue intubado?',
			sino2.descripcion as 'Neumonia',
			r.descripcion as 'Diagnóstico'
		from pacientes p 
		join estados e on p.edo_um = e.clave_edo 
		join tipos_paciente tp on p.tipo_paciente = tp.clave_tipo 
		join cat_sino sino on p.intubado = sino.clave
		join cat_sino sino2 on p.neumonia = sino2.clave
		join resultado r using(clave_resultado)
		where datediff(fecha_ingreso,fecha_sintomas) = (select max(datediff(fecha_ingreso,fecha_sintomas)) 
														from pacientes 
														where clave_resultado = 1)
		order by 2;
	END; $$
	
DELIMITER ;