-- Creation DataBase
DROP DATABASE IF EXISTS pizza_db;
CREATE DATABASE pizza_db;
USE pizza_db ;
DESCRIBE pizza_sales;
select * from pizza_sales;

-- KPI :


-- Total Revenue

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales; 

-- Average Order Value

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales ;

-- Total Pizzas Sold

SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales ;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales ;

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /  

CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 

AS Avg_Pizzas_per_order 

FROM pizza_sales ;






-- Hourly Trend for Total Pizzas Sold 


SELECT 
    HOUR(order_time) AS order_hour,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY order_hour;




-- Weekly Orders



SELECT
    WEEK(STR_TO_DATE(order_date, '%d-%m-%Y'), 3) AS WeekNumber,  
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM
    pizza_sales
GROUP BY
    WEEK(STR_TO_DATE(order_date, '%d-%m-%Y'), 3),
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY
    Year, WeekNumber;


--  % of Sales by Pizza Category

SELECT pizza_category, CAST(SUM(total_price) 
AS DECIMAL(10,2)) as total_revenue, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
from pizza_sales) AS DECIMAL(10,2)) AS PCT 
FROM pizza_sales 
GROUP BY pizza_category ;


-- % of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price)
 AS DECIMAL(10,2)) as total_revenue, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
from pizza_sales) AS DECIMAL(10,2)) AS PCT 
FROM pizza_sales 
GROUP BY pizza_size 
ORDER BY pizza_size ;

-- Total Pizzas Sold by Pizza Category
SELECT
    pizza_category,
    SUM(quantity) AS Total_Pizzas_Sold
FROM
    pizza_sales
GROUP BY
    pizza_category
ORDER BY
    Total_Pizzas_Sold DESC;



-- Top 5 Pizzas by Revenue

SELECT
    pizza_name,
   SUM(total_price) AS Total_Revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC LIMIT 5;


-- Bottom 5 Pizzas by Revenue

SELECT
    pizza_name,
   SUM(total_price) AS Total_Revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC LIMIT 5;


-- Top 5 Pizzas by Quantity

SELECT
    pizza_name,
   SUM(quantity) AS Total_Pizzas_Sold
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC LIMIT 5;


-- Bottom 5 Pizzas by Quantity

SELECT
    pizza_name,
   SUM(quantity) AS Total_Pizzas_Sold
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC LIMIT 5;

-- Top 5 Pizzas by Total Orders

SELECT
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;


-- Bottom 5 Pizzas by Total Orders
SELECT
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;