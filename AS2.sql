--1. How many products can you find in the Production.Product table?

SELECT COUNT(*)
FROM Production.Product

--2. Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.

SELECT COUNT(*) AS 'CountedProducts'
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

--3. How many Products reside in each SubCategory? Write a query to display the results with the following titles.

SELECT ProductSubcategoryID, COUNT(*) AS 'CountedProducts'
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID

--4. How many products that do not have a product subcategory.

SELECT COUNT(*) 'CountedProducts'
FROM Production.Product
WHERE ProductSubcategoryID IS NULL

--5. Write a query to list the summary of products quantity in the Production.ProductInventory table.

SELECT ProductID, Quantity
FROM Production.ProductInventory

--6. Write a query to list the summary of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.

SELECT ProductID, SUM(Quantity) AS 'TheSum'
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) <100

--7. Write a query to list the summary of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100

SELECT ProductID, Shelf, SUM(Quantity) AS 'TheSum'
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID, Shelf
HAVING SUM(Quantity) <100

--8. Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.

SELECT AVG(Quantity) AS 'TheAvg'
FROM Production.ProductInventory
WHERE LocationID = 10

--9. Write query to see the average quantity of products by shelf from the table Production.ProductInventory

SELECT ProductID, Shelf, AVG(Quantity) AS 'TheAvg'
FROM Production.ProductInventory
GROUP BY ProductID, Shelf

--10. Write query to see the average quantity of products by shelf excluding rows that has  the value of N/A in the column Shelf from the table Production.ProductInventory 

SELECT ProductID, Shelf, AVG(Quantity) AS 'TheAvg'
FROM Production.ProductInventory
WHERE LocationID = 10 AND Shelf <> 'N/A'
GROUP BY ProductID, Shelf

--11. List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.

SELECT Color, Class, COUNT(*) AS 'TheCount', AVG(ListPrice) AS 'AvgPrice'
FROM Production.Product
WHERE Class IS NOT NULL AND Color IS NOT NULL
GROUP BY Color, Class

--12. Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.

SELECT DISTINCT c.Name as Country, s.Name as Province
FROM Person.StateProvince s
INNER JOIN Person.CountryRegion c
ON s.CountryRegionCode = c.CountryRegionCode

--13. Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.

SELECT DISTINCT c.Name as Country, s.Name as Province
FROM Person.StateProvince s
INNER JOIN Person.CountryRegion c
ON s.CountryRegionCode = c.CountryRegionCode
WHERE c.Name = 'Germany' OR c.Name = 'Canada'

--14. List all Products that has been sold at least once in last 25 years.

SELECT DISTINCT p.ProductName
FROM Products p 
INNER JOIN [Order Details] o
ON p.ProductID = o.ProductID
INNER JOIN Orders r
ON o.OrderID = r.OrderID
WHERE r.OrderDate BETWEEN '1996-11-11' AND '2021-11-11'

--15. List top 5 locations (Zip Code) where the products sold most.

SELECT top 5 ShipPostalCode 
FROM Orders
WHERE ShipPostalCode IS NOT NULL
GROUP BY ShipPostalCode

--16. List top 5 locations (Zip Code) where the products sold most in last 20 years.

SELECT top 5 ShipPostalCode 
FROM Orders
WHERE OrderDate BETWEEN '2001-11-11' and '2021-11-11'
GROUP BY ShipPostalCode

--17. List all city names and number of customers in that city.

SELECT City, COUNT(ContactName) AS 'CustomerCount'
FROM Customers
GROUP BY City

--18. List city names which have more than 10 customers, and number of customers in that city

SELECT City, COUNT(ContactName) as 'CustomerCount'
FROM Customers
GROUP BY City
HAVING COUNT(ContactName) > 10

--19. List the names of customers who placed orders after 1/1/98 with order date.

SELECT DISTINCT c.ContactName 
FROM Orders o 
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE OrderDate between '1998-01-01' and '2021-11-11'

--20. List the names of all customers with most recent order dates

SELECT CustomerID, OrderDate 
FROM 
(SELECT DISTINCT CustomerID, OrderDate, 
	RANK() OVER 
	(PARTITION BY CustomerID ORDER BY orderDate DESC) rank 
FROM Orders) ag
WHERE ag.rank = 1

--21. Display the names of all customers along with the count of products they bought.

SELECT DISTINCT c.ContactName, COUNT(c.ContactName)
FROM Orders o 
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.ContactName


--22. Display the customer ids who bought more than 100 Products with count of products.

SELECT c.ContactName, SUM(r.Quantity) AS 'Sum'
FROM Orders o 
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] r
ON r.OrderID = o.OrderID
GROUP BY c.ContactName
HAVING SUM(r.Quantity) > 100


--23. List all of the possible ways that suppliers can ship their products. Display the results as below

SELECT su.CompanyName AS 'Supplier Company Name', sh.CompanyName AS 'Shipping Company Name'
FROM Suppliers su, Shippers sh


--24. Display the products order each day. Show Order date and Product Name.

SELECT DISTINCT r.OrderDate, p.ProductName
FROM Products p 
INNER JOIN [Order Details] o
ON p.ProductID = o.ProductID
INNER JOIN Orders r
on r.OrderID = o.OrderID

--25. Displays pairs of employees who have the same job title.

SELECT * 
FROM Employees e 
INNER JOIN Employees m
ON e.Title = m.Title

--26. Display all the Managers who have more than 2 employees reporting to them.

SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees e
INNER JOIN Employees m
ON e.EmployeeID = m.ReportsTo
WHERE e.Title like '%manager%'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(m.ReportsTo) > 2

--27. Display the customers and suppliers by city. The results should have the following columns

SELECT city AS 'City Name', ContactName AS 'Contact Name', 'Customer' AS 'Type'
FROM Customers
UNION
SELECT city, ContactName, 'Supplier' AS Type 
FROM Suppliers

--28. Please write a query to inner join these two tables and write down the result of this query.

SELECT * 
FROM F1
INNER JOIN
F2 ON F1.T1 = F2.T2

/*
Results: 
2	2
3	3
*/

--29. Based on above two table, Please write a query to left outer join these two tables and write down the result of this query.

SELECT * 
FROM F1
LEFT JOIN
F2 ON F1.T1 = F2.T2

/*
Results: 
1	null
2	2
3	3
*/