select c.categoriaid, c.nombre, p.categoriaid,p.productoid, p.nombre
from Categorias as c 
inner join Productos as p 
on p.categoriaid = c.categoriaid

select c.categoriaid, c.nombre, p.categoriaid,p.productoid, p.nombre
from Categorias as c 
left join Productos as p 
on p.categoriaid = c.categoriaid


select c.categoriaid, c.nombre, p.categoriaid,p.productoid, p.nombre
from Productos as p 
left join Categorias as c
on p.categoriaid = c.categoriaid