-- joins
-- 1.Retrieve all orders along with the customer details.
select concat(customers.first_name , " ",customers.last_name) as full_name,
customers.gender , orders.* from orders join customers on customers.customer_id = orders.customer_id;

select count(*) from products;

-- 2.Show all customers and their orders, including customers who haven’t placed any orders.
select concat(customers.first_name , " ",customers.last_name) as full_name,
orders.* from orders right join customers on customers.customer_id = orders.customer_id;

-- 3.Display all orders and their customer information, including orders that don’t have a matching customer record.
select orders.*, concat(customers.first_name , " ",customers.last_name) as full_name from orders 
left join customers on orders.customer_id = customers.customer_id;

-- 4.List all possible combinations of customers and products.
select customers.* , products.* from customers cross join products;

-- 5.Retrieve order details along with product names.
select products.product_name,order_details.* from products inner join order_details on products.product_id = order_details.product_id; 

-- 6.Show all products and the orders they appear in, including products that have never been ordered.
select products.product_name , order_details.* from products left join order_details on products.product_id = order_details.product_id;

-- 7.Return customer names and product names for each order placed.
select concat(customers.first_name , ' ',customers.last_name) as full_name , products.product_name from customers
join  orders on customers.customer_id = orders.customer_id
join order_details on order_details.order_id = orders.order_id
join products on products.product_id = order_details.product_id;

-- 8.Find all orders with their shipping address and the product category for each item in the order
select orders.order_id , orders.shipping_address , products.category , products.product_name from order_details
left join products on products.product_id = order_details.product_id
left join orders on orders.order_id = order_details.order_id;

-- 9.Display all returns with their corresponding order details and product information.
SELECT r.*, od.* , p.* FROM returns r
LEFT JOIN order_details od 
    ON r.order_detail_id = od.order_detail_id
LEFT JOIN products p 
    ON od.product_id = p.product_id
LEFT JOIN orders o 
    ON od.order_id = o.order_id
ORDER BY r.return_date DESC;

-- 10.For 2025, list customers with their orders and sort the results by the most recent order date.
select concat(customers.first_name," ", customers.last_name) as fullname , orders.order_id,
orders.order_date , orders.delivery_date, orders.shipped_date, orders.order_status , orders.payment_method
from customers join orders on customers.customer_id = orders.customer_id 
where orders.order_date >= '2025-01-01' and orders.order_date < '2026-01-01' order by orders.order_date desc;	

-- 11.For each customer, show total orders and total quantity ordered
select customers.customer_id , count(distinct orders.order_id) as total_order , sum(order_details.quantity) as total_qty from customers
left join orders on customers.customer_id = orders.customer_id
left join order_details on orders.order_id = order_details.order_id
group by customers.customer_id;

-- 12.For each product, show total units sold and total revenue; include products that have never been ordered.
select products.product_id , products.product_name ,  coalesce(sum(order_details.quantity)) as qty,
coalesce(sum(products.price * order_details.quantity)) as revenue from products 
left join order_details on products.product_id = order_details.product_id
group by products.product_id , products.product_name ;

-- 13.For each month of a given year, show total orders and total returned items; 
-- return only months where the return rate exceeds a chosen percentage.
SELECT MONTH(order_date) AS order_month, COUNT(order_id) AS total_orders,
SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) AS total_returned_orders,
(SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) / COUNT(order_id)) * 100 AS return_rate
FROM orders WHERE YEAR(order_date) = 2024 GROUP BY MONTH(order_date) HAVING return_rate > 20;

-- 14.For each customer, show their first-ever order date and the number of products in that first order.
with first_order as (select customers.customer_id , min(orders.order_date) as first_order 
from customers left join orders on customers.customer_id = orders.customer_id  group by customers.customer_id )
select customers.customer_id , first_order , count(order_details.order_detail_id) as prd_cnt 
from customers 
join first_order on customers.customer_id = first_order.customer_id
join orders on first_order.customer_id = orders.customer_id
and first_order.first_order = orders.order_date
join order_details on orders.order_id = order_details.order_id
group by customers.customer_id , first_order.first_order; 



