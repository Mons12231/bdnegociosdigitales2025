``` sql
select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName 
from Categories as c
inner join Products as p 
on c.CategoryID = p.CategoryID
where c.CategoryName = 'Fast Fodd'

select * from Categories


select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName 
from Categories as c
left join Products as p 
on c.CategoryID = p.CategoryID
where p.CategoryID is null


select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName 
from Products as p
left join Categories as c 
on c.CategoryID = p.CategoryID


insert into Products (ProductName,SupplierID,CategoryID,QuantityPerUnit, UnitPrice, UnitsInStock,
UnitsOnOrder,ReorderLevel, Discontinued)
VALUES('Hamburguesa sabrosa',1,9, 'xyz',68.7,45,12,2,0)

insert into Products (ProductName,SupplierID,CategoryID,QuantityPerUnit, UnitPrice, UnitsInStock,
UnitsOnOrder,ReorderLevel, Discontinued)
VALUES('Guaracha sabrosona',1,null, 'xyz',68.7,45,12,2,0)


delete Products
where CategoryID = 9 
```