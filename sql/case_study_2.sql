/* =====================================================================
   MotivaAutos: Sales and Customer Analysis
   File    : case_study_2.sql
   Purpose : Case Study 2 - headline sales, customer loyalty tiers,
             monthly sales trend and car colour preferences.
   Database: PostgreSQL (motiva_autos)
   Author  : Joshua Oleru
   ===================================================================== */


-- ---------------------------------------------------------------------
-- Q1. What are the total sales and total quantity sold across all
--     orders?
-- ---------------------------------------------------------------------
SELECT
    SUM(sales_amount)  AS total_revenue,
    SUM(quantity_sold) AS total_quantity_sold
FROM orders;


-- ---------------------------------------------------------------------
-- Q2. Segment customers into loyalty tiers based on revenue generated.
--     Gold   : 1,000,000 and above
--     Silver : 500,000 to 999,999
--     Bronze : below 500,000
-- ---------------------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    SUM(o.sales_amount)                AS total_revenue,
    CASE
        WHEN SUM(o.sales_amount) >= 1000000 THEN 'Gold'
        WHEN SUM(o.sales_amount) >=  500000 THEN 'Silver'
        ELSE 'Bronze'
    END                                AS loyalty_tier
FROM customers c
INNER JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC;


-- ---------------------------------------------------------------------
-- Q3. What is the monthly sales trend? (seasonality and growth)
-- ---------------------------------------------------------------------
SELECT
    TO_CHAR(DATE_TRUNC('month', order_date), 'YYYY-MM')  AS month,
    TO_CHAR(DATE_TRUNC('month', order_date), 'FMMonth')  AS month_name,
    COUNT(order_id)                                       AS total_orders,
    SUM(quantity_sold)                                    AS units_sold,
    SUM(sales_amount)                                     AS total_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);


-- ---------------------------------------------------------------------
-- Q4. Which car colours are purchased most frequently?
--     LEFT JOIN keeps colours that have not sold, shown as zero.
-- ---------------------------------------------------------------------
SELECT
    cr.car_color,
    COALESCE(SUM(o.quantity_sold), 0) AS total_units_sold,
    COALESCE(SUM(o.sales_amount), 0)  AS total_revenue
FROM cars cr
LEFT JOIN orders o
    ON o.car_id = cr.car_id
GROUP BY cr.car_color
ORDER BY total_units_sold DESC;
