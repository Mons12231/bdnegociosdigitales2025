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


--consultas basicas con inner join 
---1. obtener los nombres de los clientes  y los paises a los que se 
--enviaron sus pedidos 
SELECT c.CompanyName, o.ShipCountry 
from Orders as  o
inner join Customers as c
on c.CustomerID = o.CustomerID
order by 2 desc 

---
SELECT c.CompanyName as 'nombre del cliente',
o.ShipCountry as 'pais de envio' 
from Orders as  o
inner join Customers as c
on c.CustomerID = o.CustomerID
order by o.ShipCountry desc 


--2. obtener los productos y sus respectivos proveedores
 select p.ProductName as 'nombre producto',
 s.CompanyName as 'nombre del provedor' 
 from
 Products as p
 inner join 
 Suppliers as s 
 on p.SupplierID = s.SupplierID
--3. obtener los pedidos y los empleados que los gestionaron
select o.OrderID,concat(e.Title,' - ', e.FirstName,'   ', e.LastName) as 'nombre'
from 
Orders as o 
inner join Employees as e 
on o.EmployeeID = e.EmployeeID



-- 4. listar los productos juntos con sus precios y la categoria a la que pertenecen 
select p.ProductName as 'nombredelproducto', p.UnitPrice as 'precios',c.CategoryName 
as'categoria' 
from 
Products as p 
inner join Categories as c
on c.CategoryID = c.CategoryID

---5. obtener el nombre del cliente, el numero de orden y la fecha de orden 
select o.OrderID as 'numero de orden',c.CompanyName as 'cliente',
o.OrderDate as 'fecha de orden'
from
Customers as c
inner join Orders as o 
on c.CustomerID = C.CustomerID

---6. listar las ordenes mostrando el numero de orden, el nombre del producto 
---y  la cantidad que se vendio
select top 5 od.OrderID as 'numero de orden', p.ProductName as 'producto', 
od.Quantity as 'cantidad vendida'
from 
[Order Details] as od
inner join Products as p 
on od.ProductID = p.ProductID
order by od.Quantity desc
---
select  od.OrderID as 'numero de orden', p.ProductName as 'producto', 
od.Quantity as 'cantidad vendida'
from 
[Order Details] as od
inner join Products as p 
on od.ProductID = p.ProductID
order by od.Quantity desc
--
select  od.OrderID as 'numero de orden', p.ProductName as 'producto', 
od.Quantity as 'cantidad vendida'
from 
[Order Details] as od
inner join Products as p 
on od.ProductID = p.ProductID
where od.OrderID = 11031
order by od.Quantity desc

--7. Obtener los empleados y sus respectivos jefes
select CONCAT(e1.FirstName,' ',e1.LastName) as [empleado],
concat(j1.FirstName,' ', j1.LastName) as [jefe]
from Employees as e1
inner join Employees as j1
on e1.ReportsTo = j1.EmployeeID


--8. listar los pedidos y el nombre de la empresa de transporte utilizada 
select o.OrderID, sh.CompanyName as [transportista]
from Orders as o 
inner join Shippers as sh 
on  o.ShipVia = sh.ShipperID

---CONSULTAS INNER JOIN INTERMEDIAS 
--9. obtener la cantidad total de productos vendidos por categoria 
select sum(Quantity) from [Order Details]

select c.CategoryName as 'nombre categoria',
sum(Quantity) as 'productos vendidos' 
from Categories as c
inner join Products as p 
on c.CategoryID = p.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName 

--10.obtener el total de ventas por empleado 
select concat( e.FirstName,' ',e.LastName) as Nombre,
sum((od.Quantity * od.UnitPrice) - (od.Quantity * od.UnitPrice) * od.Discount )
as Total
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details]  as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName


--11. Listar los clientes y la cantidad de pedidos que han realizado
select c.CompanyName as 'cliente',
count(*) as 'num pedidos'
from  Customers as c
inner join Orders as o 
on c.CustomerID = o.CustomerID
group by c.CompanyName
order by 'num pedidos' desc
--12. obtener los empleados que han gestionado pedidos enviados a alemania 
select distinct concat(e.FirstName, '  ', e.LastName) as 'nombre empleados ', o.ShipCountry
from Employees as e
inner join Orders as o 
on o.EmployeeID = e.EmployeeID
where o.ShipCountry = 'Germany'
--13. listar los productos junto con el nombre del proveedor y el pais de origen 
select s.CompanyName as 'proveedor', p.ProductName as 'nombreproducto',
s.Country as 'pais origen'
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID
order by p.ProductName desc
--14. obtener los pedidos agrupados por pais de envio 
select  o.ShipCountry [pais de envio],
count (o.OrderID) as [numero de ordenes] 
from Orders as o 
group by o.ShipCountry
order by 2 desc
--15. obtener los empleados y la cantidad de territorios en lo que trabajan
select concat(e.FirstName, '  ', e.LastName) as 'nombre empleados ',
count(et.TerritoryID) 
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
group by CONCAT(e.FirstName,'  ', e.LastName)
---
select concat(e.FirstName, '  ', e.LastName) as [nombre],
t.TerritoryDescription,
count(et.TerritoryID)  as [cantidad territorios]
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName, t.TerritoryDescription
order by [nombre], t.TerritoryDescription desc 

--16. listar las categorias y la cantidad de productos que contienen 
select c.CategoryName as [categoria], 
count(p.ProductID) as [cantidad productos]
from Categories as c
inner join Products as p 
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 2 desc 

--17. obtener la cantidad total de productos vendidos por proveedor 
select s.CompanyName as [proveedor], 
sum(od.Quantity) as [total de productos vendidos ]
from  Suppliers as s
inner join Products as p 
on s.SupplierID = p.SupplierID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
group by s.CompanyName
order by 2 desc
--18. obtener la cantidad de pedidos enviados por cada empresa de transporte 
 select o.OrderID  
 from Shippers as s
 inner join Orders as o 
 on s.ShipperID = o.OrderID

 --consultas avanzadas
--19.  obtener los clientes que han realizado pedidos con mas de un producto 