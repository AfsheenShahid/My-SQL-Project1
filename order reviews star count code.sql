SELECT * FROM magist.order_reviews;

select distinct order_id, sum(distinct review_score) as review_score
from order_reviews
group by order_id;

select avg(review_score), product_category_name
from order_reviews as o_r
left join order_items as oi on o_r.order_id = oi.order_id
left join products as p on oi.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by product_category_name;

select count(distinct o.order_id) as order_number, 
datediff(order_delivered_customer_date, order_purchase_timestamp) as Avg_delivery_time_days,
order_status,
case
when datediff(order_delivered_customer_date, order_purchase_timestamp) >30 Then 'No delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) >12.5 Then 'late delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) >8 and datediff(order_delivered_customer_date, order_purchase_timestamp) <=12.5 Then 'standard time delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) >3 and datediff(order_delivered_customer_date, order_purchase_timestamp) <=8 Then 'fast delivery'
else 'Fast Delivery'
end as Delivery_speed
from orders as o
left join order_items as oi on o.order_id = oi.order_id
left join products as p on p.product_id = oi.product_id
where order_status='delivered' and p.product_category_name in ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by Delivery_speed, Avg_Delivery_time_days;



select avg(review_score)
from order_reviews;

select count(distinct o.order_id) as order_number, p.product_category_name,
case
when datediff(order_delivered_customer_date, order_purchase_timestamp) >20 Then 'super late delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) >10 and datediff(order_delivered_customer_date, order_purchase_timestamp) <=20 Then 'standard time delivery'
when datediff(order_delivered_customer_date, order_purchase_timestamp) <=10 Then 'fast delivery'
else 'not delivered'
end as Delivery_speed
from orders as o
left join order_items as oi on o.order_id = oi.order_id
left join products as p on p.product_id = oi.product_id
-- where p.product_category_name in ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by Delivery_speed, p.product_category_name;


select
avg(datediff(order_delivered_customer_date, order_purchase_timestamp)) Avg_delivery_time_days
from orders as o
left join order_items as oi on o.order_id = oi.order_id
left join products as p on p.product_id = oi.product_id
where p.product_category_name in ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia');
