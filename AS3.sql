--1. 

SELECT DISTINCT City
FROM Customers
WHERE City IN (SELECT City FROM Employees)

--2. 
--use sub-query

SELECT DISTINCT City
FROM Customers 
WHERE City NOT IN (SELECT City FROM Employees)

--no sub-query

SELECT DISTINCT City
FROM Customers c 
LEFT JOIN
Employees e
ON c.City != e.City

--3. 

SELECT DISTINCT ProductID, 
SUM(Quantity) OVER (PARTITION BY ProductID) AS "Total Quantity"
FROM [Order Details]

--4.

SELECT DISTINCT c.City,
SUM(od.Quantity) AS "Total Quantity"
FROM Customers c
LEFT JOIN
Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN
[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.City

--5a

SELECT c.City
FROM Customers c 
GROUP BY c.City 
HAVING COUNT(c.City) >= 2
UNION
SELECT s.City
FROM Customers s 
GROUP BY s.City 
HAVING COUNT(s.City) > 2

--5b

SELECT c.City 
FROM Customers c
WHERE c.City IN 
(SELECT s.City, Count(s.City) 
	FROM Customers s 
	GROUP BY s.City 
	HAVING Count(s.City) >= 2)

--6.

SELECT DISTINCT c.City
FROM Customers c
INNER JOIN
Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN
[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.City, od.ProductID
HAVING COUNT(od.ProductID) >= 2

--7.

SELECT o.CustomerID
FROM Orders o
WHERE o.ShipCity NOT IN
(SELECT c.City FROM Customers c)

--8.

--9a

SELECT e.City 
FROM Employees e
WHERE e.City 
NOT IN 
(SELECT o.ShipCity 
	FROM Orders o)

--9b

SELECT DISTINCT e.City
FROM Employees e
LEFT JOIN
Orders o
ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL

--10.

SELECT *
FROM
(SELECT TOP 1 e.City, COUNT(o.OrderID) AS "Most_Order" 
	FROM Employees e 
	INNER JOIN Orders o
	ON e.EmployeeID = o.EmployeeID
	GROUP BY e.City) T1
	LEFT JOIN 
	(SELECT TOP 1 c.City, COUNT(r.Quantity) AS "Most_Quantity" 
		FROM [Order Details] r 
		INNER JOIN
		Orders d on r.OrderID = d.OrderID
		INNER JOIN Customers c 
		ON c.CustomerID = d.CustomerID 
		GROUP BY c.City) T2
	ON T1.City = T2.City

--12.

SELECT empid, deptid
FROM Employee
WHERE mgrid = 0

--13.

SELECT T1.deptid, T1.Count_of_Employees
FROM 
(SELECT TOP 1
	FROM 
	(SELECT deptid, COUNT(empid)
	FROM Employee
	GROUP BY deptid
	ORDER BY COUNT(empid))) T1
	INNER JOIN
	(SELECT deptname, COUNT(*) AS "Employee_Count"
		FROM dept
		GROUP BY deptid
		) T2
	ON T1.deptid = T2.deptid

--14.
	
SELECT deptname, empid, salary
FROM 
(SELECT d.deptname, e.empid, e.salary, 
	RANK() OVER 
	(PARTITION BY e.deptid 
		ORDER BY
		e.salary DESC) AS rnk
FROM dept d, employee e
WHERE d.deptid = e.deptid)
WHERE rnk <= 3
ORDER BY deptname, rnk

--15. top 3 products from every city which were sold maxium

SELECT T2.ShipCity, T2.ProductID, T2.SumProductQuantity AS "Quantity"
FROM 
(SELECT T1.ShipCity, T1.ProductID, T1.SumProductQuantity,
	RANK() OVER (PARTITION BY T1.ShipCity ORDER BY T1.SumProductQuantity DESC) AS rnk
	FROM 
	(SELECT od.ProductID, o.ShipCity, SUM(od.Quantity) AS "SumProductQuantity"
		FROM Orders o
		INNER JOIN [Order Details] od
		ON o.OrderID = od.OrderID
		GROUP BY od.ProductID, o.ShipCity) T1) T2
WHERE rnk <= 3

--16. Create the table above (include the creation and insert script as part of the answer) As the result set, show every combination without duplicates.

CREATE TABLE City_Distance (
    City varchar(50),
    Distance int
);

INSERT INTO City_Distance (City, Distance)
VALUES ('A', 80)
INSERT INTO City_Distance (City, Distance)
VALUES ('B', 150)
INSERT INTO City_Distance (City, Distance)
VALUES ('C', 180)
INSERT INTO City_Distance (City, Distance)
VALUES ('D', 220)

SELECT 'B-A' AS "City", T3.d2-T3.d1 AS "Distance"
FROM 
(SELECT T1.Distance AS "d1", T2.Distance AS "d2" FROM (
(SELECT Distance
FROM 
City_Distance
WHERE City = 'A') T1 CROSS JOIN
(SELECT Distance
FROM 
City_Distance
WHERE City = 'B') T2) ) T3
UNION 
SELECT 'C-B' AS "City", T3.d2-T3.d1 AS "Distance"
FROM 
(SELECT T1.Distance AS "d1", T2.Distance AS "d2" FROM (
(SELECT Distance
FROM 
City_Distance
WHERE City = 'B') T1 CROSS JOIN
(SELECT Distance
FROM 
City_Distance
WHERE City = 'C') T2) ) T3
UNION 
SELECT 'D-C' AS "City", T3.d2-T3.d1 AS "Distance"
FROM 
(SELECT T1.Distance AS "d1", T2.Distance AS "d2" FROM (
(SELECT Distance
FROM 
City_Distance
WHERE City = 'C') T1 CROSS JOIN
(SELECT Distance
FROM 
City_Distance
WHERE City = 'D') T2) ) T3