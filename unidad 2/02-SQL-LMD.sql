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

select EmployeeID as [Numero Empleado],
FirstName as PrimerNombre, 
Title 'Cargo', City as Ciudad, Country as Pais 
from Employees

-- Campos calculados 
-- Seleccionar el importe de los productos vendididos en una orden 
select *,(UnitPrice * Quantity) as Importe from [Order Details]

-- Seleccionar las fechas de orden ano mes y dia, el cliente que lo ordeno y el empleado que lo realizo
select OrderDate as Fecha, 
year(OrderDate) as Ano, month(OrderDate) as Mes, day(OrderDate) as Dia, CustomerID, EmployeeID 
from Orders

-- filas duplicadas (Distinct, quitar campos repetidos )


--Mostrar los paises en donde se tiene clientes, mostrando pais solamente 
--(primero se ejecuta el from)
select  distinct Country  from Customers
order by country 

-- Clausula where 
-- Operadores relacionales o test de comparacion (<, >, <=, >=, != o <>)

select * from Customers
-- Seleccionar el cliente BOLID
select CustomerID as Clienteid, 
CompanyName as NombreEmpresa,
City as Ciudad, Country as Pais 
from Customers
where CustomerID = 'BOLID';

-- Seleccionar los clientes mostrando identificador, nombre de la empresa, contacto, ciudad, pais de alemania
select CustomerID as Clienteid,
CompanyName as 'Nombre de la Empresa', 
Phone as Contacto, City as Ciudad, 
Country as Pais 
from Customers
where Country = 'germany'

-- Seleccionar todos los clientes que no sean de alemania 
select CustomerID as Clienteid,
CompanyName as 'Nombre de la Empresa', 
Phone as Contacto, City as Ciudad, 
Country as Pais
from Customers where Country != 'germany'

-- Seleccionar todos los productos mostrando su nombre de producto, categoria, existencia, precio, solamente si su precio es mayor 100 y su costo de inventario
select ProductName as 'Nombre del Producto', 
CategoryID as Categoria, UnitsInStock as Existencia,
UnitPrice as Precio, 
(UnitPrice * UnitsInStock) as 'Costo de Inventario' 
from Products where UnitPrice > 100

-- Seleccionar ordenes de compra mostrando la fecha de orden, entrega, envio, cliente al que se vendio de 1996
select OrderDate as 'Fecha de Orden',
RequiredDate as Entrega, ShippedDate as Envio, 
CustomerID 
from Orders 
where year(OrderDate) = 1996
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

-- operadores logicos (or, and y not)
-- seleccionar las productos que tengan un precio de entre 10 y 50 
select ProductName as 'nombre', UnitPrice as 'precio', UnitsInStock as 'existencia'
from Products
where UnitPrice >= 10 
and UnitPrice <= 50

-- mostrar todos los pedidos realizados por clientes que no son enviados a  alemania 
select * from Orders
where ShipCountry <> 'Germany'

select * from Orders
where  NOT ShipCountry = 'Germany'

--seleccionar clientes de mexico o estados unidos 
select * from Customers
where Country = 'mexico' or Country= 'usa'

--seleccionar  empleados que nacieron entre 1955 y 1958 
-- y que viven en londres 
select * from Employees
where year(BirthDate)>=1955 and year(BirthDate)<=1958 
and City = 'London'

--seleccionar los pedidos con fletes de peso (freight) mayor a 100 
-- y enviados a francia o espa�a
select OrderID, OrderDate, ShipCountry, Freight 
from Orders
where Freight>100 and (ShipCountry='France' or ShipCountry='Spain')

--seleccionar  ordenes de compra top cinco
select top 5 * from Orders
 
 -- seleccionar los productos con precio entre 10 y 50 
 --que no esten descontinuados y tengan mas de 20 unidades en stock 
 select ProductName,UnitPrice,UnitsInStock, Discontinued
 from Products
 where (UnitPrice >= 10 and UnitPrice <= 50) and UnitsInStock>20
 and Discontinued =0


--pedidos enviados a francia o alemania, pero con un flete menor a 50 
select OrderID, ShipCountry, Freight
from Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight <50

--clientes que no sean de mexico o usa y que tengan fax registrado
select CustomerID, Country, City, Fax, CompanyName
from Customers
where not(Country= 'Mexico' or Country= 'USA') and Fax is not null

select CustomerID, Country, City, Fax, CompanyName
from Customers
where (Country <>'Mexico' and Country<> 'USA') and Fax is not null

--