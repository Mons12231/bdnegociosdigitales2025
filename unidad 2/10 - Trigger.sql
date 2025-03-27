use BDEJEMPLO2;

--realizar un trigger que se dispare  cuando se inserte un pedido y modifique el stock 
--del producto vendido, verificar si hay suficiente stock si no se cancela 
-- el pedido 

select * from Pedidos


create or alter trigger tg_pedidos_insertar 
on pedidos 
after insert
As
begin
declare @existencia int 
declare @fab char (3)
declare @prod char (5)
declare @cantidad int 

select @fab = fab, @prod = producto, 
@cantidad = cantidad 
from inserted;

select @existencia = Stock from Productos
where Id_fab = @fab and Id_producto = @prod;

if @existencia > (select cantidad from inserted)
begin
     update Productos
	 set Stock = Stock - @cantidad
	 where Id_fab = @fab and Id_producto = @prod;
end 
else 
begin 
     raiserror ('no hay suficiente stock para el pedido', 16,1)
	 rollback;
end


end;

--executar el trigger 
declare @importe money 
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p 
inner join Productos as pr 
on p.Fab = pr.Id_fab


insert into	Pedidos(Num_Pedido, Fecha_Pedido, Cliente, Rep, Fab,Producto,Cantidad,Importe)
values (113071, getdate (), 2103,106, 'ACI', '41001', 77,@importe )

select * from Productos
where Id_fab = 'ACI'
and Id_producto = '41001'


select * from  Pedidos
where Num_Pedido = 113071

--crear un trigger que cada vez que se elimine un pedido, 
--se debe actualiza el stock de los productos con la cantidad eliminada 
create or alter trigger tg_eliminar_pedidos
on pedidos 
after delete
As
begin
declare @existencia int 
declare @fab char (3)
declare @prod char (5)
declare @cantidad int 

select @fab = fab, @prod = producto, 
@cantidad = cantidad 
from deleted;
 
select @existencia = Stock from Productos
where Id_fab = @fab and Id_producto = @prod;
 
if @existencia > (select cantidad from deleted)
begin
     update Productos
	 set Stock = Stock + @cantidad
	 where Id_fab = @fab and Id_producto = @prod;
end 
else 
begin 
     raiserror ('no hay suficiente stock para el pedido', 16,1)
	 rollback;
end


end;

--ejecutar el trigger 
select max (Num_Pedido) from Pedidos
declare @importe money 
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p 
inner join Productos as pr 
on p.Fab = pr.Id_fab


delete from Pedidos(Num_Pedido, Fecha_Pedido, Cliente, Rep, Fab,Producto,Cantidad,Importe)
values (113071, getdate (), 2103,106, 'ACI', '41001', 77,@importe )

select * from Productos
where Id_fab = 'ACI'
and Id_producto = '41001'


    
  

    
