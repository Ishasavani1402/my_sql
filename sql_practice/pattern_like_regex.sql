-- pattern , like , regx
-- 1,Find all customers whose first name starts with the letter “A”.
select first_name from customers where first_name like "A%";

-- 2.Retrieve customers whose last name ends with “an”.
select last_name from customers where last_name like "%an";

-- 3.List customers whose email contains the word “gmail”.
select first_name , email from customers where email like "%gmail%";

-- 4.Show customers whose phone number begins with “98”.
select concat(first_name, " " ,last_name) as full_name , phone from customers where phone like "98%";

-- 5.Return customers whose city name has “pur” anywhere in it.
select concat(first_name, " " ,last_name) as full_name , city from customers where city like "%pur%";

-- 6.Find customers whose first name is exactly 5 characters long.
select concat(first_name, " " ,last_name) as full_name from customers where length(first_name)=5;

-- 7.Retrieve customers whose email ends with “yahoo.com”.
select concat(first_name, " " ,last_name) as full_name , email from customers where email like "%yahoo.com";

-- 8.List customers whose first name starts with a vowel (A, E, I, O, U).
select concat(first_name, " " ,last_name) as full_name from customers where first_name regexp "^[AEIOU]";

-- 9.Find customers whose last name contains a double letter (like “ss” or “tt”).
select concat(first_name, " " ,last_name) as full_name from customers where last_name regexp "([a-z])\\1";

-- 10.Return customers whose phone number does not contain the digit “0”.
select concat(first_name, " " ,last_name) as full_name , phone from customers where phone not like  "%0%";


