--1.a
INSERT INTO Region VALUES(5, 'Middle Earth')

--1.b
INSERT INTO Territories VALUES(11111,'Gondor', 5)

--1.c
INSERT INTO Employees(EmployeeID, LastName, FirstName, Territory)
VALUES(10,'King', 'Aragorn', 'Gondor')

--2.
BEGIN TRAN
UPDATE Territories SET TerritoryDescription='Arnor' 
WHERE TerritoryDescription='Gondor'

--3.
BEGIN TRAN
DELETE FROM Region 
WHERE RegionDescription='Middle Earth'
ROLLBACK

BEGIN TRAN
SELECT * FROM Region WITH(HOLDLOCK)
SELECT * FROM Employees WITH(HOLDLOCK)
SELECT * FROM Territories WITH(HOLDLOCK)
COMMIT TRAN

--4.
CREATE VIEW view_product_order_chen AS
SELECT p.ProductName, COUNT(od.Quantity) 'Quantity' from Products p 
INNER JOIN [Order Details] od
on p.ProductID = od.ProductID
GROUP BY p.ProductName

--5.

ALTER PROC sp_product_order_quantity_chen
(@id int,
@total int out)
AS
BEGIN
SELECT @id = view_product_quantity_order_Yang.ProductID,
@total = view_product_quantity_order_Yang.QuantityCount 
FROM view_product_quantity_order_chen
where view_product_quantity_order_chen.ProductID = @id
END

--6.
