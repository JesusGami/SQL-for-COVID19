-- Query 4

-- Id del paciente, edad, entidad federativa de la unidad médica, país de nacionalidad, país de origen, condición de migración
-- y resultado de la prueba de COVID, de las extranjeras que están embarazadas, ordenado por estado y nacionalidad.

select p.id_paciente, 
		p.edad as Edad, 
		edo.nom_estado as 'Entidad de la Unidad Médica', 
		ps.nom_pais as Nacionalidad, 
		ps2.nom_pais as 'Pais de origen', 
		case 
			when e.migrante = 1 then 'Si' 
			when e.migrante = 2 then 'No' 
			when e.migrante = 99 then 'No especificado' 
			end as 'Es migrante', 
		r.descripcion as 'Prueba COVID' 
from pacientes as p 
inner join embarazos as em using (id_paciente) 
inner join extranjeros as e using (id_paciente) 
inner join estados as edo on p.edo_um = edo.clave_edo 
inner join pais as ps on e.pais_nacionalidad = ps.clave_pais 
inner join pais as ps2 on e.pais_origen = ps2.clave_pais 
inner join resultado as r using(clave_resultado) 
order by 3,4;