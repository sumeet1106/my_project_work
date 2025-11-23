drop database library_system;
create database shop_demo;
use shop_demo;

create table customers(customer_id int primary key auto_increment,first_name varchar(40),last_name varchar(40),city varchar(40));

insert into customers(first_name,last_name,city)values
('Amit',  'Sharma', 'Mumbai'),
('Priya', 'Patil',  'Pune'),
('Sumeet','Khadse', 'Nagpur');
select *
from customers;

create table products(product_id int primary key auto_increment,product_name varchar(50),price decimal(10,2));

insert into products(product_name,price)values
('Laptop',        50000),
('Phone',         30000),
('Headphones',    2000);


create table orders(order_id int primary key auto_increment,customer_id int,product_id int, order_date date,quantity int);

insert into orders (customer_id, product_id, order_date, quantity) VALUES
(1, 1, '2024-01-15', 1),
(1, 3, '2024-01-20', 2),
(2, 2, '2024-01-18', 1),
(3, 3, '2024-01-19', 3);


select *
from customers;

select *
from products;

select *
from orders;


-- 1️⃣ What are the top 5 most recent orders?
select *
from orders
order by order_date desc limit 5;

-- 1. Show all customers.
select *
from customers;

-- 2. Show all product names and prices.
select product_name,price
from products;

-- 3. Show only customers from Mumbai.
select *
from customers
where city = 'mumbai';

-- 4. Show orders with customer name and quantity.
select c.first_name,c.last_name,o.quantity
from orders as o
inner join customers as c
on o.customer_id=c.customer_id
order by o.quantity desc;

-- 5. Show orders with product name and total amount (price × quantity).
select p.product_name, round((p.price*o.quantity)) as total_amount
from orders as o
inner join products as p
on o.product_id= p.product_id;

-- 6. Find total orders per customer.
select c.first_name,count(o.order_id) as total_order
from orders as o
inner join customers as c
on o.customer_id=c.customer_id
group by c.first_name;

-- 7. Find total money spent by each customer.
select c.first_name, sum(p.price*o.quantity) as total_money
from orders as o
inner join customers as c
on o.customer_id=c.customer_id
inner join products as p
on o.product_id=p.product_id
group by c.first_name;

-- 8. Find customers who never placed any order.
select c.first_name
from orders as o
inner join customers as c
on o.customer_id=c.customer_id
where o.order_id is null;

SELECT
    c.first_name,
    c.last_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

select c.first_name,c.last_name
from customers as c
left join orders as o
on c.customer_id=o.customer_id
where order_id is null;

-- 9. Find the most expensive product.
select product_name,price as most_expo
from products
order by price desc limit 1;

-- 10. Find the top 3 most recent orders.
select *
from orders
order by order_date desc limit 3;

-- 11. Find city-wise total revenue.
select c.city , sum(p.price*o.quantity) as total_revenue
from orders as o
inner join customers as c
on o.customer_id=c.customer_id
inner join products as p
on o.product_id=p.product_id
group by c.city
order by total_revenue desc;

-- 12. Average order value (AOV). formula avg(pricee * quantity)
select round(avg(p.price * o.quantity),2) as avg_order_value
from orders as o
inner join products as p
on o.product_id=p.product_id;

--  13. Find product-wise total quantity sold.

select p.product_name , sum(o.quantity) as total_quant_sold
from orders as o
inner join products as p
on o.product_id = p.product_id
group by p.product_name
order by total_quant_sold desc;
SELECT
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id;


-- 14. Find top 2 products by revenue.
select p.product_name, sum(p.price * o.quantity) as revenue
from orders as o
inner join products as p
on o.product_id=p.product_id
group by p.product_name
order by revenue desc limit 2;
SELECT
    p.product_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id
ORDER BY total_revenue DESC
LIMIT 2;

-- 15. Find orders where quantity is more than the average.
select * 
from orders
where quantity>(select avg(quantity) from orders);

-- 16. Find month-wise sales trend.
select sum(p.price * o.quantity) as total_sales,
date_format(o.order_date,'%Y-%m') as month
from orders as o
inner join products as p
on o.product_id= p.product_id
group by month
order by month;

 select   DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(o.quantity * p.price) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- 18. Find customers who bought more than 1 type of product.
select c.first_name, count( distinct o.product_id) as diff_product_bought
from orders as o
inner join customers as c
on o.customer_id=c.customer_id
group by c.first_name
having count(distinct o.product_id) > 1;

-- 19. Show last order date of each customer.
select c.first_name,max(o.order_date) as last_order -- use max to find last and min to find oldest
from orders as o
inner join customers as c
on o.customer_id = c.customer_id 
group by c.first_name;
SELECT
    c.first_name,
    MAX(o.order_date) AS last_order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 20. Find the day with highest sales in history.
select o.order_date, sum(p.price * o.quantity) as highest_sale
from orders as o
inner join products as p
on o.product_id = p.product_id
group by o.order_date
order by highest_sale desc limit 1;

drop database school_demo;
 create database vehicle_demo;
 use vehicle_demo;
 
 
 create table customers(customer_id int primary key auto_increment,first_name varchar(40),last_name varchar(40),city varchar(40));

insert into customers(first_name,last_name,city)values
('Amit', 'Sharma', 'Mumbai'),
('Priya', 'Patil', 'Pune'),
('Sumeet', 'Khadse', 'Nagpur'),
('Neha', 'Verma', 'Delhi');

create table vehicles(vehicle_id int primary key auto_increment,vehicle_name VARCHAR(50),vehicle_type VARCHAR(30),price_per_day DECIMAL(10,2));

insert into vehicles(vehicle_name,vehicle_type,price_per_day)values
('Honda City', 'Car', 2000),
('Royal Enfield', 'Bike', 1200),
('Kia Seltos', 'Car', 2500),
('TVS Jupiter', 'Scooter', 800);

create table rentals(rental_id int primary key auto_increment,customer_id int, vehicle_id int,rental_date date,day_rented int);
alter table rentals
rename column day_rented to days_rented;
INSERT INTO rentals (customer_id, vehicle_id, rental_date, days_rented) VALUES
(1, 1, '2024-02-10', 3),
(1, 2, '2024-02-15', 2),
(2, 3, '2024-02-12', 5),
(3, 4, '2024-02-18', 1),
(4, 1, '2024-02-20', 4);

select *
from customers;

select *
from vehicles;

select *
from rentals;

-- 1️⃣ Show all customers.
select *
from customers;

-- 2️⃣ Show all vehicles and their price per day.
select vehicle_name,price_per_day
from vehicles;

-- 3️⃣ Show all customers from Mumbai.
select *
from customers
where city = 'mumbai';

-- 4️⃣ Show rentals with customer name and rental date.
select c.first_name,c.last_name,r.rental_date
from rentals as r
inner join customers as c
on r.customer_id = c.customer_id;

-- 5️⃣ Show rentals with vehicle name and days rented.
select v.vehicle_name,r.days_rented
from rentals as r
inner join vehicles as v
on r.vehicle_id = v.vehicle_id
order by r.days_rented desc;

-- 6️⃣ Show rental amount (price_per_day × days_rented) per rental.
select r.rental_id, c.first_name,v.vehicle_name,sum(v.price_per_day*r.days_rented) as rental_amount
from rentals as r
inner join vehicles as v
on r.vehicle_id = v.vehicle_id
inner join customers as c
on r.customer_id = c.customer_id
group by r.rental_id;
SELECT
    r.rental_id,
    c.first_name,
    v.vehicle_name,
    (v.price_per_day * r.days_rented) AS total_amount
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN vehicles v ON r.vehicle_id = v.vehicle_id;

-- 7️⃣ Count how many rentals each customer has made.
select c.first_name,c.last_name ,count(r.rental_id) as total_rental
from rentals as r
inner join customers as c
on r.customer_id = c.customer_id
group by c.first_name ,c.last_name ,c.customer_id;

-- 8️⃣ Find customers who never rented any vehicle.
select c.customer_id, c.first_name,c.last_name
from customers as c
left join rentals as r
on c.customer_id = r.customer_id
where r.rental_id is null;

-- Find the most expensive vehicle.
select vehicle_name, max(price_per_day)
from vehicles
group by vehicle_name
order by max(price_per_day) desc limit 1;
SELECT
    vehicle_name,
    price_per_day
FROM vehicles
ORDER BY price_per_day DESC
LIMIT 1;

-- 🔟 Show the 3 most recent rentals.
select * 
from rentals 
order by  rented_date desc limit 3;

use vehicle_demo;
select * 
from customer;
