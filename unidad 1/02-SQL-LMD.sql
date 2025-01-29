-- Lenguaje SQL LMD (insert, update, delete, select, - CRUD)
-- Consultas Simples 

use Northwind

-- Mostrar todos los clientes, provedores, categorias, productos, ordenes, detalle de la orden, empleados con las con las columnas de datos de la empresa 
select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details];

-- Proyeccion 
select ProductID, ProductName, UnitPrice, UnitsInStock from Products;

-- Mostrar el numero del empleado, primer nombre, cargo, ciudad, pais

select EmployeeID, FirstName, Title, City, Country from Employees;

-- Alias de columna
-- En base a la consulta anterior visualisar el employeeid como numero empleado, firstname como primer nombre, title como cargo, city como ciudad, country como pais

select EmployeeID as [Numero Empleado], FirstName as PrimerNombre, Title 'Cargo', City as Ciudad, Country as Pais from Employees

-- Campos calculados 
-- Seleccionar el importe de los productos vendididos en una orden 
select *,(UnitPrice * Quantity) as Importe from [Order Details]

-- Seleccionar las fechas de orden ano mes y dia, el cliente que lo ordeno y el empleado que lo realizo
select OrderDate as Fecha, year(OrderDate) as Ano, month(OrderDate) as Mes, day(OrderDate) as Dia, CustomerID, EmployeeID from Orders

-- filas duplicadas (Distinct, quitar campos repetidos )


--Mostrar los paises en donde se tiene clientes, mostrando pais solamente 
--(primero se ejecuta el from)
select  distinct Country  from Customers
order by country 

-- Clausula where 
-- Operadores relacionales o test de comparacion (<, >, <=, >=, != o <>)

select * from Customers
-- Seleccionar el cliente BOLID
select CustomerID as Clienteid, CompanyName as NombreEmpresa, City as Ciudad, Country as Pais from Customers where CustomerID = 'BOLID';

-- Seleccionar los clientes mostrando identificador, nombre de la empresa, contacto, ciudad, pais de alemania
select CustomerID as Clienteid, CompanyName as 'Nombre de la Empresa', Phone as Contacto, City as Ciudad, Country as Pais from Customers where Country = 'germany'

-- Seleccionar todos los clientes que no sean de alemania 
select CustomerID as Clienteid, CompanyName as 'Nombre de la Empresa', Phone as Contacto, City as Ciudad, Country as Pais from Customers where Country != 'germany'

-- Seleccionar todos los productos mostrando su nombre de producto, categoria, existencia, precio, solamente si su precio es mayor 100 y su costo de inventario
select ProductName as 'Nombre del Producto', CategoryID as Categoria, UnitsInStock as Existencia, UnitPrice as Precio, (UnitPrice * UnitsInStock) as 'Costo de Inventario' from Products where UnitPrice > 100

-- Seleccionar ordenes de compra mostrando la fecha de orden, entrega, envio, cliente al que se vendio de 1996
select OrderDate as 'Fecha de Orden', RequiredDate as Entrega, ShippedDate as Envio, CustomerID  from Orders where year(OrderDate) = 1996
select * from Orders

-- mostrar todas las ordenes de compra donde la cantidad
-- de productos comprados sea mayor a 5 
select * from [Order Details]
where Quantity >= 40 

-- mostrar el nombre completo del empleado, su numero de empleado,
-- fecha de nacimiento, cuidad y fecha de contratacion y esta 
-- debe ser de aquellos que fueron contratados despues de 1993 
--los resultados en sus encabezados deben ser mostrados en espanol 
select  EmployeeID as 'empleadoid',
FirstName as 'primer nombre',
LastName as 'apellido',
BirthDate as 'fecha de nacimiento', 
City as 'cuidad', HireDate as 'fecha de contratacion'
from Employees
where year(HireDate) >1993

--version 2
select  EmployeeID as 'empleadoid',
(FirstName +  '      ' + LastName) as 'Nombre completo',
BirthDate as 'fecha de nacimiento', 
City as 'cuidad', HireDate as 'fecha de contratacion'
from Employees
where year(HireDate) >1993

--version 3
select  EmployeeID as 'empleadoid',
Concat(FirstName, '   ',LastName) as 'nombre completo',
BirthDate as 'fecha de nacimiento', 
City as 'cuidad', HireDate as 'fecha de contratacion'
from Employees
where year(HireDate) >1993

--Mostrar los empleados que no son dirigidos por el jefe Fuller Andrew
select EmployeeID as 'empleadoid',
Concat(FirstName, '   ',LastName) as 'nombre completo',
BirthDate as 'fecha de nacimiento', 
City as 'cuidad', HireDate as 'fecha de contratacion', ReportsTo as 'Jefe'
from Employees
where ReportsTo <>2


-- SELECCIONAR LOS EMPLEADOS QUE NO TENGAN JEFE
SELECT * FROM Employees
WHERE ReportsTo is null