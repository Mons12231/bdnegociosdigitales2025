--consultas de agregado 
--notas, solo devuelven un solo registro
-- sum, avg, count(no cuenta los null), count(*) (cuenta los registros), max y min

--primera consulta. CUANTOS CLIENTES TENGO 
select count(*) as 'numero de clientes' from Customers

--cuantas regiones hay 
select count(*) from Customers where region is null

select count( distinct region) 
from Customers 
where region is not null 
