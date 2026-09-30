-- Day 5: Business Questions and SQL Queries
-- Database: SQLite
-- Dataset: orders.csv imported into table: orders

-- 1. How many transactions are recorded in the orders dataset?
SELECT COUNT(*) AS transaction_count
FROM orders;

-- 2. What is the total revenue generated?
SELECT ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM orders;

-- 3. What is the average order value?
SELECT ROUND(AVG(Quantity * UnitPrice), 2) AS average_order_value
FROM orders;

-- 4. What is the monthly revenue?
SELECT
    strftime('%Y-%m', OrderDate) AS month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS monthly_revenue
FROM orders
GROUP BY strftime('%Y-%m', OrderDate)
ORDER BY month;

-- 5. How much revenue did each salesperson generate?
SELECT
    SalesPerson,
    COUNT(*) AS transactions,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM orders
GROUP BY SalesPerson
ORDER BY revenue DESC;

-- 6. What are the top 5 product IDs by revenue?
SELECT
    ProductID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM orders
GROUP BY ProductID
ORDER BY revenue DESC
LIMIT 5;

-- 7. Which month had the highest number of transactions?
SELECT
    strftime('%Y-%m', OrderDate) AS month,
    COUNT(*) AS transaction_count
FROM orders
GROUP BY strftime('%Y-%m', OrderDate)
ORDER BY transaction_count DESC
LIMIT 1;

-- 8. How much revenue came from each payment method?
SELECT
    PaymentMethod,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM orders
GROUP BY PaymentMethod
ORDER BY revenue DESC;

-- 9. Which customers generated the most revenue?
SELECT
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM orders
GROUP BY CustomerID
ORDER BY revenue DESC
LIMIT 10;

-- 10. Which products sold the most units?
SELECT
    ProductID,
    SUM(Quantity) AS units_sold
FROM orders
GROUP BY ProductID
ORDER BY units_sold DESC
LIMIT 10;

-- 11. What are the 10 highest-value individual transactions?
SELECT
    OrderID,
    OrderDate,
    CustomerID,
    ProductID,
    Quantity,
    UnitPrice,
    ROUND(Quantity * UnitPrice, 2) AS order_value
FROM orders
ORDER BY order_value DESC
LIMIT 10;

-- 12. Which day generated the highest revenue?
SELECT
    OrderDate,
    ROUND(SUM(Quantity * UnitPrice), 2) AS daily_revenue
FROM orders
GROUP BY OrderDate
ORDER BY daily_revenue DESC
LIMIT 1;

-- 13. How many total units were sold?
SELECT
    SUM(Quantity) AS total_units_sold
FROM orders;

-- 14. What is the average quantity purchased per transaction?
SELECT
    ROUND(AVG(Quantity), 2) AS average_quantity_per_transaction
FROM orders;

-- 15. How many transactions were made using each payment method?
SELECT
    PaymentMethod,
    COUNT(*) AS transaction_count
FROM orders
GROUP BY PaymentMethod
ORDER BY transaction_count DESC;

-- 16. How many unique customers and products are in the dataset?
SELECT
    COUNT(DISTINCT CustomerID) AS unique_customers,
    COUNT(DISTINCT ProductID) AS unique_products
FROM orders;

-- 17. How many transactions did each salesperson handle?
SELECT
    SalesPerson,
    COUNT(*) AS transaction_count
FROM orders
GROUP BY SalesPerson
ORDER BY transaction_count DESC;

-- 18. How many transactions occurred on each day?
SELECT
    OrderDate,
    COUNT(*) AS transaction_count
FROM orders
GROUP BY OrderDate
ORDER BY OrderDate;

-- 19. What percentage of total revenue came from each product?
SELECT
    ProductID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS product_revenue,
    ROUND(
        100.0 * SUM(Quantity * UnitPrice) /
        (SELECT SUM(Quantity * UnitPrice) FROM orders),
        2
    ) AS revenue_percentage
FROM orders
GROUP BY ProductID
ORDER BY product_revenue DESC;
