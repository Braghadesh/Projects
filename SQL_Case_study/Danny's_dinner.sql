
---Total amount each customer spent at restaurant.
SELECT s.customer_id, SUM(price) AS Total
FROM dbo.sales s
JOIN dbo.menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;

---Number of days each customer visited
SELECT s.customer_id, COUNT(DISTINCT(order_date)) As Visits
FROM dbo.sales s
GROUP BY s.customer_id;

---First Item purchased by each customer
SELECT s.customer_id, m.product_name,s.order_date,
DENSE_RANK() OVER(PARTITION BY s.customer_id
ORDER BY s.order_date) As Order_number
FROM dbo.sales s
JOIN dbo.menu m ON s.product_id = m.product_id
GROUP BY s.customer_id,m.product_name,s.order_date
ORDER BY Order_number;

---Most purchased Item
SELECT  m.product_name, COUNT(s.product_id)  As number_of_orders
FROM dbo.sales s
JOIN dbo.menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY number_of_orders Desc;

---Fav item for each customer
WITH CTE_fav_item
as
( SELECT s.customer_id, m.product_name, count(m.product_id) as number_of_orders,
DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(m.product_id) DESC) AS product_rank
FROM dbo.menu m
JOIN dbo.sales s
ON m.product_id = s.product_id
GROUP BY s.customer_id, m.product_name
)

SELECT customer_id, product_name
from CTE_fav_item
where product_rank = 1;

---First purchase after membership
WITH CTE_first_mem_purchase
as
( SELECT s.customer_id, me.join_date, s.order_date, s.product_id,
DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS Order_rank
FROM dbo.sales s JOIN
dbo.members me
ON s.customer_id = me.customer_id
WHERE s.order_date >= me.join_date
)
SELECT c.customer_id, product_name
from CTE_first_mem_purchase c
Join dbo.menu m
ON c.product_id = m.product_id
where c.Order_rank = 1;

---Last item before membership
WITH CTE_last_purchase_before_mem
as
( SELECT s.customer_id, me.join_date, s.order_date, s.product_id,
DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS Order_rank
FROM dbo.sales s JOIN
dbo.members me
ON s.customer_id = me.customer_id
WHERE s.order_date < me.join_date
)
SELECT c.customer_id, product_name
from CTE_last_purchase_before_mem c
Join dbo.menu m
ON c.product_id = m.product_id
where c.Order_rank = 1;

---total number of items and amount spent before becoming member
SELECT s.customer_id, COUNT(DISTINCT s.product_id) as unique_item,
SUM(mm.price) as total_sales
FROM dbo.sales s JOIN
dbo.members m
ON s.customer_id = m.customer_id
JOIN dbo.menu mm
ON s.product_id = mm.product_id
WHERE s.order_date < m.join_date
GROUP BY s.customer_id;

---points calculation

WITH CTE_price_points AS
(
SELECT *,
CASE
WHEN product_id = 1 Then price *20
Else price * 10
END AS points
From menu
)
SELECT s.customer_id, SUM(p.points) AS total_points
FROM CTE_price_points AS p
Join sales as s
ON p.product_id = s.product_id
GROUP By s.customer_id;
