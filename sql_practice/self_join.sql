-- self join
-- 1.Find pairs of customers who live in the same city but have different last names.
select c1.customer_id as c1_id , 
c1.first_name as c1_first_name, 
c1.last_name as c1_lastname,
c2.customer_id as c2_id,
c2.first_name as c2_firstname,
c2.last_name as c2_lastname,
c1.city from customers c1 
join customers c2 on 
c1.city = c2.city
and c1.last_name <> c2.last_name
and c1.customer_id < c2.customer_id;

-- 2.List pairs of customers with the same last name, then group them by last name and return only those
-- last names that appear more than 3 times.
select c1.customer_id as c1_id,
c1.first_name as c1_first_name, 
c1.last_name as c1_lastname,
c2.customer_id as c2_id,
c2.first_name as c2_firstname,
c2.last_name as c2_lastname,
c1.last_name from customers c1
join customers c2 on 
c1.last_name = c2.last_name
and c1.customer_id < c2.customer_id
where c1.last_name in(
select last_name from customers group by last_name having count(last_name) > 3);

-- 3.For the year 2025, identify customers who placed more than one order on the same date; 
-- show each customer with the specific dates involved.
select o1.customer_id as o1_cid,
o1.order_date as o1_oid,
o2.customer_id as o2_cid,
o2.order_id as o2_oid
from orders o1
join orders o2 on
o1.customer_id = o2.customer_id 
and o1.order_date = o2.order_date
and o1.order_id < o2.order_id
where o1.order_date >= "2025-01-01"
and o1.order_date < "2026-01-01";

-- 4.Within each brand, find pairs of products where one item’s price is at least 50% higher than the other; return only such pairs.
select p1.brand as p1_brand,
p1.product_name as p1_prd,
p1.price as p1_price,
p2.brand as p2_brand,
p2.product_name as p2_prd,
p2.price as p2_price
from products p1 
join products p2 on
p1.brand = p2.brand and
p1.price >= p2.price * 1.5 
and p1.product_id < p2.product_id;

-- 5.For returns within the same month, find reasons that occurred on 3 or more different days of that month; 
-- list reason–month combinations meeting this threshold.
SELECT 
    r1.reason,
    MONTH(r1.return_date) AS return_month,
    COUNT(DISTINCT DATE(r2.return_date)) AS distinct_days
FROM returns r1
JOIN returns r2
    ON r1.reason = r2.reason
   AND MONTH(r1.return_date) = MONTH(r2.return_date)
   AND YEAR(r1.return_date) = YEAR(r2.return_date)
GROUP BY r1.reason, MONTH(r1.return_date)
HAVING COUNT(DISTINCT DATE(r2.return_date)) >= 3;

-- without self join
select reason , month(return_date) as return_month, count(date(return_date)) as countdate 
from returns group by reason , month(return_date) having count(return_date) >=3;  

 
 
 
 


