drop database students;
create database cloud;
use cloud;
create table users(
uid int primary key auto_increment ,
 name varchar(20) not null ,
 email varchar(50) unique not null,
 gender enum("male","female","other"));
select * from users; 
rename table users to customers;
select * from customers;
alter table customers add column phone int;
select * from customers; 
alter table customers drop column phone;
select * FROM customers;
alter table customers modify column email varchar(100);
select * FROM customers;