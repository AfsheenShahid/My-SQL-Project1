-- What’s the average time between the order being placed and the product being delivered?
select order_purchase_timestamp, order_delivered_customer_date
from orders;

select 
timestampdiff('order_purchase_timestamp', 'order_delivered_customer_date') as Avg_delivery_time
from orders;

select distinct order_id as order_number, 
date(order_purchase_timestamp) as order_date,
date(order_delivered_customer_date)as delivery_date,
datediff(order_delivered_customer_date, order_purchase_timestamp) Avg_delivery_time_days
from orders;

select
avg(datediff(order_delivered_customer_date, order_purchase_timestamp)) Avg_delivery_time_days
from orders;

-- avg delivery time for all orders = 12.5035 days

-- How many orders are delivered on time vs orders delivered with a delay?
select count(distinct order_id) as order_number,
case
when datediff(order_delivered_customer_date, order_purchase_timestamp) >20 Then 'super late delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) >10 and datediff(order_delivered_customer_date, order_purchase_timestamp) <=20 Then 'standard time delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) <=10 Then 'fast delivery'
else 'not delivered'
end as Delivery_speed
from orders
group by Delivery_speed;

select distinct order_id as order_number, 
datediff(order_delivered_customer_date, order_purchase_timestamp) as Avg_delivery_time_days,
order_status,
case
when datediff(order_delivered_customer_date, order_purchase_timestamp) >12.5 Then 'late delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) <=12.5 Then 'standard time delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) < 10 Then 'fast delivery'
else 'just delivered'
end as Delivery_speed
from orders
where order_status='delivered';


 -- Is there any pattern for delayed orders, e.g. big products being delayed more often?
-- order_status, count(distinct order_status) as number_of_orders, 
select distinct product_id, product_length_cm*product_height_cm*product_width_cm as product_size,
(case
when product_weight_g > 500 then 'heavy product'
else 'light product'
end) as product_type,
(case 
when product_length_cm*product_height_cm*product_width_cm > 500 then 'big_product'
when product_length_cm*product_height_cm*product_width_cm < 500 and product_length_cm*product_height_cm*product_width_cm >= 200 then 'medium size product'
else 'small product'
end) as product_size_type
from products
group by product_id
order by product_size_type desc;

select count(distinct product_id) as products_in_p,
case
when product_weight_g > 500 then 'big product'
else 'small product'
end as product_type
from products
group by product_type;

select distinct p.product_category_name, count(o.order_status) as number_of_orders, product_length_cm*product_height_cm*product_width_cm as product_size,
(case
when product_weight_g >= 300 then 'big product'
else 'light product'
end) as product_description,
(case
when datediff(order_delivered_customer_date, order_purchase_timestamp) >20 Then 'super late delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) >10 and datediff(order_delivered_customer_date, order_purchase_timestamp) <=20 Then 'standard time delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) <=10 Then 'fast delivery'
else 'not delivered'
end) as Delivery_speed
from products as p
left join order_items as oi on p.product_id = oi.product_id
left join orders as o on oi.order_id = o.order_id
group by o.order_status, product_description, Delivery_speed, product_category_name, product_size
order by product_description, Delivery_speed;

