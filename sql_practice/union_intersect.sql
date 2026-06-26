-- union , intersect , except (mysql dosen't suppoer intersect and except directly)

-- 1.List all distinct cities from the customers table combined with all distinct shipping cities from orders.
select city  from customers union
select	trim(substring_index(substring_index(shipping_address, ',' , 2), ',' , -1)) as city from orders;

-- 2.Show all products that have been ordered and also exist in the products catalog. 
select products.product_name , order_details.order_id from products
inner join order_details on products.product_id = order_details.product_id;

-- 3.Find customers who have placed orders but are not listed in the returns table.
select orders.customer_id , orders.order_id from orders 
join order_details on orders.order_id = order_details.order_id
where not exists (select 1 from returns where order_details.order_detail_id = returns.order_detail_id);

-- 4.Find states that have customers but no orders shipped to them yet.
select customers.state from customers
where not exists(select 1 from orders where orders.customer_id = customers.customer_id);

-- 5.List customer IDs who have made payments using Credit Card and also UPI.
select orders.customer_id , orders.payment_method from orders where payment_method in("Credit Card" , "UPI")
group by orders.customer_id , orders.payment_method having count(distinct payment_method) = 2;

-- 6.Show product IDs that were returned in 2024 but not in 2025.
select order_details.product_id , returns.return_date from order_details
join returns on order_details.order_detail_id = returns.order_detail_id
where returns.return_date >= "2024-01-01" and returns.return_date < "2025-01-01"
and order_details.product_id not in (
SELECT order_details.product_id from order_details
join returns on returns.order_detail_id = order_details.order_detail_id
where returns.return_date >="2025-01-01" and returns.return_date < "2026-01-01");

-- 7.Return brands that appear in both the products table and also in orders where the average discount > 10%.
select products.brand  from products
join order_details on products.product_id = order_details.product_id
group by products.brand 
having avg(order_details.discount_percent) > 10;

-- 8.Find customers who placed orders in January 2025 but not in February 2025.
select distinct customers.customer_id , orders.order_date from customers
join orders on customers.customer_id = orders.customer_id
where orders.order_date >= "2025-01-01" and orders.order_date < "2025-02-01"
and customers.customer_id not in (
select distinct customers.customer_id from customers join orders on
customers.customer_id = orders.customer_id
where  orders.order_date >= "2025-02-01" and orders.order_date < "2025-03-01"
); 

