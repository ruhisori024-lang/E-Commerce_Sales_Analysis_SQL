CREATE TABLE Customers (
CustomerID INT primary key identity(1,1),
firstname VARCHAR(50),
City VARCHAR(50),
JoinDate DATE
);


CREATE TABLE Products (
ProductID INT PRIMARY KEY IDENTITY (1,1),
ProductName VARCHAR(50),
Brand VARCHAR(50),
Price DECIMAL(10,2),
StockQuantity INT
);


CREATE table Orders (
OrderID INT PRIMARY KEY identity(1,1),
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID), 
OrderDate DATE,
TotalAmount Decimal(10,2)
);


CREATE table OrderItems (
OrderitemID INT PRIMARY KEY IDENTITY(1,1),
OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
Quantity INT,
UnitPrice Decimal(10,2),
);


INSERT INTO Customers (firstname, City, JoinDate)
VALUES ('Amit','Delhi','2026-01-15'),
('Priya','Mumbai','2026-04-24'),
('Rahul','Lucknow','2026-05-23'),
('Sneha','Lucknow','2026-05-26'),
('Pooja','Kirandul','2026-06-01');

INSERT INTO Products (ProductName,Brand,Price,StockQuantity) VALUES
('Oversized Hoodie','Zara',2999.00,120),
('Air Max Sneakers','Comet',8499.00,45),
('Wide Leg Jeans','H&M',3499.00,85),
('Denim Jackrt', 'H&M',4199.00,30);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1,'2026-08-10',11489.00),
(2, '2026-08-11',3499.00),
(3,'2026-08-12',16998.00);


INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1,1,1,2999.00),(1,2,1,8499.00),
(2,3,1,3499.000),
(3,2,2,8499.00);


SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderItems;


SELECT
p.Brand,
SUM(oi.Quantity*oi.UnitPrice) AS TotalRevenue, 
SUM(oi.Quantity) AS TotalUnitSold
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY p.Brand
Order BY TotalRevenue DESC;

ALTER VIEW v_VIPCustomerSpend AS
SELECT 
c.FirstName AS CustomerName, c.City,
SUM(o.TotalAmount) AS LifetimeSpend,
COUNT(o.OrderID) AS TotalOrdersPlaced
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
Group by c.FirstName,c.City;

SELECT * FROM v_VIPCustomerSpend ORDER BY LifetimeSpend DESC;

CREATE VIEW v_BrandSalesPerformance AS
SELECT
p.Brand,
SUM(oi.Quantity * oi.UnitPrice) AS TotalSalesRevenue,
SUM(oi.Quantity) AS TotalItemsSold
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY p.Brand;


SELECT * FROM v_VIPCustomerSpend 
ORDER BY LifetimeSpend DESC;

SELECT * FROM v_BrandSalesPerformance;