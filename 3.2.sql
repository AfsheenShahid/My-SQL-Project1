-- How many months of data are included in the magist database?
select month(order_purchase_timestamp) as order_month,
year (order_purchase_timestamp) as Order_Year
from orders
group by Order_Year, Order_month
order by Order_Year;

-- SELECT(476/3095*100); -- --> 15.3796%

select count(distinct month(order_purchase_timestamp)) as order_months,
year (order_purchase_timestamp) as Order_Year
from orders
group by Order_Year
order by Order_Year;

-- MIN(order_pruchase_timestamp)
-- MAX(order_purchase_timestamp)

-- How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?
select count(distinct seller_id)
from order_items;

select count(distinct ot.seller_id)
from order_items as ot
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia');

-- total sellers = 3095
-- tech sellers = 511

select(511/3095*100); -- --->16.5105%

-- What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?
-- total amount earned by all sellers = 16008872
-- total amount earned by tech sellers = 2937658
select truncate(sum(payment_value), 0) as total_earning
from order_payments;
select truncate(sum(payment_value), 0) as total_earning
from order_payments as op
left join order_items as ot on op.order_id = ot.order_id
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia');

-- Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?

-- total order months = 25(3 in 2016, 12 in 2017, 10 in 2018)
-- avg income = total income /sellers/months
-- average monthly income of all sellers = total amount earned by all sellers(16008872)/ number of sellers/ number of months 25 -- ---->206.89979968
-- average monthly income of tech sellers = total amount earned by tech sellers (2937658)/ number of tech sellers/ number of months 25 --  ----> 229.95365949
select (2937658/511/25);

select month(shipping_limit_date) as order_month, seller_id, avg(price)
from order_items
group by seller_id, order_month;

select count(distinct seller_id)
from order_items;

