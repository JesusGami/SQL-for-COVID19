-- Query5

-- Clave, nombre y cantidad del sector que tiene el máximo de casos positivos. 

-- OBSERVACIÓN: No se puede usar limit, ni valores estáticos, ni order by, 
-- debe resolverse con funciones de agregación y consultas anidadas.

select s.clave_sector, 
		s.nom_sector as Sector, 
		format(count(*),0) as Total 
from pacientes as p 
inner join sector as s using(clave_sector) 
inner join resultado as r using(clave_resultado) 
where p.clave_resultado = 1 
group by s.clave_sector, s.nom_sector 
having count(*) = (select max(total) 
							from (select count(*) as total 
									from pacientes as p 
									where p.clave_resultado = 1 
									group by p.clave_sector) as s
						);