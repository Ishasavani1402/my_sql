-- string functions
-- 1.Convert all customer first names to uppercase.
select upper(first_name) from customers;

-- 2.Show the length of each customer’s last name.
select last_name , length(last_name) as length_ from customers;

-- 3.Extract the first 3 letters of each customer’s city.
select city , substr(city , 1,3) from customers; 

-- 4.Concatenate first name and last name into a single field.
select concat(first_name , " " , last_name) as fullname from customers;

-- 5.Replace “gmail” with “outlook” in customer email addresses.
select email , replace(email , "gmail" , "outlook") from customers;

-- 6.Find the position of “@” in each customer email.
select email , position("@" in email) as position from customers;

-- 7.Trim spaces from the beginning and end of customer first names.
select first_name, trim(first_name) from customers;

-- 8.Reverse the customer’s last name.
select last_name , reverse(last_name) as reverse from customers;

-- 9.Show customers whose city name length is more than 6 characters.
select concat(first_name , " " , last_name) as fullname , city from customers where length(city) > 6;

-- 10.Return only the domain part of customer email addresses (everything after “@”).
select email , substring_index(email , "@" , -1) as domain from customers;