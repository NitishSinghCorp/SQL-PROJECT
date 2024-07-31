
create table orders(order_id  int not null
, orderdate date not null
, ordertime time not null);
create table order_details(order_details_id int not null
, order_id int not null
, pizza_id text not null
, quantity int not null);

--  -------------------Basic:  -----------------------------
-- Retrieve the total number of orders placed.  --
select count(order_id) as total_orders 
from orders;

--  Calculate the total revenue generated from pizza sales.

select round(sum(pizzas.price * order_details.quantity),2) as total_revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;


--  Identify the highest-priced pizza. --

select pizza_types.name, pizzas.price as highest_price
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id 
order by pizzas.price desc limit 1;

--  Identify the most common pizza size ordered.

select pizzas.size, sum(order_details.quantity) as total_order
from pizzas join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizzas.size
order by total_order desc;

--  List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name, sum(order_details.quantity) as quantity
from pizza_types 
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name 
order by quantity desc limit 5 ;

-- --------------------------------------Intermediate: ----------------------------------------

--    Join the necessary tables to find the total quantity of each pizza category ordered.  ------

select pizza_types.category, sum(order_details.quantity) as total_quantity
from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by total_quantity desc;


--  Determine the distribution of orders by hour of the day. --

select HOUR(ordertime), count(order_id)
from orders
group by hour(ordertime);

--  Join relevant tables to find the category-wise distribution of pizzas. --

SELECT category, count(name) from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day. --

select avg(quantity) from
(select orders.orderdate, sum(order_details.quantity) as quantity
from orders 
join order_details
on order_details.order_id = orders.order_id
group by orders.orderdate) as order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue. --

select pizza_types.name, sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name 
order by revenue desc limit 3;

-- ------------------------------------------Advanced: -- ----------------------------------------------

-- ------------Calculate the percentage contribution of each pizza type to total revenue. -- -------------------

select pizza_types.name,  
round(sum(order_details.quantity * pizzas.price) / (select round(sum(pizzas.price * order_details.quantity),2) as total_sales
from order_details 
join pizzas
on pizzas.pizza_id = order_details.pizza_id) *100,2 ) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc;

-- ----------------------Analyze the cumulative revenue generated over time. -- ----------------------------

select orderdate, sum(revenue) over(order by orderdate) as cum_revenue
from 
(select orders.orderdate, 
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.orderdate) as sales;

-- --Determine the top 3 most ordered pizza types based on revenue for each pizza category. -- -------------
select name, revenue 
from(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category, pizza_types.name,
sum((order_details.quantity) * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b
where rn <=3;