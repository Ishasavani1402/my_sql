-- group by and havig clause
-- 1.Count customers in each city.
select city , count(customer_id) as customer from customers group by city;

-- 2.Show the total number of orders by order status for the year 2025.
select order_status , count(order_id) as total_order from orders 
where order_date between '2025-01-01' and '2025-12-31' group by order_status  ;

-- 3.List product categories where the average product price is greater than 40,000.
select category , avg(price) as avg_price from products group by category  having avg(price) > 40000;

-- 4.Show cities in Maharashtra that have more than 30 customers.
select city ,  count(customer_id) as customers_ from customers 
where state = "Maharashtra" group by city having count(customer_id) > 30;

-- 5.For the year 2024, list months with at least 100 orders.
select monthname(order_date) as month , count(order_id) as total_order  from orders 
where year(order_date) = 2024 group by month(order_date) , monthname(order_date) having count(order_id) >= 100
order by month(order_date);

-- 6.For each product category, count products priced above 50,000 and return only those categories with at least 5 such products.
select category , count(product_id) as cnt_prd from products where price > 50000 group by category having count(product_id) >=5;

-- 7.List customers who placed more than 3 orders during 2025.
select customers.customer_id , customers.first_name , count(orders.order_id) as total_order from customers 
join orders on customers.customer_id = orders.customer_id where year(orders.order_date) = 2025 
group by customers.customer_id , customers.first_name having count(orders.order_id) > 3;

-- 8.Considering only customers who signed up in 2024, list 
-- states where the average customer age is above 30 and there are at least 10 customers.
select state , avg(age) , count(customer_id) as cust_cnt from customers 
where signup_date >= '2024-01-01' and signup_date < '2025-01-01' 
group by state having avg(age) > 30 and count(customer_id) > 10;

-- 9.For shipped orders only, list months where the total discount across all order lines exceeded 5,000.
select monthname(orders.shipped_date) , sum(order_details.discount_percent) from orders 
join order_details on orders.order_id = order_details.order_id
where orders.order_status = "shipped"
group by monthname(orders.shipped_date)
having sum(order_details.discount_percent) > 5000;

-- 10.For returns in 2025, list cities with at least 5 returned line items.
select customers.city , count(returns.return_id) as total_return from returns
join order_details on returns.order_detail_id = order_details.order_detail_id
join orders on orders.order_id = order_details.order_id
join customers on orders.customer_id = customers.customer_id
where year(returns.return_date) = 2025
group by customers.city
having count(returns.return_id) > 5;

-- 11.For 2024, list product sub-categories that sold at least 200 total units and appeared in at least 20 distinct orders.
select products.sub_category , sum(order_details.quantity) as total_unit_sold , count(distinct orders.order_id) as total_order from products
join order_details on products.product_id = order_details.product_id
join orders on orders.order_id = order_details.order_id
where orders.order_date >= '2024-01-01' and orders.order_date < '2025-01-01'
group by products.sub_category
having sum(order_details.quantity) >= 200 and count(distinct orders.order_id) >=20
