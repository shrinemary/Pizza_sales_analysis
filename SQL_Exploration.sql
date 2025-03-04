SELECT * FROM pizza_sales;

--Total Revenue : sum of total price 
SELECT ROUND(SUM(total_price),2) as totalRevenue FROM pizza_sales;

--Average order value : average amount spend per order
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT(order_id)),2) AS averageOrderValue
FROM pizza_sales; --distinct order id is used to get the number of total orders as there would be multiple pizza in one order

-- Total number of pizza sold 
SELECT SUM(quantity) AS totalPizzaSold
FROM pizza_sales

--Total orders : number of orders placed 
SELECT COUNT(DISTINCT(order_id)) AS totalOrders
FROM pizza_sales

--Average pizza per order : avg number of pizza sold per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / COUNT(DISTINCT order_id) AS DECIMAL(10,2))  AS avgPizzaPerOrder
FROM pizza_sales;

--Daily trend for total order : orders placed on each day of the week
SELECT DATENAME(WEEKDAY, order_date)  AS orderDay, COUNT(DISTINCT order_id) AS totalOrders 
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY totalOrders desc

--Monthly trend of total order
SELECT DATENAME(MONTH, order_date) AS orderMonth, COUNT(DISTINCT order_id) AS totalOrders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY totalOrders desc

--Percentage sales by pizza category 
SELECT pizza_category AS pizzaCategory, 
ROUND(SUM(total_price),2) AS revenuePerCategory,
ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales),2) AS percentageSalesPerCategory
FROM pizza_sales
GROUP BY pizza_category

--Percentage sales by pizza size
SELECT pizza_size AS pizzaSize,
ROUND(SUM(total_price),2) AS revenueBySize,
ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales),2) AS percentageSalesBySize
FROM pizza_sales
GROUP BY pizza_size
order by pizzaSize

--Pizza sold per category
SELECT pizza_category, SUM(quantity) AS quantityPerCategory
FROM pizza_sales
GROUP BY pizza_category
ORDER BY quantityPerCategory DESC

--Top 5 pizza by revenue 
SELECT TOP 5 pizza_name, SUM(total_price) AS revenuePerPizza
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenuePerPizza DESC

--Bottom 5 pizza by revenue 
SELECT TOP 5 pizza_name, SUM(total_price) AS revenuePerPizza
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenuePerPizza ASC

--Top 5 pizza by quantity ordered
SELECT TOP 5 pizza_name, SUM(quantity) AS quantityPerPizza
FROM pizza_sales
GROUP BY pizza_name
ORDER BY quantityPerPizza DESC

--Bottom 5 pizza by quantity ordered
SELECT TOP 5 pizza_name, SUM(quantity) AS quantityPerPizza
FROM pizza_sales
GROUP BY pizza_name
ORDER BY quantityPerPizza ASC

--Top 5 pizza by total orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS ordersPerPizza -- same pizza, differnt size would be considered as 1
FROM pizza_sales
GROUP BY pizza_name
ORDER BY ordersPerPizza DESC

--Bottom 5 pizza by total orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS ordersPerPizza -- same pizza, differnt size would be considered as 1
FROM pizza_sales
GROUP BY pizza_name
ORDER BY ordersPerPizza ASC