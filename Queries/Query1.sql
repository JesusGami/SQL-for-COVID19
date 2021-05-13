-- Query 1

--  Id del paciente, edad, fecha de síntomas, fecha de ingreso, estado, municipio de residencia y resultado de la prueba covid,
-- de las mujeres embarazadas que fueron hospitalizadas y cuyo municipio de residencia tiene alguna de las palabras: Cárdenas,
-- Zapata y Atotonilco, ordenado por resultado de la prueba y edad.

select p.id_paciente, 
			p.edad, 
			p.fecha_sintomas, 
			p.fecha_ingreso, 
			est.nom_estado as Estado, 
			m.nom_mun as Municipio, 
			r.descripcion as "Prueba COVID"
from pacientes AS p 
inner join embarazos AS e using(id_paciente)
inner join tipos_paciente as tp on p.tipo_paciente = tp.clave_tipo
inner join mexicanos AS mex using(id_paciente)
inner join municipios as m on mex.edomun_resi = m.edo_mun
inner join estados as est using(clave_edo)
inner join resultado as r using(clave_resultado)
where (m.nom_mun like '%Cardenas%' or m.nom_mun like '%Zapata%' or m.nom_mun like '%Atotonilco%')
		and tp.clave_tipo=2 
order by 7, 2