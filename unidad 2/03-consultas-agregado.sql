--consultas de agregado 
--notas, solo devuelven un solo registro
-- sum, avg, count(no cuenta los null), count(*) (cuenta los registros), max y min

--primera consulta. CUANTOS CLIENTES TENGO 
select count(*) as 'numero de clientes' 
from Customers

--cuantas regiones hay 
select count(*) 
from Customers
where region is null

select count( distinct region) 
from Customers 
where region is not null 

select * from Orders
select count(*) from Orders
select count(ShipRegion) from Orders

 select * from Products
 --selecciona el precio mas bajo de los productos 
 select  min(UnitPrice) from Products

 --selecciona el precio max 
  select  min(UnitPrice), max (UnitPrice), avg (UnitsInStock)
  from Products;

  --seleccionar cuantos pedidos existen 
  select count(*)  as 'numero de pedidos' from Orders

  --calcula el total del dinero vendido 
  select sum(UnitPrice * Quantity) from [Order Details]
  select sum(UnitPrice * Quantity -(UnitPrice * Quantity * Discount)) as 'total ' from [Order Details]

  --calcula el total de unidades en stok de todos los productos
  select sum(UnitsInStock) as 'total de stock' from Products

  --seleccionar el total de dinero que se gano en el ultimo trimestre de 1996 
  select *  from [Order Details]
  select * from Orders

   -- group by, sirve para agrupar cosas 
   --seleccionar el numero de productos por categoria 
   select CategoryID, count (*)  as 'numero de productos 'from Products group by CategoryID

   select  p.CategoryID,count(*) from
   Categories as c 
   inner join Products as p 
   on c.CategoryID = p.CategoryID 
   group by p.CategoryID

    select  Categories.CategoryName,
	count(*)  as 'numero de productos'
	from
   Categories 
   inner join Products as p 
   on Categories.CategoryID = p.CategoryID 
   group by Categories.CategoryName

   ---calcular el precio promedio (avg) de los productos por cada categoria 
   select CategoryID, avg (UnitPrice) as 'precio promedio' from Products group by CategoryID

   --seleccionar el numero de pedidos realizados por cada empleado  por el ultimo trimestre de 1996
   select  EmployeeID, count(*)  as 'numero de pedidos '
   from Orders
   group by EmployeeID

   select EmployeeID,count(*) as 'numero de pedidos'
   from Orders
   where OrderDate between '1996-01-10' and '1996-31-12'
   group by EmployeeID
  
  --seleccionar la suma total de unidades vendidas por cada producto
   select ProductID,sum(Quantity) as 'numero de productos vendidos' 
   from [Order Details] 
   group by ProductID 
   order by 1 desc


   select OrderID,ProductID,sum(Quantity) as 'numero de productos vendidos' 
   from [Order Details] 
   group by  OrderID,ProductID 
   order by 2 desc
  
  --seleccionar el numero de productos por categoria pero solo aquellos que tengan mas de 10 productos 
  -- where (filtra filas) having (filtra grupos)
   select CategoryID, count(*)
   from Products
   where CategoryID in (1,3,4)
   group by CategoryID
   having sum(UnitPrice)>10;
   --paso 1
   select * from Products
   --select distinct CategoryID from Products
   --paso 2 
   select CategoryID, UnitsInStock from Products
   where CategoryID in (2,4,8)
   order by CategoryID
   --paso 3  agrupar 
   select CategoryID, sum(UnitsInStock) from Products
   where CategoryID in (2,4,8)
   group by CategoryID
   order by CategoryID
   --paso 4 
   select CategoryID, sum(UnitsInStock) 
   from Products
   where CategoryID in (2,4,8)
   group by CategoryID
   having count(*) >=12
   order by CategoryID

   --listar las ordenes agrupadas por empleados, pero que solo muestre aquellos 
   --que hayan gestionado mas de 10 pedidos
   select OrderID, count(*)
   from Orders
   