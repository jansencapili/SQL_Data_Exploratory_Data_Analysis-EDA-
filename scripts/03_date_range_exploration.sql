/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months
SELECT
    MIN(order_date) first_order,
    MAX(order_date) last_order,
    DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) year_range
FROM Gold.fact_sales;

-- Find the youngest and oldest customer based on birthdate
SELECT 
MAX(birthdate) AS youngest_customer,
DATEDIFF(Year,MAX(birthdate),GETDATE()) AS youngest_customer_age,
MIN(birthdate) AS oldest_customer,
DATEDIFF(Year,MIN(birthdate),GETDATE()) AS oldest_customer_age
FROM GOLD.dim_customers;
