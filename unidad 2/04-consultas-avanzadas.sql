use Northwind
--seleccionar todas las categorias y productos 
--ejemplo v1
select * from Categories
inner join
Products
on Categories.CategoryID = Products.CategoryID;
--ejemplo v2
select Categories.CategoryID,CategoryName, ProductName, UnitsInStock, UnitPrice from 
Categories
inner join
Products
on Categories.CategoryID = Products.CategoryID;
--ejemplo v3
select c.CategoryID as [numero de categoria],
CategoryName as 'nombre de categoria', 
ProductName as 'nombre de producto',
UnitsInStock as 'existencia', UnitPrice as Precio 
from 
Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID;

--seleccionar los productos de la categoria beverages y 
--condiments donde la existencia este entre 18 y 30 
select * from Categories as ca
inner join
Products as p
on p.CategoryID = ca.CategoryID
where ca.CategoryName in ('beverages', 'condiments')
and p.UnitsInStock  between  18 and 30;


select * from Categories as ca
inner join
Products as p
on p.CategoryID = ca.CategoryID
where (ca.CategoryName =  'beverages' or ca.CategoryName = 'condiments')
and (p.UnitsInStock >= 18 and p.UnitsInStock<=30)

--seleccionar los productos y sus importes realizados de marzo a junio de 
-- 1996, mostrando la fecha de la orden, el id del producto y el importe 
select o.OrderID, o.OrderDate, od.ProductID, 
(od.UnitPrice * od.Quantity) as importe 
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-01-07' and '1996-31-10'

select GETDATE()

--mostrar el importe total de ventas de la consulta anterior 
select concat ('$','    ',sum(od.Quantity * od.UnitPrice)) as importe 
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-01-07' and '1996-31-10'


