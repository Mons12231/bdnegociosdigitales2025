# Store procedure 
```sql 
--crear un store procedure para seleccionar todos los clientes
create or alter procedure spu_mostrar_clientes 
as
begin
select * from Customers;
end
go

--ejecutar un store en transact 
exec spu_mostrar_clientes

--crear un sp que muestre los clientes por pais
--parametros de entrada

create or alter proc spu_customersporpais 

--parametros 
@pais nvarchar(15),
@pais2 nvarchar(15)
                --parametro de entrada
as 
begin

    select * from Customers
	where Country in(@pais, @pais2);
end;
-- fin del store

exec spu_customersporpais 'Brazil', 'germany'

---ejecuta un store procedure 
declare @p1 nvarchar(15) = 'spain';
declare @p2 nvarchar(15) = 'germany';
exec spu_customersporpais @p1, @p2;
go

--generar un reporte que permita visualizar los datos de compra de un determinado cliente,
--en un rango de fechas, mostrando, el monto total de compras por producto, mediante un sp 

create or alter proc spu_informe_ventas_clientes 
-- parametros 
@nombre nvarchar (40) = 'Berglunds snabbkop', -- parametro de entrada con valor por default 
@fechainicial DateTime,
@fechafinal DateTime
as
begin
select [nombre producto], sum (importe) as [monto total]
from vistaordenescompra 
where [Nombre del cliente] = @nombre
and [fecha de orden] between @fechainicial and @fechafinal
group by [nombre producto]
end;
go 


select * from Customers
select * from Orders
--ejecucion de un store con parametros de entrada
exec spu_informe_ventas_clientes
                             'Berglunds snabbkop',
							 '1996-02-02', '1997-01-01'
							
							
							
--ejecucion de un store procedure con paramaetros en diferentes posicion
exec spu_informe_ventas_clientes @fechafinal = '1997-01-01', @nombre = 'Berglunds snabbkop', @fechainicial = '1996-02-02';


--ejecucion de un store procedure con parametros de entrada con un campo que tiene un valor por default 
exec spu_informe_ventas_clientes @fechainicial = '1996-07-04', @fechafinal = '1997-01-01'

-- store procedure con parametro de salida 
go
create or alter proc spu_obtener_numero_clientes 
@customerid nchar(5), ---parametro de entrada 
@totalCustomers int output -- Parametro de salida
as
begin
     select @totalCustomers=count(*) from Customers
     where CustomerID= @customerid;
end;
go

declare @numero int;
exec spu_obtener_numero_clientes 'ANATR',
                                @totalCustomers = @numero output;
print @numero;
go 
select * from Customers


--crear un store procedure que permita saber si un almuno aprobo o reprobo 
go
create or alter proc spu_comparar_calificacion 
@calif decimal(10,2) --parametro de entrada
as
begin
     if @calif>=0 and @calif<=10
	 begin
	 if @calif>=8
	 print 'La calificacion es aprobatoria'
	 else 
	 print 'la califacion es reprobatoria'
end
else
print 'calificacion no valida'
end;
go


exec spu_comparar_calificacion @calif =7

exec spu_comparar_calificacion @calif =11

--crear un sp que permita verificar si un cliente existe antes de 
--devolver su informacion

create or alter proc spu_obtener_clientes_siexiste
@numeroCliente nchar(5) 
as
begin
if  exists(select 1 from Customers where CustomerID = @numeroCliente)
select * from Customers where CustomerID = @numeroCliente;
else 
print 'el cliente no existe'
end;
go

select * from Customers
select 1 from Customers where CustomerID = 'AROUT'

exec spu_obtener_clientes_siexiste @numeroCliente = 'Arout'


--crear un store procedure que permita insertar un cliente pero se debe verificar primero
--que no exista 

select * from Customers
create or alter  procedure spu_agregar_clientes 
@id nvarchar(1),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as
 begin
 if exists (select 1 from Customers where CustomerID = @id)
 begin 
     print ('el cliente ya existe')
     return 1
 end

     insert into customers (customerid,companyname)
     values (@id, @nombre);
     print ('cliente insertado exitosamente')
     return 0;

 end;
 go

 exec spu_agregar_clientes 'AIFKI', 'Patito de Hule'

 exec spu_agregar_clientes 'AIFKC', 'Patito de Hule'
 select * from Customers
 go

 create or alter procedure spu_agregar_cliente_try_catch
 @id nvarchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
AS
begin
     begin try 
	 insert into customers (customerid,companyname)
     values (@id, @nombre);
	 print('cliente insertado existosamente');
	 end try
	 begin catch 
	 print('el cliente ya existe')
	 end catch
end;
 exec spu_agregar_clientes 'AIFKC', 'Patito de Hule'
  exec spu_agregar_clientes 'AIFKD','Muñeca vieja'

  --imprimir el numero de veces que indique el usuario 
  create or alter procedure spu_imprimir
  @numero int
  as
  begin

  if @numero<=0
  begin
        print('el numero no puede ser 0 o negativo')
        return
  end

  declare @i int 
  set @i = 1
  while(@i<=@numero)
  begin
       print concat('numero' , @i )
	   set @i = @i +1
  end
  end;
  go
  exec spu_imprimir 10


```