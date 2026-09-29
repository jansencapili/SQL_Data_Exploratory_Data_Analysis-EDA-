/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/
-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking

SELECT TOP 5 
    gdp.product_name,
    SUM(sales_amount) as total_revenue
FROM Gold.fact_sales as gfs
LEFT JOIN Gold.dim_products as gdp ON gdp.product_key = gfs.product_key
GROUP BY product_name
ORDER BY total_revenue DESC;


-- Complex but Flexibly Ranking Using Window Functions
SELECT TOP 5 
    gdp.product_name,
    SUM(sales_amount) as total_revenue,
    RANK() OVER(ORDER BY SUM(sales_amount) DESC)
FROM Gold.fact_sales as gfs
LEFT JOIN Gold.dim_products as gdp ON gdp.product_key = gfs.product_key
GROUP BY gdp.product_name

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5 
    gdp.product_name,
    SUM(sales_amount) as total_revenue,
    RANK() OVER(ORDER BY SUM(sales_amount) ASC)
FROM Gold.fact_sales as gfs
LEFT JOIN Gold.dim_products as gdp ON gdp.product_key = gfs.product_key
GROUP BY gdp.product_name

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
    gdc.customer_id,
    gdc.first_name,
    gdc.last_name,
    SUM(sales_amount) as total_revenue,
    DENSE_RANK() OVER(ORDER BY SUM(sales_amount) DESC)
FROM Gold.fact_sales as gfs
LEFT JOIN Gold.dim_customers as gdc ON gdc.customer_key = gfs.customer_key
GROUP BY     
    gdc.customer_id,
    gdc.first_name,
    gdc.last_name;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
    gdc.customer_id,
    gdc.first_name,
    gdc.last_name,
    COUNT(order_number) as total_order,
    DENSE_RANK() OVER(ORDER BY COUNT(order_number) ASC)
FROM Gold.fact_sales as gfs
LEFT JOIN Gold.dim_customers as gdc ON gdc.customer_key = gfs.customer_key
GROUP BY
    gdc.customer_id,
    gdc.first_name,
    gdc.last_name
    ORDER BY total_order;