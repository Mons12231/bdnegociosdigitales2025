use Northwind
go 
create or alter view info_vent_clientes
as 
select o.OrderID, o.OrderDate,concat(e.FirstName, '    ',e.LastName)
from Orders as o 
inner join Employees as e
on o.EmployeeID = e.EmployeeID;
go

select distinct 

drop view info_vent_clientes

select * from Orders
select * from Employees

use Northwind
go 
create or alter view informacion_productos
as 
select ProductName, UnitPrice,UnitsInStock, UnitsOnOrder
from Products;
go




go 
create or alter view informacion_cliente
as 
select CompanyName, Country 
from Customers;
go


select * from Products
select * from Customers

--STORE PROCEDURE 
use Northwind
create or alter procedure spu_actualizar_precio_predido 
@ProductID int, @NuevoPrecio money, @discontinued int, @cantidad int 
as 
 begin 
      if exists(Select 1 from products  where ProductID = @ProductID)
	  begin 
	  print 'el producto ya existe'
	  return 
end 
     if not exists (select 1 from Products where Discontinued = @discontinued) 
	 begin 
	 print 'los datos no son validos '
	 return 
end
     if @cantidad<= 0
	 begin
	 print 'la cantidad no puede ser 0 o negativo'
	end 
         begin try
   --actualizar el precio de un producto en la tabla products 
    insert into Products
	values (@ProductID,@NuevoPrecio,@discontinued,@cantidad);
	
	update Products
	set UnitPrice = UnitPrice - @cantidad;

	end try
	begin catch 
	print 'error al actualizar datos'
	return;
	end catch

end;

exec spu_Aspu_ActualizarPrecioProducto @ProductID = 113070, @NuevoPrecio = 9,
@discontinued = 0, @cantidad =20


if not exists (select 1 from Products where ProductID=20)
print ('OK')

select * from Products 
