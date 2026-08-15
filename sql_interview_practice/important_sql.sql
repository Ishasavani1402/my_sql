-- create
CREATE TABLE EMPLOYEE (
  empId INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  dept TEXT NOT NULL,
  salary text NOT NULL , 
  manager_id INTEGER
);

-- insert
INSERT INTO EMPLOYEE VALUES (101, 'Isha', 'Sales' , 30000 , 100);
INSERT INTO EMPLOYEE VALUES (102, 'Neha', 'Accounting' , 40000 , 104);
INSERT INTO EMPLOYEE VALUES (103, 'Heli', 'Sales' , 24000 , 120);
INSERT INTO EMPLOYEE VALUES (104, 'Pinal', 'Accounting' , 34000 , 126);
INSERT INTO EMPLOYEE VALUES (105, 'Krishna', 'Sales' , 80000 , 110);


-- fetch 
SELECT * FROM EMPLOYEE;

-- queries
-- 1 . write a query to find second higest distinct salary
SELECT max(salary) as second_higest_salary from EMPLOYEE 
where salary < (SELECT max(salary) as higest_salary
from EMPLOYEE);

-- 2 . Write a query to find employees earning more than the company average salary.
select name , salary from EMPLOYEE where salary > (select avg(salary) as avg_salary from EMPLOYEE);

-- 3 . Write a query to find employees whose salary is higher than their manager salary.(cross join)
select e.name as emp_name , e.salary as emp_salary , 
m.name as man_name , m.salary as man_salary
from EMPLOYEE as e join EMPLOYEE as m 
on e.manager_id = m.empId
where e.salary > m.salary;

-- create
CREATE TABLE CUSTOMERS (
  cust_id INTEGER PRIMARY KEY,
  name text,
  city text
);

-- create
CREATE TABLE ORDERS (
  o_id INTEGER,
  cust_id INTEGER, 
  amount INTEGER , 
  status text,
  FOREIGN KEY (cust_id) REFERENCES CUSTOMERS(cust_id)
);

INSERT INTO CUSTOMERS VALUES (101, 'isha', 'Surat' );
INSERT INTO CUSTOMERS VALUES (102, 'neha', 'Surat' );
INSERT INTO CUSTOMERS VALUES (103, 'heli', 'baroda' );
INSERT INTO CUSTOMERS VALUES (104, 'pinam', 'baroda' );
INSERT INTO CUSTOMERS VALUES (105, 'om', 'ahemedabad' );

insert INTO ORDERS VALUES (1 , 101 , 20000 , "Delivered");
INSERT into ORDERS VALUES (2 , 101 , 3000 , "Delivered");
insert into ORDERS VALUES (3 , 102 , 3000 , "pending");
insert into ORDERS VALUES (4 , 103 , 30000 , "Delivered");
insert into ORDERS VALUES (5 , 105 , 4000 , "cancelled");


select * from CUSTOMERS;
select * from ORDERS;

-- 1 . Write a query to find customers who have never placed an order.
select c.cust_id , c.name from CUSTOMERS c 
left join ORDERS o on c.cust_id = o.cust_id 
where o.o_id is null ; 

-- 2 . Write a query to find customers who placed more than one order.
select c.name , count(*) as total_orders
from CUSTOMERS c inner join ORDERS o on c.cust_id = o.cust_id
group by c.cust_id , c.name 
having count(*) > 1;

-- 3 . Write a query to find the highest-spending customer based only on delivered orders.
select c.name , sum(o.amount) as total_spent from CUSTOMERS c 
inner join ORDERS o on c.cust_id = o.cust_id where o.status = "Delivered"
group by c.cust_id , c.name order by total_spent desc;


-- ==========================================================================================================
-- que : A table has 100 million records. You want to remove all rows as quickly as possible while keeping the
-- table. Which SQL command will you use?
-- Interview Answer

-- • Use TRUNCATE when all rows must be removed quickly.

-- • It keeps the table structure but removes the data.

-- • It is generally faster than DELETE for full-table cleanup.

-- QUERY / EXAMPLE
-- TRUNCATE TABLE Employees;

-- ==================================================================================================

-- que : A new intern should only be able to view the Employees table but should not modify it. Which SQL
-- command will you use?
-- ans : • Use GRANT to give specific access.

-- • SELECT permission allows reading data from
-- Employees.

-- • Do not grant INSERT, UPDATE or DELETE
-- permissions.

-- QUERY / EXAMPLE

-- GRANT SELECT ON Employees
-- TO intern_user;

-- ===================================================================================================

-- query execution orders
-- from -> where -> groupby -> having -> select -> order by -> limit 

-- =======================================================================================================

-- que : A ranking query contains duplicate salaries. How will ROW_NUMBER(), RANK(), and DENSE_RANK() assign
-- values differently?

-- • ROW_NUMBER gives a unique sequence even when salaries tie.
-- • RANK gives same rank to ties but leaves gaps.
-- • DENSE_RANK gives same rank to ties without gaps.

-- ============================================================================================

-- que : A table contains duplicate and NULL email values. How will COUNT(*), COUNT(email), and COUNT(DISTINCT
-- email) differ?

-- • COUNT(*) counts every row.

-- • COUNT(email) counts only rows where email
-- is not NULL.

-- • COUNT(DISTINCT email) counts unique non-
-- NULL emails only.

-- ============================================================================================

-- que : A report contains missing values across primary_phone, alternate_phone, and emergency_phone. How
-- would you return the first available value and show 'Not Available' when all three are NULL?

-- • COALESCE returns the first non-
-- NULL value.

-- • Useful when multiple optional
-- columns can contain the required
-- value.

-- • The final text value works as a
-- fallback when all columns are NULL.

-- SELECT customer_name,COALESCE(primary_phone, alternate_phone,emergency_phone,
-- 'Not Available') AS contact_phone FROM Customers;

-- =============================================================================================

-- que : A percentage calculation divides achieved_sales by target_sales, but some targets are zero. How would you
-- prevent a divide-by-zero error while preserving those rows?

-- • NULLIF(target
-- _
-- sales, 0) turns zero into

-- NULL.

-- • Dividing by NULL returns NULL instead of
-- crashing the query.

-- • Rows are preserved, so missing or invalid
-- percentage can be handled later.

-- SELECT employee_id, achieved_sales * 100.0 / NULLIF(target_sales, 0) AS achievement_pct
-- FROM Sales_Targets;

-- ==============================================================================================

-- que : Write a query to delete duplicate records while keeping the newest record for each
-- email.

-- WITH ranked AS (
-- SELECT customer_id,

-- ROW_NUMBER() OVER (
-- PARTITION BY email
-- ORDER BY created_at DESC
-- ) AS rn

-- FROM Customer_Records
-- )
-- DELETE FROM Customer_Records
-- WHERE customer_id IN (
-- SELECT customer_id
-- FROM ranked
-- WHERE rn > 1
-- );