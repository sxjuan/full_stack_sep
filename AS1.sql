--1. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter.

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product

--2. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are 0 for the column ListPrice

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice = 0

--3. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are rows that are NULL for the Color column.

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL

--4. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL

--5. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice > 0

--6. Generate a report that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.

SELECT 'Name: ' + p.Name + '; Color: ' + p.Color AS 'Report'
FROM Production.Product p
WHERE Color IS NOT NULL

--7. Write a query that generates the following result set from Production.Product

SELECT 'NAME: ' + p.Name + ' -- COLOR: ' + p.Color AS 'Name And Color'
FROM Production.Product p
WHERE Name LIKE '%crankarm%' OR Name LIKE '%chainring'

--8. Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500

SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500

--9. Write a query to retrieve the to the columns ProductID, Name and color from the Production.Product table restricted to the colors black and blue

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color = 'black' or Color = 'blue'

--10. Write a query to generate a report on products that begins with the letter S.

SELECT 'Name: ' + p.Name + '; Color: ' + p.Color AS 'Report'
FROM Production.Product p
WHERE p.Name LIKE 's%' AND Color IS NOT NULL

--11. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column.

SELECT Name, ListPrice 
FROM Production.Product
WHERE Name LIKE 'S%'
ORDER BY Name ASC

--12. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'

SELECT Name, ListPrice 
FROM Production.Product
WHERE Name LIKE 'S%' OR Name LIKE 'A%'
ORDER BY Name ASC

--13. Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.

SELECT Name, ListPrice 
FROM Production.Product
WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%'
ORDER BY Name ASC

--14. Write a query that retrieves unique colors from the table Production.Product. Order the results in descending manner

SELECT DISTINCT Color
FROM Production.Product
ORDER BY Color DESC

--15. Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.

SELECT DISTINCT Color, ProductSubcategoryID
FROM Production.Product
WHERE Color IS NOT NULL AND ProductSubcategoryID IS NOT NULL

--16. Something is “wrong” with the WHERE clause in the following query. We do not want any Red or Black products from any SubCategory than those with the value of 1 in column ProductSubCategoryID, unless they cost between 1000 and 2000.

SELECT ProductSubCategoryID, 
	LEFT([Name],35) AS [Name],
	Color, ListPrice
FROM Production.Product
WHERE Color NOT IN ('Red','Black')	
	AND ProductSubcategoryID = 1
	OR ListPrice BETWEEN 1000 AND 2000
ORDER BY ProductID

--17. Write the query in the editor and execute it. Take a look at the result set and then adjust the query so it delivers the following result set.

SELECT ProductSubCategoryID, 
	LEFT([Name],35) AS [Name],
	Color, ListPrice
FROM Production.Product
WHERE (Color IN ('Red', 'Silver', 'Yellow')
	AND ProductSubcategoryID <= 14
	AND ListPrice BETWEEN 1000 AND 2000)
	OR (Color IN ('Black') AND ListPrice BETWEEN 500 AND 2000)
ORDER BY ProductSubCategoryID DESC