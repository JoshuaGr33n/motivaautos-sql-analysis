/* =====================================================================
   MotivaAutos: Sales and Customer Analysis
   File    : case_study_1.sql
   Purpose : Case Study 1 - customers, car performance, high-value
             customers and the most expensive car sold.
   Database: PostgreSQL (motiva_autos)
   Author  : Joshua Oleru
   ===================================================================== */


-- ---------------------------------------------------------------------
-- Q1. Provide the full name, email address and total orders for
--     customers who have placed an order.
--     Grouped by customer_id: two separate customer records share the
--     same name and email, so grouping by name would merge them.
-- ---------------------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.email,
    COUNT(o.order_id)                  AS total_orders
FROM customers c
INNER JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_orders DESC, full_name;


-- ---------------------------------------------------------------------
-- Q2. Retrieve the cars that have been ordered, with their revenue and
--     units sold.
-- ---------------------------------------------------------------------
SELECT
    cr.car_id,
    cr.car_brand,
    cr.car_model,
    SUM(o.sales_amount)  AS total_revenue,
    SUM(o.quantity_sold) AS total_units_sold
FROM cars cr
INNER JOIN orders o
    ON o.car_id = cr.car_id
GROUP BY cr.car_id, cr.car_brand, cr.car_model
ORDER BY total_revenue DESC;


-- ---------------------------------------------------------------------
-- Q3. Find the customers who have spent more than the average sales
--     revenue across all orders.
--     Benchmark: the average value of a single order.
-- ---------------------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.email,
    SUM(o.sales_amount)                AS total_spent
FROM customers c
INNER JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING SUM(o.sales_amount) > (SELECT AVG(sales_amount) FROM orders)
ORDER BY total_spent DESC;


-- ---------------------------------------------------------------------
-- Q4. Retrieve the most expensive car sold, by unit price.
--     Restricted to cars that appear in orders: the highest-priced car
--     in the showroom (Cadillac Escalade) has never been sold.
-- ---------------------------------------------------------------------
SELECT
    car_id,
    car_brand,
    car_model,
    car_color,
    unit_price
FROM cars
WHERE car_id IN (SELECT car_id FROM orders)
  AND unit_price = (
        SELECT MAX(unit_price)
        FROM cars
        WHERE car_id IN (SELECT car_id FROM orders)
      );
