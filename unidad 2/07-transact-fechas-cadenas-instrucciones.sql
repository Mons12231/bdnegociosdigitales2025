--funciones de cadena
--las funciones de cadena permite manipular tipos de datos como varchar, nvarchar, char,nchar

-- FUNCION LEN  -> devuelve la longitud de una cadena 

--declaracion de una variable 
declare @numero int;
set @numero = 10;
print @numero

declare @texto varchar(50) = 'hola, mundo!';

--obtener el tamaño de la cadena almacenada en la varible texto 
select len(@texto) as [Longitud]

--funcion left -> extrae un numero especifico de caracteres desde el inicio de la cadena 
select left(@texto,4) as Inicio 

--funcion right -> extrae un determinado numero de caracteres del final de la cadena 
select RIGHT(@texto,6) as Final 

select companyname, len(CompanyName) as 'Numero de caracteres',
left (CompanyName,4) as Inicio,
right (CompanyName,6) as Final,
substring (CompanyName,7,4) as 'Subcadena'
from Customers


--substring -> extrae una parte de la cadena, donde el segundo parametro es la posicion inicial
-- y tercer parametro del recorrido
select SUBSTRING(@texto,7,10)

declare @texto2 varchar(50) = 'hola, mundo!';

--replace -> reemplaza una subcadena por otra 
-- replace (string_expression, string_pattern, string_replacement)
select replace(@texto2, 'mundo', 'amigo')

-- CharIndex
declare @texto2 varchar(50) = 'hola, mundo!';
select CHARINDEX('Mundo',@texto2)

---upper -> convierte una cadena en mayusculas 
select Upper(@texto2) as Mayusculas 

declare @texto2 varchar(50) = 'hola, mundo!';
select concat (
               left(@texto2,5),
			   '  ',
			   upper(SUBSTRING(@texto2, 7, 5)),
			   RIGHT (@texto2,1)
			   ) as Textonuevo


update customers 
set CompanyName = upper (CompanyName)
where country in ('Mexico', 'Germany')

--trim -> quita espacios en blanco de una cadena
select trim('   test     ') as result;

declare @texto2 varchar(50) = '            hola, mundo!             ';
select trim (@texto2) as result;


select companyname, len(CompanyName) as 'numero de caracteres',
left (CompanyName,4) as inicio,
right (CompanyName,6) as final,
SUBSTRING (CompanyName,7,4) as 'subcadena'
from Customers 
go

