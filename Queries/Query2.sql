-- Query 2

-- Estado de nacimiento, estado de residencia, municipio y edad de las mujeres embarazadas que murieron por COVID 19 y que
-- no vivían en su estado de nacimiento

select edo2.nom_estado as 'Estado de Nacimiento', 
		edo.nom_estado as 'Estado de Residencia', 
		mun.nom_mun AS 'Municipio', 
		p.edad AS 'Edad'
from pacientes as p 
inner join defunciones as d using(id_paciente) 
inner join embarazos as e using(id_paciente) 
inner join mexicanos as m using(id_paciente) 
inner join municipios as mun on m.edomun_resi = mun.edo_mun 
inner join estados as edo using(clave_edo) 
inner join estados as edo2 on m.edo_nacim = edo2.clave_edo 
where p.clave_resultado = 1 
		and m.edo_nacim <> edo.clave_edo 
order by 1, 4;