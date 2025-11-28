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

drop database vehicle_demo;

create database food_delivery_demo;
use food_delivery_demo;

create table customers(customer_id int primary key auto_increment,first_name varchar(40), last_name varchar(40), city varchar(40));

insert into customers (first_name,last_name,city)values
('Amit', 'Sharma', 'Mumbai'),
('Priya', 'Patil', 'Pune'),
('Sumeet', 'Khadse', 'Nagpur'),
('Neha', 'Verma', 'Delhi');

select *
from customers;

create table restaurants(restaurant_id int primary key auto_increment, restaurant_name varchar(40),cuisine_type varchar(40));

insert into restaurants(restaurant_name, cuisine_type) VALUES
('Biryani House', 'Indian'),
('Pizza Mania', 'Italian'),
('Sushi World', 'Japanese'),
('Healthy Bowl', 'Salad');

select * 
from restaurants;

create table orders(order_id int primary key auto_increment,customer_id int ,restaurant_id int, order_date date);

insert into  orders( customer_id, restaurant_id, order_date) VALUES
(1, 1, '2024-03-01'),
(1, 2, '2024-03-05'),
(2, 3, '2024-03-06'),
(3, 4, '2024-03-10'),
(4, 1, '2024-03-12');

select *
from orders;

create table order_items(order_item_id int primary key auto_increment,order_id int ,item_name varchar(40),price decimal (10,2),quantity int);


insert into order_items(order_id, item_name, price, quantity) VALUES
(1, 'Chicken Biryani', 250, 2),
(1, 'Raita', 50, 1),
(2, 'Margherita Pizza', 350, 1),
(2, 'Garlic Bread', 150, 1),
(3, 'Sushi Roll', 400, 2),
(4, 'Green Salad', 200, 1),
(5, 'Veg Biryani', 220, 1);

show tables;

-- 1️⃣ Show all customers.
select *
from customers;

-- 2️⃣ Show all restaurants in Mumbai.
select distinct r.restaurant_name,c.city
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
inner join customers as c
on o.customer_id = c.customer_id
where c.city = 'mumbai';
SELECT DISTINCT
    r.restaurant_name,
    c.city
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE c.city = 'Mumbai';

-- 3️⃣ Show all orders with customer name.
select o.order_id , c.first_name, c.last_name,o.order_date
from orders as o
inner join customers as c
on o.customer_id = c.customer_id;

-- 4️⃣ Show all order items with restaurant name.
select o.order_id,oi.item_name, r.restaurant_name
from orders as o
inner join order_items as oi
on o.order_id=oi.order_id
inner join restaurants as r
on o.restaurant_id = r.restaurant_id;
SELECT
    oi.item_name,
    oi.price,
    r.restaurant_name
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id;

-- 5️⃣ Show total number of orders made.
select count(*) as total_orders
from orders;

-- 6️⃣ Show total amount per order.
select o.order_id,sum(oi.price* oi.quantity) as total_amount
from order_items as oi
inner join orders as o
on oi.order_id=o.order_id
group by o.order_id;
SELECT
    o.order_id,
   round( SUM(oi.price * oi.quantity)) AS total_amount
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

-- 7️⃣ Find the top 2 customers by total spending.
select c.first_name,sum(oi.price*oi.quantity) as total_spending
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
inner join order_items as oi
on o.order_id = oi.order_id
group by c.customer_id
order by total_spending  desc limit 2;

-- 8️⃣ Find restaurants that were never ordered from.
select r.restaurant_id,r.restaurant_name
from restaurants as r
left join orders as o
on r.restaurant_id = o.restaurant_id
where o.order_id is null;
SELECT
    r.restaurant_id,
    r.restaurant_name
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
WHERE o.order_id IS NULL;

-- 9️⃣ Show cuisine_type-wise total revenue.
select r.cuisine_type, sum(oi.price*oi.quantity) as total_revenue
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
inner join order_items as oi
on o.order_id =oi.order_id
group by cuisine_type ;
SELECT
    r.cuisine_type,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY r.cuisine_type;

-- 🔟 Show most ordered item.
select item_name, max(quantity) as most_order
from order_items
group by item_name 
order by most_order desc limit 1;


select first_name,last_name,city 
from customers;

-- 3️⃣ Find customers from Delhi
select *
from customers 
where city = 'delhi';

-- 4️⃣ Show all restaurants with cuisine type
select  restaurant_name,cuisine_type
from restaurants;

-- 5️⃣ Find items with price greater than 200
select *
from order_items
where price > 200;

-- 6️⃣ Show orders placed on 2024-03-05
select *
from orders 
where order_date = '2024-03-05';

-- 7️⃣ Show all items sorted by price (high → low)
select item_name, price
from order_items
order by price desc;

-- 8️⃣ Show top 3 cheapest items
select item_name, price 
from order_items
order by price asc limit 3;

-- 9️⃣ Show latest 2 orders
select *
from orders 
order by order_date desc limit 2;

-- 🔟 Show restaurants sorted alphabetically
select *
from restaurants
order by restaurant_name asc;

-- 1️⃣1️⃣ Show customers sorted by first_name A → Z
select first_name,last_name
from customers
order by first_name asc;

-- 1️⃣2️⃣ Count how many customers are from each city
select count(*) as total_customer, city
from customers 
group by city;

-- 1️⃣3️⃣ Count number of items ordered in each order
select order_id , sum(quantity) as total_count
from order_items
group by order_id;

-- 1️⃣4️⃣ Show total revenue for each food item
select item_name, sum(price*quantity) as total_revenue
from order_items
group by item_name
order by total_revenue desc;

-- 1️⃣5️⃣ Find the city with the most customers
select city , count(*) as total_customers
from customers
group by city
order by total_customers desc limit 1;
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC
LIMIT 1;

-- 1️⃣6️⃣ Find total orders placed by each customer
select c.first_name,c.last_name,count(o.order_id) as total_orders
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
group by c.customer_id
order by total_orders desc ;
SELECT
    c.first_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;


-- 1️⃣7️⃣ Show customer name with order date
select c.first_name,c.last_name,o.order_date
from orders as o
inner join customers as c
on o.customer_id = c.customer_id;

-- 1️⃣8️⃣ Show restaurant name with order date
select r.restaurant_name, o.order_date
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id;

-- 1️⃣9️⃣ Show food item with its restaurant
select oi.item_name , r.restaurant_name
from orders as o
inner join order_items as oi
on o.order_id = oi.order_id
inner join restaurants as r
on o.restaurant_id = r.restaurant_id;
SELECT
    oi.item_name,
    r.restaurant_name
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id;

-- 2️⃣0️⃣ Show total money spent by each customer
select c.customer_id , c.first_name,c.last_name,sum(oi.price*oi.quantity) as total_money
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
inner join order_items as oi
on o.order_id = oi.order_id
group by c.customer_id
order by total_money desc;


-- 1️⃣ Show all restaurants in ‘Indian’ cuisine.
select restaurant_name
from restaurants
where cuisine_type = 'indian';

-- 2️⃣ Show customers who live in either Mumbai OR Delhi.
select *
from customers
where city in ('mumbai','delhi');


-- 3️⃣ Show all items with price between 100 and 300.
select Item_name ,price
from order_items
where price between 100 and 300 ;

-- 4️⃣ Show customers whose first name starts with ‘P’.
select *
from customers
where first_name like 'p%';

-- 5️⃣ Show orders made before 2024-03-10.
select *
from orders
where order_date < '2024-03-10';

select *
from orders
where order_date > '2024-03-10';

-- 6️⃣ Show the most expensive 2 food items.
select item_name, price
from order_items
order by price desc limit 2;
SELECT item_name, price
FROM order_items
ORDER BY price DESC
LIMIT 2;

-- 7️⃣ Show the earliest 3 orders (oldest).
select *
from orders 
order by order_date asc limit 3;
SELECT *
FROM orders
ORDER BY order_date ASC
LIMIT 3;

-- 8️⃣ Show restaurants ordered by cuisine Z → A.
select restaurant_name,cuisine_type
from restaurants
order by cuisine_type asc;

-- Show top 2 cheapest items for each cuisine
select item_name,price 
from order_items
order by price asc limit 2;

-- 🔟 Show restaurant names only once (no repetition).
select distinct restaurant_name
from restaurants;

-- 1️⃣1️⃣ Count number of customers in each city.
select city , count(*) as no_customer_
from customers
group by city ;

-- 1️⃣2️⃣ Count total orders per restaurant.
select r.restaurant_name, count(o.order_id) as total_order
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
group by r.restaurant_name;

select r.restaurant_name , count(o.order_id) as total_order
from restaurants as r
left join orders as o
on r.restaurant_id =o.restaurant_id
group by restaurant_name;

-- 1️⃣3️⃣ Show total items ordered per order.
select order_id , sum(quantity) as total_order
from order_items
group by order_id;

-- 1️⃣4️⃣ Find highest total quantity ordered AND show only one order.
select order_id , sum(quantity) as total_quantity
from order_items
group by order_id
order by total_quantity desc limit 1;

-- 1️⃣5️⃣ Show total revenue per item. (price × quantity)
select item_name , sum(price*quantity) as total_revenue
from order_items 
group by item_name
order by total_revenue desc ;

-- 1️⃣6️⃣ Show customer name with restaurant name (for every order).
select c.first_name, c.last_name, r.restaurant_name
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
inner join restaurants as r
on o.restaurant_id = r.restaurant_id;

-- 1️⃣7️⃣ Show item_name with restaurant_name and customer_name.
select c.first_name,r.restaurant_name, oi.item_name
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
inner join order_items as oi
on o.order_id = oi.order_id;
SELECT
    oi.item_name,
    r.restaurant_name,
    c.first_name
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN customers c ON o.customer_id = c.customer_id;

-- 1️⃣8️⃣ Find customers who ordered more than 1 item (per order).
select o.order_id,  c.first_name, sum(oi.quantity) as total_quant
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
inner join order_items as oi
on o.order_id = oi.order_id
group by o.order_id
having total_quant >1;
SELECT
    o.order_id,
    c.first_name,
    SUM(oi.quantity) AS total_items
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.order_id
HAVING total_items > 1;

-- 1️⃣9️⃣ Show restaurant-wise total revenue.
select r.restaurant_name, sum(oi.price* oi.quantity) as total_revenue
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
inner join order_items as oi
on o.order_id = oi.order_id
group by r.restaurant_name
order by total_revenue desc ;

-- 2️⃣0️⃣ Find top spending customer.
select c.first_name, sum(oi.price*oi.quantity) as total_spending
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
inner join order_items as oi
on o.order_id = oi.order_id 
group by c.customer_id
order by total_spending desc limit 1 offset 1;

-- 2️⃣3️⃣ Problem: Find customers who have never placed any order.
select c.customer_id,c.first_name,c.last_name
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
where o.order_id is null;
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 2️⃣4️⃣ Problem: Show all food items ordered from ‘Biryani House’.
select   oi.item_name, oi.price,oi.quantity
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
inner join order_items as oi
on o.order_id = oi.order_id
where  r.restaurant_name = 'biryani house';

-- 2️⃣5️⃣ Problem: Find total revenue per cuisine type.
select r.cuisine_type, sum(oi.price*oi.quantity) as total_revenue
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
inner join order_items as oi
on o.order_id = oi.order_id
group by r.cuisine_type
order by total_revenue desc ;

use food_delivery_demo;
-- 1️⃣ List all restaurants serving ‘Japanese’ cuisine.
select restaurant_name
from restaurants 
where cuisine_type='japanese';
SELECT *
FROM restaurants
WHERE cuisine_type = 'Japanese';

-- 2️⃣ Show all customers not from Mumbai.
select *
from customers 
where city not in ('mumbai');
select *
from customers 
where city <> 'mumbai';

-- 3️⃣ Show all items with quantity 2 or more.
select item_name
from order_items
where quantity >= 2;
SELECT *
FROM order_items
WHERE quantity >= 2;

-- 4️⃣ Show all orders, newest first.
select *
from orders
order by order_date desc ;

-- 5️⃣ Show the five cheapest items.
select item_name , price 
from order_items
order by price asc limit 5;

-- 6️⃣ Count how many orders were placed each day.
select order_date, count(*) as total_order_place
from orders
group by order_date
order by order_date;
SELECT
    order_date,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- 7️⃣ Show total quantity sold for each item.
select item_name, sum(quantity) as total_quantity
from order_items
group by item_name
order by total_quantity desc ;

-- 8️⃣ Show total revenue per item (price × quantity).
select item_name , sum(price* quantity) as total_revenue
from order_items
group by item_name
order by total_revenue desc;

-- 9️⃣ Show average price per item name (in case same item has different prices).
select item_name, round(avg(price)) as avg_price_per_item
from order_items
group by item_name
order by avg_price_per_item desc;
SELECT
    item_name,
    AVG(price) AS avg_price
FROM order_items
GROUP BY item_name;

-- 🔟 Show number of restaurants per cuisine type.
select cuisine_type , count(*) as no_restaurant
from restaurants 
group by cuisine_type
order by no_restaurant;

-- 1️⃣1️⃣ Show all restaurants, including those with no orders.
select r.restaurant_name, count(o.order_id) as total_order
from restaurants as r
left join orders as o
on r.restaurant_id= o.restaurant_id
group by r.restaurant_name,r.restaurant_id;
SELECT
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders
FROM restaurants r
LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name;

-- 1️⃣2️⃣ List all customers, with their total number of orders (including 0).
select c.first_name, count(o.order_id) as total_orders
from customers as c
left join orders as o
on c.customer_id = o.customer_id
group by c.first_name
order by total_orders desc ;
select c.customer_id,c.first_name,c.last_name ,count(order_id) as total_orders
from orders as o
inner join customers as c
on c.customer_id = o.customer_id 
group by c.customer_id,c.first_name
order by total_orders desc;

-- 1️⃣3️⃣ Find customers who never placed an order.
select c.customer_id, c.first_name, count(o.order_id) as total_order
from customers as c
left join orders as o
on c.customer_id = o.customer_id
group by c.customer_id , c.first_name
having total_order < 1;
select c.customer_id, c.first_name
from customers as c
left join orders as o
on c.customer_id = o.customer_id
where order_id is null;
select c.customer_id, c.first_name, count(o.order_id) as total_order
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
group by c.customer_id, c.first_name
having total_order is null;

-- 1️⃣4️⃣ Find restaurants that never received any order.
select r.restaurant_id , r.restaurant_name
from restaurants as r
left join orders as o
on r.restaurant_id = o.restaurant_id
where o.order_id is null;
select r.restaurant_id , r.restaurant_name, count(order_id) as total_order 
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
group by r.restaurant_id , r.restaurant_name
having total_order < 1;

-- 1️⃣5️⃣ Show all customers with their latest order date (NULL if no order).
select c.customer_id,c.first_name, max(o.order_date) as latest_order_date
from customers as c
left join orders as o
on c.customer_id = o.customer_id
group by c.customer_id, c.first_name
order by latest_order_date desc;
select c.customer_id,c.first_name, max(o.order_date) as latest_order_date
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
group by c.customer_id , c.first_name
order by latest_order_date desc;

-- 1️⃣6️⃣ Show only those items whose total quantity sold > 2.
select item_name, sum(quantity) as total_quantity
from order_items
group by item_name
having total_quantity > 2;
SELECT
    item_name,
    SUM(quantity) AS total_quantity_sold
FROM order_items
GROUP BY item_name
HAVING SUM(quantity) > 2;

-- 1️⃣7️⃣ Show cities with more than 1 customer.
select city , count(*) as total_customer
from customers
group by city
having total_customer > 1;

-- 1️⃣8️⃣ Show customers who placed more than 1 order.
select c.customer_id , c.first_name, count(o.order_id) as total_order
from customers as c
left join orders as o
on c.customer_id = o.customer_id
group by c.customer_id,c.first_name
having total_order > 1;
select c.customer_id , c.first_name, count(o.order_id) as total_order
from orders as o
inner join customers as c
on o.customer_id= c.customer_id
group by c.customer_id , c.first_name
having total_order > 1;

-- 1️⃣9️⃣ Show restaurants whose total revenue > 500.
select r.restaurant_name, sum(oi.price*oi.quantity) as total_revenue
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
inner join order_items as oi
on o.order_id = oi.order_id
group by r.restaurant_name
having sum(oi.price*oi.quantity) > 500;
SELECT
    r.restaurant_name,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY r.restaurant_name
HAVING SUM(oi.price * oi.quantity) > 500;

-- 2️⃣0️⃣ Show items where average price > 250.
select item_name, avg(price) as avg_price
from order_items
group by item_name
having avg(price) > 250;


use food_delivery_demo;

-- 1️⃣ List all customers from Nagpur.
select *
from customers
where city = 'Nagpur';

-- 2️⃣ Show first_name, last_name, and city of all customers.
select first_name,last_name,city
from customers;

-- 3️⃣ Show all restaurants that are not ‘Indian’ cuisine.
select *
from restaurants
where cuisine_type not in ('indian');
select *
from restaurants
where cuisine_type <> 'indian';

-- 4️⃣ Show all items where quantity = 1.
select *
from order_items
where quantity = 1;

-- 5️⃣ Show all orders placed on or after 2024-03-06.
select * 
from orders 
where order_date >= '2024-03-06';

-- 6️⃣ Show all customers sorted by city (A → Z), then first_name.
select first_name,last_name, city
from customers
order by city asc, first_name asc;
SELECT first_name, last_name, city
FROM customers
ORDER BY city ASC, first_name ASC;

-- 7️⃣ Show the 3 most expensive items.
select item_name , price 
from order_items 
order by price desc limit 3;

-- 8️⃣ Show the oldest 2 orders (earliest dates).
select *
from orders 
order by order_date asc limit 2;

-- 9️⃣ Show restaurants sorted by cuisine type (A → Z), then name.
select restaurant_name, cuisine_type 
from restaurants
order by cuisine_type asc , restaurant_name asc ;

-- 🔟 Show the 2 cheapest items with their price and quantity.
select item_name, price, quantity
from order_items
order by price asc limit 2;

-- 1️⃣1️⃣ Show how many orders each customer has placed.
select c.customer_id , c.first_name, count( o.order_id) as total_orders
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
group by c.customer_id
order by total_orders desc ;
select c.customer_id , c.first_name, count(o.order_id) as total_orders
from customers as c
left join orders as o
on c.customer_id = o.customer_id
group by c.customer_id , c.first_name
order by total_orders desc;

-- 1️⃣2️⃣ Show how many orders each restaurant has received.
select r.restaurant_id , r.restaurant_name, count(o.order_id) as total_orders
from restaurants as r
left join orders as o
on r.restaurant_id = o.restaurant_id
group by r.restaurant_id ,r.restaurant_name
order by total_orders desc;
select r.restaurant_id , r.restaurant_name, count(o.order_id) as total_orders
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
group by r.restaurant_id , r.restaurant_name
order by total_orders desc;

-- 1️⃣3️⃣ Show only those restaurants that have received at least 2 orders.

select r.restaurant_id , r.restaurant_name, count(o.order_id) as total_orders
from restaurants as r
left join orders as o
on r.restaurant_id = o.restaurant_id
group by r.restaurant_id, r.restaurant_name
having total_orders = 2;
select r.restaurant_id , r.restaurant_name, count(o.order_id) as total_orders
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
group by r.restaurant_id, r.restaurant_name
having count(o.order_id) >= 2;

-- 1️⃣4️⃣ Show total quantity sold for each item, but only items with quantity > 2 in total.
select item_name, sum(quantity) as total_quantity
from order_items
group by item_name
having sum(quantity) > 2;
SELECT
    item_name,
    SUM(quantity) AS total_quantity
FROM order_items
GROUP BY item_name
HAVING SUM(quantity) > 2;

-- 1️⃣5️⃣ Show cities where there are more than 1 customer.
select city , count(*) as total_customers
from customers 
group by city 
having count(*) > 1;
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
HAVING COUNT(*) > 1;

-- 1️⃣6️⃣ Show each order with customer name and restaurant name.
select o.order_id , c.first_name, r.restaurant_name, o.order_date
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
inner join restaurants as r
on o.restaurant_id = r.restaurant_id;

-- 1️⃣7️⃣ Show each item with its restaurant and order date.
select oi.item_name,oi.price ,r.restaurant_name,o.order_date
from orders as o
inner join  restaurants as r
on o.restaurant_id = r.restaurant_id
inner join order_items as oi
on o.order_id = oi.order_id;

-- 1️⃣8️⃣ Show all customers and their last order date (even if they never ordered).
select c.customer_id, c.first_name, max(o.order_date) as last_order_date
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
group by c.customer_id, c.first_name
order by last_order_date desc;
select c.customer_id, c.first_name, min(o.order_date) as oldest_order_date
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
group by c.customer_id, c.first_name
order by oldest_order_date desc;

-- 1️⃣9️⃣ Classify items as ‘Cheap’, ‘Medium’, ‘Expensive’ based on price.
select item_name, price,
case 
	when price < 200 then 'cheap'
    when price between 200 and 350 then 'medium'
    else 'expensive'
   end as price_category
    from order_items;
    
    -- 2️⃣0️⃣ Classify customers based on how many orders they placed.
    select c.customer_id , c.first_name, count(o.order_id) as total_orders,
    case 
		when count(o.order_id) < 1 then 'no order'
        when count(o.order_id) = 1 then 'first order'
        else 'repeat customer'
        end as customer_category
        from customers as c
        left join orders as o
        on c.customer_id = o.customer_id
        group by c.customer_id ,c.first_name;
        
-- 🔷 21️⃣ Find each item with customer name who ordered it
select oi.item_name, oi.price , c.first_name
from orders as o
inner join order_items as oi
on o.order_id = oi.order_id
inner join customers as c
on o.customer_id = c.customer_id;
select oi.item_name,c.first_name,o.order_date
from order_items as oi
inner join orders as o
on oi.order_id = o.order_id
inner join customers as c
on o.customer_id = c.customer_id;

-- 🔷 22️⃣ Show restaurant name, customer name, and total price (price × quantity
select r.restaurant_name, c.first_name, sum(oi.price*oi.quantity) as total_amount
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
inner join customers as c
on o.customer_id = c.customer_id
inner join order_items as oi
on o.order_id = oi.order_id
group by o.order_id
order by total_amount desc;
SELECT
    r.restaurant_name,
    c.first_name,
    (oi.price * oi.quantity) AS total_amount
FROM order_items oi
JOIN orders o        ON oi.order_id = o.order_id
JOIN restaurants r   ON o.restaurant_id = r.restaurant_id
JOIN customers c     ON o.customer_id = c.customer_id;

-- 🔷 23️⃣ Find which cuisines (Indian/Italian etc.) are generating the most revenue
select r.cuisine_type , sum(oi.price*oi.quantity) as total_revenue
from order_items as oi
inner join orders as o
on oi.order_id = o.order_id
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
group by r.cuisine_type
order by total_revenue desc limit 1;
use food_delivery_demo;
-- 🔷 23️⃣ Find which cuisines (Indian/Italian etc.) are generating the most revenue
select r.cuisine_type , sum(oi.price*oi.quantity) as total_revenue
from order_items as oi
inner join orders as o
on oi.order_id = o.order_id
inner join restaurants as r
on o.restaurant_id =r.restaurant_id
group by r.cuisine_type
order by total_revenue desc limit 1;

-- 1️⃣ Show all customers who are NOT from Delhi.
select *
from customers 
where city not in('delhi');
select *
from customers 
where city <> 'delhi';

-- 2️⃣ Show all restaurants which serve ‘Italian’ or ‘Salad’ cuisine.
select *
from restaurants 
where cuisine_type in('italian','salad');
SELECT *
FROM restaurants
WHERE cuisine_type IN ('Italian', 'Salad');

-- 3️⃣ Show all items where price is less than or equal to 250.
select item_name, price
from order_items 
where price <= 250;

-- 4️⃣ Show customers whose first name ends with 'a'.
select *
from customers
where first_name like "%a";

-- 5️⃣ Show orders between 2024-03-01 and 2024-03-10 (inclusive).
select *
from orders 
where order_date between "2024-03-01" and "2024-03-10" 
order by order_date desc ;

-- 6️⃣ Show all customers sorted by last_name A → Z.
select *
from customers 
order by last_name asc;

-- 7️⃣ Show the 3 most expensive items, with name and price.
select item_name , price 
from order_items
order by price desc limit 3;

-- 8️⃣ Show the 2 earliest (oldest) orders.
select *
from orders 
order by order_date asc limit 2;

-- 9️⃣ Show restaurants sorted by cuisine type, then by restaurant_name.
select *
from restaurants 
order by cuisine_type asc , restaurant_name asc ;
SELECT restaurant_name, cuisine_type
FROM restaurants
ORDER BY cuisine_type ASC, restaurant_name ASC;

-- 🔟 Show the 4 cheapest items.
select item_name , price
from order_items
order by price asc limit 4;

-- 1️⃣1️⃣ Show how many customers are there in each city.
select city , count(*) as total_customers
from customers
group by city 
order by total_customers desc;

-- 1️⃣2️⃣ Show total quantity ordered for each item.
select item_name, sum(quantity) as total_quantity
from order_items
group by item_name
order by total_quantity desc ;

-- 1️⃣3️⃣ Show total revenue per item (price × quantity).
select item_name , sum(price*quantity) as total_revenue
from order_items 
group by item_name
order by total_revenue desc ;

-- 1️⃣4️⃣ Show total orders per customer (only customers who have at least 1 order).
select c.customer_id , c.first_name,  count(o.order_id) as total_orders
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
group by c.customer_id ,c.first_name
order by total_orders desc;
select c.customer_id , c.first_name,  count(o.order_id) as total_orders
from customers as c
left join orders as o
on c.customer_id = o.customer_id
group by c.customer_id , c.first_name
order by total_orders desc ;

-- 1️⃣5️⃣ Show cities where number of customers is more than 1.
select city , count(*) as total_customers
from customers
group by city
having count(*) > 1;
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
HAVING COUNT(*) > 1;

-- 1️⃣6️⃣ Show each order with customer name and city.
select o.order_id , c.first_name ,c.last_name, c.city , o.order_date
from orders as o
inner join customers as c
on o.customer_id = c.customer_id;
select o.order_id , c.first_name ,c.last_name, c.city , o.order_date
from customers as c
left join orders as o
on c.customer_id = o.order_id;
SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    c.city,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 1️⃣7️⃣ Show each order with restaurant name and cuisine type.
select o.order_id , r.restaurant_name, r.cuisine_type, o.order_date
from orders as o
inner join restaurants as r
on o.restaurant_id = r.restaurant_id;

-- 1️⃣8️⃣ Show each order item with item_name, price, customer_name, and restaurant_name.
select oi.item_name,oi.price, c.first_name,c.last_name,r.restaurant_name
from orders as o
inner join order_items as oi
on o.order_id = oi.order_id
inner join customers as c
on o.customer_id = c.customer_id 
inner join restaurants as r
on o.restaurant_id = r.restaurant_id;
SELECT
    oi.item_name,
    oi.price,
    c.first_name AS customer_first_name,
    r.restaurant_name
FROM order_items oi
JOIN orders o       ON oi.order_id = o.order_id
JOIN customers c    ON o.customer_id = c.customer_id
JOIN restaurants r  ON o.restaurant_id = r.restaurant_id;
select oi.item_name,oi.price, c.first_name,r.restaurant_name
from order_items as oi
inner join orders as o
on oi.order_id = o.order_id 
inner join customers as c
on o.customer_id = c.customer_id 
inner join restaurants as r
on o.restaurant_id = r.restaurant_id;


-- 1️⃣9️⃣ Show all customers and their latest order date (even if no orders).
select c.customer_id ,c.first_name, max(o.order_date) as latest_order_date 
from orders as o
inner join customers as c
on o.customer_id = c.customer_id 
group by c.customer_id , c.first_name
order by latest_order_date desc ;
select c.customer_id ,c.first_name,c.last_name, max(o.order_date) as latest_order_date 
from customers as c
left join orders as o
on c.customer_id = o.customer_id
group by c.customer_id , c.first_name, c.last_name
order by latest_order_date desc;

-- 2️⃣0️⃣ Show restaurant-wise total revenue.
select r.restaurant_name, sum(oi.price*oi.quantity) as total_revenue 
from order_items as oi
inner join orders as o
on oi.order_id = o.order_id
inner join restaurants as r
on o.restaurant_id = r.restaurant_id
group by r.restaurant_name
order by total_revenue desc ;
select r.restaurant_name, sum(oi.price*oi.quantity) as total_revenue 
from restaurants as r
inner join orders as o
on r.restaurant_id = o.restaurant_id 
inner join order_items as oi
on o.order_id = oi.order_id
group by r.restaurant_name
order by total_revenue desc ;











