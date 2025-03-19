--realizar un pedido
--validar que el pedido no exista 
--validar que el cliente, el empleado y producto exista 
--validar que la cantidad a vender tenga sufiente stock 
--insertar el pedido y calcular el importe(multiplicando el precio de producto
--por la cantidad vendida)
--actualizar el stock del producto (restando el stock menos la cantidad vendida)
create or alter procedure spu_realizar_pedido
@numPedido int, @cliente int,
@repre int, @fab char(3),
@producto char(5), @cantidad int 
as
begin
    if exists (select 1 from Pedidos where Num_Pedido = @numPedido)
	begin 
	print 'el pedido ya existe'
	return
end

 if not exists (select 1 from Clientes where Num_Cli = @cliente) and
    not exists (select 1 from Representantes where Num_Empl = @repre) and 
	not exists (select 1 from Productos where ID_fab = @fab and Id_producto =@producto)
	
	begin
	print 'los datos no son validos'
	return
	end

end;
exec spu_realizar_pedido @numPedido = 113070, @cliente =2117,
@repre=111, @fab = 'REI',
@producto = '2A44L', @cantidad =20

exec spu_realizar_pedido @numPedido = 113070, @cliente =2117,
@repre=111, @fab = 'REI',
@producto = '2A44L', @cantidad =20


if not exists (select 1 from Clientes where Num_Cli =2000)
print ('OK')

select * from Pedidos