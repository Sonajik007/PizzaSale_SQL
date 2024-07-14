-- Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS Total_Order 
FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS Total_Revenue
FROM
    orders_details
    JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, 
    pizzas.price
FROM
    pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY 
    pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(orders_details.order_details_id) AS total_count
FROM
    pizzas
    JOIN orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY 
    pizzas.size
ORDER BY 
    total_count DESC 
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, 
    SUM(orders_details.quantity) AS quantities
FROM
    pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id 
GROUP BY 
    pizza_types.name 
ORDER BY 
    quantities DESC 
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.category
ORDER BY 
    quantity DESC;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, 
    COUNT(name) AS pizza_count
FROM
    pizza_types
GROUP BY 
    category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) AS Avg_pizza_per_day
FROM
    (SELECT 
        orders.order_date, 
        SUM(orders_details.quantity) AS quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY 
        orders.order_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name,
    SUM(orders_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.name
ORDER BY 
    revenue DESC
LIMIT 3;
