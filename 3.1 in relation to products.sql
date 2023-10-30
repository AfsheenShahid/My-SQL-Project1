-- What categories of tech products does Magist have?
select distinct product_category_name
from products;
select distinct product_category_name, count(distinct product_id) 
from products
where product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by product_category_name;

select count(distinct product_id) as number_of_products, product_category_name as Product_category
from products
where product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by Product_category;

-- How many products of these tech categories have been sold (within the time window of the database snapshot)? What percentage does that represent from the overall number of products sold?
select p.product_category_name as Product_category, count(distinct p.product_id) as numberofproducts_in_category, count(distinct ot.order_id) as Products_sold  
from order_items as ot
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by Product_category;

select p.product_category_name as Product_category, count(distinct p.product_id) as numberofproducts_in_category, sum(ot.order_item_id) as Products_sold  -- ordr_item_id calculate number of items within order_id as well
from order_items as ot
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by Product_category;


-- How many products sold overall in all categories
select p.product_category_name as Product_category, count(distinct p.product_id) as numberofproducts_in_category, count(distinct ot.order_id) as Products_sold  
from order_items as ot
left join products as p on ot.product_id = p.product_id
group by Product_category;

select sum(ot.order_item_id) as sold_products, p.product_category_name as Product_category
from order_items as ot
left join products as p on ot.product_id = p.product_id
group by Product_category;

select sum(order_item_id) as total_sold_products
from order_items;
select sum(ot.order_item_id) as total_sold_products
from order_items ot
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia');

-- What percentage does that represent from the overall number of products sold?
-- total sold products = 134936
-- total sold tech products = 20309
SELECT(20309/134936*100); -- --> 15.0508%
-- perecentage from oevrall products sold can not be calculated.

-- What’s the average price of the products being sold? of all products
select avg(price)
from order_items;

-- of tech products?
select avg(price)
from order_items as ot
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia');

-- what is popular? the products being sold more , meaning with higher count of order_item_id per order_id. expensive tech product not much popular if taken price individually, popular with avg and max price in each category.
select sum(ot.order_item_id) as sold_products, p.product_category_name as Product_category, ot.price as Price,
case
when sum(ot.order_item_id) > 100 then 'popular'
when sum(ot.order_item_id) <= 100 then 'not much popular'
else 'not popular'
end as popularity
from order_items as ot
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by Product_category, Price
order by Price desc;


select sum(ot.order_item_id) as sold_products, p.product_category_name as Product_category, avg(ot.price) as Avg_Price,
case
when sum(ot.order_item_id) > 100 then 'popular'
when sum(ot.order_item_id) <= 100 then 'not much popular'
else 'not popular'
end as popularity
from order_items as ot
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by Product_category
order by Avg_Price desc;


select sum(ot.order_item_id) as sold_products, p.product_category_name as Product_category, max(ot.price) as Max_Price,
case
when sum(ot.order_item_id) > 100 then 'popular'
when sum(ot.order_item_id) <= 100 then 'not much popular'
else 'not popular'
end as popularity
from order_items as ot
left join products as p on ot.product_id = p.product_id
where p.product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia')
group by Product_category
order by Max_Price desc;

CREATE TEMPORARY TABLE Tech_products_order AS
SELECT order_id, order_item_id, product_id, seller_id
from order_items;

select * from Tech_products_order;


-- Create a temporary table with data subset
CREATE TEMPORARY TABLE Tech_products AS
SELECT product_category_name, product_id
from products
where product_category_name IN ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia');

select product_category_name, count(distinct product_id) as total_products
from Tech_products
group by product_category_name;