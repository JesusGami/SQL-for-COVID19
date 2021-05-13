-- Query 3

-- Número de defunciones por estado de residencia que no tuvieron contacto con otro caso de covid y sin embargo se
-- contagiaron.

select nom_estado as 'Entidad Federativa', 
		lpad(format(sum(numero_defunciones),0), length('Total de Defunciones'), ' ') as 'Total de Defunciones'
from (
			(select e.nom_estado, 
					count(*) as numero_defunciones 
			from pacientes as p
			inner join defunciones as d using(id_paciente)
      	inner join mexicanos as m using(id_paciente)
         inner join municipios as mun on m.edomun_resi = mun.edo_mun
         inner join estados as e using(clave_edo)
        	where otro_caso = 2 
			  		and clave_resultado = 1 
			group by e.nom_estado order by 1)	
		UNION 
			(select e.nom_estado, 
					count(*) as numero_defunciones 
			from pacientes as p
         inner join defunciones as d using(id_paciente)
         inner join extranjeros as ext using(id_paciente)
         inner join municipios as mun on ext.edomun_resi = mun.edo_mun
        	inner join estados as e using(clave_edo)
        	where otro_caso = 2 
			  		and clave_resultado = 1 
			group by e.nom_estado order by 1) 
		) as s 
group by nom_estado 
order by 1;