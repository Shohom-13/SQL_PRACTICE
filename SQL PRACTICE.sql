CREATE DATABASE shopdb;
USE shopdb;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers VALUES
(1, 'Alice', 'alice@gmail.com'),
(2, 'Bob', 'bob@gmail.com'),
(3, 'Charlie', 'charlie@gmail.com');
INSERT INTO Products VALUES
(101, 'Laptop', 60000),
(102, 'Phone', 20000),
(103, 'Headphones', 1500);
INSERT INTO Orders VALUES
(1001, 1, 101, 1, '2025-08-01'),
(1002, 2, 102, 2, '2025-08-03'),
(1003, 1, 103, 3, '2025-08-05'),
(1004, 3, 102, 1, '2025-08-06');
SELECT * FROM Customers;
SELECT * FROM Products
WHERE price > 5000;
SELECT o.order_id, c.name AS customer, p.product_name, o.quantity, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;
SELECT product_id, SUM(quantity) AS total_quantity
FROM Orders
GROUP BY product_id;
SELECT name FROM Customers
WHERE customer_id IN (
    SELECT customer_id FROM Orders
    WHERE product_id = (SELECT product_id FROM Products ORDER BY price DESC LIMIT 1)
);
CREATE VIEW OrderSummary AS
SELECT o.order_id, c.name AS customer, p.product_name, o.quantity, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;
CREATE INDEX idx_order_date ON Orders(order_date);
SHOW INDEXES FROM Orders;




