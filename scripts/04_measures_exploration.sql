/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the Total Sales
SELECT 
    SUM(sales_amount)
FROM gold.fact_sales;

SELECT *
FROM gold.fact_sales;

SELECT *
FROM gold.dim_customers;

-- Find how many items are sold
SELECT 
    SUM(quantity)
FROM gold.fact_sales;

-- Find the average selling price
SELECT 
    AVG(price)
FROM gold.fact_sales;

-- Find the Total number of Orders
SELECT 
    COUNT(*)
FROM gold.fact_sales;

-- Find the total number of products
SELECT 
    COUNT(*)
FROM gold.dim_products;

-- Find the total number of customers
SELECT 
    COUNT(*)
FROM gold.dim_customers;


-- Find the total number of customers that has placed an order
SELECT 
    COUNT(*)
FROM gold.dim_customers as gdm
LEFT JOIN gold.fact_sales as gfs
    ON gdm.customer_key = gfs.customer_key;

-- Generate a Report that shows all key metrics of the business
-- Find the Total Sales
SELECT 
    'Total Sales' as measure_name,
    SUM(sales_amount) as measuse_value
FROM gold.fact_sales
UNION ALL
-- Find how many items are sold
SELECT
    'Total Items' as measure_name,
    SUM(quantity) as measuse_value
FROM gold.fact_sales
UNION ALL
-- Find the average selling price
SELECT 
    'Average Price' as measure_name,
    AVG(price) as measuse_value
FROM gold.fact_sales
UNION ALL
-- Find the Total number of Orders
SELECT 
    'Total Orders' as measure_name,
    COUNT(DISTINCT order_number) as measuse_value
FROM gold.fact_sales
UNION ALL
-- Find the total number of products
SELECT 
    'Total product' as measure_name,
    COUNT(DISTINCT product_key) as measuse_value
FROM gold.dim_products
UNION ALL
-- Find the total number of customers
SELECT 
    'Total Number of Customers' as measure_name,
    COUNT(customer_id) as measuse_value
FROM gold.dim_customers
UNION ALL
-- Find the total number of customers that has placed an order
SELECT 
    'Total Number of Customers who ordered' as measure_name,
    COUNT(DISTINCT customer_id) as measuse_value
FROM gold.dim_customers as gdm
LEFT JOIN gold.fact_sales as gfs
    ON gdm.customer_key = gfs.customer_key;