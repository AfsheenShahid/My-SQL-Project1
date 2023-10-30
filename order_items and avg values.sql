SELECT * FROM magist.order_items;

select count(distinct oi.order_id) order_id, avg(price) 
from order_items as oi
left join orders as o on oi.order_id = o.order_id
left join products as p on p.product_id = oi.product_id
where p.product_category_name in ('audio','consoles_games','eletronicos','informatica_acessorios','pc_gamer','pcs','sinalizacao_e_seguranca','telefonia');
