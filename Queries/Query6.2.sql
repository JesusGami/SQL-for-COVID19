-- De los 5 estados con mayor número de habitantes ¿Cuál es el que tiene la menor cantidad de infectados?
-- En este ejercicio se puede usar limit para obtener los 5 estados con mayor número de habitantes,

-- OBSERVACIÓN: Usar dos opciones para la consulta:
-- Opción 1: No usar LIMIT y usar la función min() solo con la tabla mexicanos
-- Opción 2: Se permite usar LIMIT, si se usan las 2 tablas: mexicanos y extranjeros

select s1.nom_estado as Estado, 
		Lpad(format(s2.pob,0), length("Poblacion Total"), ' ') as 'Poblacion Total', 
		Lpad(format(s1.inf,0), length('Total de Infectados'), ' ') as 'Total de Infectados' 
		from (select e.clave_edo, 
						sum(m.pob_total) as pob 
				from estados as e 
				inner join municipios as m using(clave_edo) 
				group by e.clave_edo 
				order by 2 desc 
				limit 5) as s2 
		inner join (select clave_edo, 
								nom_estado, 
								sum(infectados) as inf 
						from (select e.clave_edo, 
										e.nom_estado,
										count(*) as infectados 
								from pacientes as p 
								inner join mexicanos as mex using(id_paciente) 
								inner join estados as e on e.clave_edo = left(mex.edomun_resi,2) 
								where p.clave_resultado = 1 
								group by  e.clave_edo, e.nom_estado 
								union 
								select e.clave_edo, 
										e.nom_estado,
										count(*) as infectados 
								from pacientes as p 
								inner join extranjeros as ex using(id_paciente) 
								inner join estados as e on e.clave_edo = left(ex.edomun_resi,2) 
								where p.clave_resultado = 1 
								group by  e.clave_edo, e.nom_estado) as s 
						group by clave_edo, nom_estado) as s1 using(clave_edo) 
		order by s1.inf asc 
		limit 1;
