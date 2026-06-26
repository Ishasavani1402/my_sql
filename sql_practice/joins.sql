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
select orders.shipping_address , products.category , products.product_name from order_details
left join products on products.product_id = order_details.product_id
left join orders on orders.order_id = order_details.order_id;

-- 9.Display all returns with their corresponding order details and product information.
	