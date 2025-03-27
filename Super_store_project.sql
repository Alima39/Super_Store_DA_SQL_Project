create database Project;

use project;

show tables;

-- Get total sales per customer. 

select C.customer_ID, C.Customer_name, sum(OD.sales) as Total_Sales
from customers as C left join orders as O
on C.customer_ID = O.Customer_ID left join order_details as OD
on O.order_ID = OD.order_ID
group by C.customer_ID, C.Customer_name;

-- Find the most profitable product.
select * from order_details;  -- Product_ID
select * from products;       -- Product_ID

select p.product_name, sum(od.profit) as total_Profit
from order_details as OD left join products as P
on OD.product_ID = P.product_ID
group by p.product_name
order by total_profit desc
limit 1;

-- Get total sales by category

select P.category, sum(OD.sales) as total_sales
from order_details as OD left join products as P
on OD.product_ID = P.product_ID
group by P.category
order by total_sales desc;

-- Retrieve top 5 cities with the highest sales

select C.city, sum(OD.sales) as Total_Sales
from customers as C left join orders as O
on C.customer_ID = O.Customer_ID left join order_details as OD
on O.order_ID = OD.order_ID
group by C.city
order by total_sales desc
limit 5;

-- Identify repeat customers (who placed more than 3 orders).

select c.customer_ID, c.customer_name, count(o.order_ID) as total_orders
from customers as C left join orders as O
on c.customer_id = O.customer_ID
group by c.customer_ID, c.customer_name
HAVING COUNT(o.Order_ID) > 3
order by total_orders desc;

-- Get the top 3 products with the highest quantity sold
select p.product_name, sum(OD.quantity) as total_qty
from products as P left join order_details as OD
on p.product_id = OD.product_id
group by p.product_name
order by total_qty desc
limit 3;

-- List all orders where discount is greater than 0.5

SELECT Order_ID, SUM(Discount) AS Total_Discount
FROM Order_Details 
where Discount > 0.5;

-- Find the first and last order date for each customer

SELECT Customer_ID, MIN(Order_Date) AS First_Order, MAX(Order_Date) AS Last_Order
FROM Orders
GROUP BY Customer_ID;

-- Get the ranking of products by revenue using RANK()

SELECT p.Product_Name, SUM(od.Sales) AS Total_Revenue,
       RANK() OVER (ORDER BY SUM(od.Sales) DESC) AS R
FROM Products p
JOIN Order_Details od ON p.Product_ID = od.Product_ID
GROUP BY p.Product_Name;

-- Find all loss-making orders (where total profit is negative)
select order_ID, sum(Profit) as Total_Profit 
from order_details
group by order_ID
having sum(Profit) < 0;

-- Get customers who have purchased more than 10 unique products.
select customer_id, count(distinct product_id) as Unique_products
from (select o.customer_Id, OD.product_id 
from order_details as OD inner join orders as O
on OD.order_id = O.order_id) as Main
group by o.customer_id
having unique_products >10;

-- Calculate the average discount given per product category.
select p.category, avg(OD.discount) as average_discount
from products as P left join order_details as OD
on P.product_id = OD.product_id
group by P.category;

-- Find customers who placed orders for at least 3 different categories.

SELECT o.Customer_ID, COUNT(DISTINCT p.Category) AS Category_Count
FROM Orders o
JOIN Order_Details od ON o.Order_ID = od.Order_ID
JOIN Products p ON od.Product_ID = p.Product_ID
GROUP BY o.Customer_ID
HAVING Category_Count >= 3;

