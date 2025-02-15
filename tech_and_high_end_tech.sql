SELECT count(distinct magist.products.product_id) AS products FROM magist.products;

SELECT count(distinct magist.products.product_id) AS TechProducts FROM magist.products
    WHERE magist.products.product_category_name in ('audio', 'consoles_games', 'eletronicos', 'pcs', 'informatica_acessorios', 'pc_gamer', 'telefonia');
    
SELECT count(distinct magist.products.product_id) AS highEndTech
	FROM magist.products INNER JOIN magist.order_items ON magist.products.product_id = magist.order_items.product_id
    WHERE magist.products.product_category_name in ('audio', 'consoles_games', 'eletronicos', 'pcs', 'informatica_acessorios', 'pc_gamer', 'telefonia')
		AND magist.order_items.price > 300;
        
SELECT sum(magist.order_items.price) AS revenue
	FROM magist.products INNER JOIN magist.order_items ON magist.products.product_id = magist.order_items.product_id;

SELECT sum(magist.order_items.price) AS techRevenue
	FROM magist.products INNER JOIN magist.order_items ON magist.products.product_id = magist.order_items.product_id
    WHERE magist.products.product_category_name in ('audio', 'consoles_games', 'eletronicos', 'pcs', 'informatica_acessorios', 'pc_gamer', 'telefonia');
    
SELECT sum(magist.order_items.price) AS highEndTechRevenue
	FROM magist.products INNER JOIN magist.order_items ON magist.products.product_id = magist.order_items.product_id
    WHERE magist.products.product_category_name in ('audio', 'consoles_games', 'eletronicos', 'pcs', 'informatica_acessorios', 'pc_gamer', 'telefonia')
		AND magist.order_items.price > 300;
 
SELECT year(magist.orders.order_purchase_timestamp) AS y,
		month(magist.orders.order_purchase_timestamp) as m,
        count(DISTINCT magist.orders.order_id) AS OrdersPerMonth, sum(magist.order_items.price) AS IncomePerMonth
	FROM magist.orders LEFT JOIN magist.order_items ON magist.orders.order_id = magist.order_items.order_id
	GROUP BY y, m
    ORDER BY y, m;

SELECT year(magist.orders.order_purchase_timestamp) AS y,
		month(magist.orders.order_purchase_timestamp) as m,
        count(DISTINCT magist.orders.order_id) AS TechOrdersPerMonth, sum(magist.order_items.price) AS TechIncomePerMonth
	FROM (magist.orders INNER JOIN magist.order_items ON magist.orders.order_id = magist.order_items.order_id)
		INNER JOIN magist.products ON magist.order_items.product_id = magist.products.product_id
    WHERE magist.products.product_category_name in ('audio', 'consoles_games', 'eletronicos', 'pcs', 'informatica_acessorios', 'pc_gamer', 'telefonia')
	GROUP BY y, m
    ORDER BY y, m;

SELECT year(magist.orders.order_purchase_timestamp) AS y,
		month(magist.orders.order_purchase_timestamp) as m,
        count(DISTINCT magist.orders.order_id) AS HighEndTechOrdersPerMonth,
        sum(magist.order_items.price) AS HighEndTechIncomePerMonth
	FROM (magist.orders INNER JOIN magist.order_items ON magist.orders.order_id = magist.order_items.order_id)
		INNER JOIN magist.products ON magist.order_items.product_id = magist.products.product_id
    WHERE magist.products.product_category_name in ('audio', 'consoles_games', 'eletronicos', 'pcs', 'informatica_acessorios', 'pc_gamer', 'telefonia')
		AND magist.order_items.price > 300
	GROUP BY y, m
    ORDER BY y, m;
    
select
	case
		when (time_to_sec(timediff(order_delivered_customer_date,
						order_estimated_delivery_date))) >86400 then "The deliveries were delayed"
		when (time_to_sec(timediff(order_delivered_customer_date,
						order_estimated_delivery_date))) between -86400 and 86400 then "The deliveries were on time"
		else "The deliveries were early"
	end as delivery_time_windows,
    count(distinct magist.orders.order_id) as delivery_count
from (magist.orders LEFT JOIN magist.order_items ON magist.order_items.order_id = magist.orders.order_id)
	LEFT JOIN magist.products ON magist.order_items.product_id = magist.products.product_id
    WHERE magist.products.product_category_name in ('audio', 'consoles_games', 'eletronicos', 'pcs', 'informatica_acessorios', 'pc_gamer', 'telefonia')
group by delivery_time_windows;

select
	case
		when (time_to_sec(timediff(order_delivered_customer_date,
						order_estimated_delivery_date))) >86400 then "The deliveries were delayed"
		when (time_to_sec(timediff(order_delivered_customer_date,
						order_estimated_delivery_date))) between -86400 and 86400 then "The deliveries were on time"
		else "The deliveries were early"
	end as delivery_time_windows,
    count(distinct magist.orders.order_id) as delivery_count
from (magist.orders LEFT JOIN magist.order_items ON magist.order_items.order_id = magist.orders.order_id)
	LEFT JOIN magist.products ON magist.order_items.product_id = magist.products.product_id
    WHERE magist.products.product_category_name in ('audio', 'consoles_games', 'eletronicos', 'pcs', 'informatica_acessorios', 'pc_gamer', 'telefonia')
		and magist.order_items.price > 300
group by delivery_time_windows;