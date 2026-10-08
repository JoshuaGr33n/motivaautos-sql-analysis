/* =====================================================================
   MotivaAutos: Sales and Customer Analysis
   File    : sql_fundamentals.sql
   Purpose : SQL fundamentals practised on the MotivaAutos database -
             SELECT, DISTINCT, COUNT, WHERE, ORDER BY, LIMIT, BETWEEN,
             IN, LIKE/ILIKE, aliases, arithmetic and aggregate functions.
   Database: PostgreSQL (motiva_autos)
   Author  : Joshua Oleru
   ===================================================================== */


-- View cars table
SELECT * FROM cars;

-- View customers table
SELECT * FROM customers;

-- View orders table
SELECT * FROM orders;

-- Return car_model and unit_price from cars table
SELECT car_model, unit_price 
FROM cars;


-- DISTINCT CLAUSE

-- Return distinct cities where customers reside
SELECT DISTINCT city FROM customers;

-- Return all car colours from car table
SELECT DISTINCT car_color FROM cars;


-- COUNT
-- Count all orders
SELECT COUNT(order_id) FROM orders;

-- Count all customers
SELECT COUNT(customer_id) FROM customers;

-- Count all cars
SELECT COUNT(car_id) FROM cars;


-- COUNT DISTINCT

-- Count the cities customers are in
SELECT COUNT(DISTINCT city) FROM customers;


-- Count the distinct car colours
SELECT COUNT(DISTINCT car_color) FROM cars;


-- WHERE CLAUSE

-- Retrieve only customers from a specified city
SELECT * FROM customers WHERE city = 'San Diego';

-- Retrieve only cars above a specified price
SELECT * FROM cars WHERE unit_price > 30000;


-- WHERE(AND/OR)
-- Return Mercedes-Benz cars priced above 50,000
SELECT * FROM cars WHERE car_brand = 'Mercedes-Benz' AND unit_price > 50000;

-- Return cars that are Mercedes-Benz or priced above 50,000
SELECT * FROM cars WHERE car_brand = 'Mercedes-Benz' OR unit_price > 50000;



-- ORDER BY CLAUSE

-- Arrange first names alphabetically
SELECT * FROM customers ORDER BY first_name ASC;

-- List the cars from most expensive to least expensive
SELECT * FROM cars ORDER BY unit_price DESC;


-- LIMIT

-- Retrieve the first 5 customers alphabetically by first name
SELECT * FROM customers ORDER BY first_name ASC LIMIT 5;

-- Retrieve the 5 most expensive cars
SELECT * FROM cars ORDER BY unit_price DESC LIMIT 5;


-- BETWEEN
-- Retrieve customers aged between 25 and 35
SELECT * FROM customers WHERE age BETWEEN 25 AND 35;

-- Retrieve cars priced between 40,000 and 50,000
SELECT * FROM cars WHERE unit_price BETWEEN 40000 AND 50000;

-- IN CLAUSE

-- Retrieve customers in Chicago, Austin, and Boston
SELECT * FROM customers WHERE city IN('Chicago', 'Austin', 'Boston');

-- Retrieve orders with IDs 1, 4, and 17
SELECT * FROM orders WHERE order_id IN(1, 4, 17);


-- LIKE and ILIKE

-- Retrieve customers with first names which begins with 'A'
SELECT * FROM customers WHERE first_name LIKE 'A%'; -- LIKE is case-sensitive
SELECT * FROM customers WHERE first_name ILIKE 'a%'; -- ILIKE is case-insensitive
SELECT * FROM customers WHERE first_name ILIKE '%e'; -- first names ending with 'e'

-- Retrieve cars whose brand contains 'oyo'
SELECT * FROM cars WHERE car_brand LIKE '%oyo%';


-- AS CLAUSE (Aliases)

SELECT first_name AS customer_name FROM customers; -- rename the output column


-- BASIC ARITHMETIC OPERATIONS IN SQL

-- Management wants to increase the price of all cars by 20%
-- Return car model, current price and updated price
SELECT 
	car_model, 
	unit_price,
	unit_price * 1.2 AS updated_price
FROM cars;


-- AGGREGATE FUNCTIONS

-- SUM FUNCTION
-- Calculate the total revenue generated
SELECT SUM(sales_amount) AS total_revenue FROM orders;

-- COUNT FUNCTION
-- Total orders received so far
SELECT COUNT(DISTINCT order_id) AS total_orders FROM orders;

-- AVG FUNCTION
-- Average customer age
SELECT ROUND(AVG(age)) AS average_age FROM customers;
-- Average revenue
SELECT ROUND(AVG(sales_amount), 2) AS average_sales FROM orders;

-- MAX FUNCTION
-- Find the most expensive car
SELECT MAX(unit_price) AS max_price FROM cars;

-- MIN FUNCTION
-- Find the least expensive car
SELECT MIN(unit_price) AS min_price FROM cars;
