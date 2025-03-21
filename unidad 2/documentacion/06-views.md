# Views 
```sql 
/*create view nombreVista
as 
select columnas 
from tabla 
where condicion
*/
---crear la vista
use Northwind
go 
create view categorias_todas
as
select CategoryID, CategoryName, [Description], picture 
from Categories;
go 

select * from categorias_todas

drop view categorias_todas /* borrar la vista */


use Northwind
go
create or alter view categorias_todas
as
select CategoryID, CategoryName, [Description], picture 
from Categories
where CategoryName = 'Beverages'
go 



--crear una vista que permita visualizar solamente clientes de mexico y brazil 
go
create or alter view vistaClientesLatinos
as
select * from Customers
where Country in ('mexico', 'brazil')
go 



select distinct vcl.Country from 
Orders as o 
inner join vistaClientesLatinos as vcl 
on vcl.CustomerID = o.CustomerID

--crear una vista que contenga los datos de todas las ordenes, los productos,
--categorias de productos,empleados, clientes, en la orden calcular el importe 

create or alter view [dbo].[vistaordenescompra]
as
select o.OrderID as [numero de orden],o.OrderDate as [fecha de orden],
o.RequiredDate as [fecha de requisicion], concat(e.FirstName,' ', e.LastName)
as [nombre empleado], cu.CompanyName as [nombre del cliente], p.ProductName as [nombre producto],
c.CategoryName as [nombre categoria], od.UnitPrice as [precio de venta], od.Quantity as [cantidad vendida],
(od.Quantity * od. UnitPrice) as [importe ]
from
Categories as c  
inner join Products as p 
on c.CategoryID = p.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o 
on od.OrderID = o.OrderID
inner join Customers as cu 
on cu.CustomerID = o.CustomerID
inner join Employees as e 
on e.EmployeeID = o.EmployeeID


select count (distinct [numero orden]) as [numero de orden]
from vistaordenescompra

select sum([Cantidad Vendida] * [Precio de Venta]) as [Importe total]
from vistaordenescompra
go 

create or alter view vista_ordenes_1995_1996
as
select [Nombre del cliente] as 'nombre cliente',
sum(importe) as [Importe total]
from vistaordenescompra
where year([Fecha de Orden]) 
between '1995' and '1996'
group by [Nombre del cliente]
having count(*)>2
go 


create schema rh

create table rh.tablarh(
id int primary key, 
nombre nvarchar(50)
)
---vista horizontal
create or alter view rh.viewcategoriasproductos
as
select c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
from 
Categories as c 
inner join Products as p 
on c.CategoryID = p.CategoryID
GO

select * from rh.viewcategoriasproductos




```