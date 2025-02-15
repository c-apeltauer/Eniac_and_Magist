select distinct magist.customers.customer_id, magist.customers.customer_zip_code_prefix
	from (((magist.customers INNER JOIN magist.orders ON magist.customers.customer_id= magist.orders.customer_id)
        INNER JOIN magist.order_items ON magist.order_items.order_id = magist.orders.order_id)
		INNER JOIN magist.products ON magist.products.product_id = magist.order_items.product_id)
        INNER JOIN magist.product_category_name_translation ON magist.product_category_name_translation.product_category_name = magist.products.product_category_name
	where magist.product_category_name_translation.product_category_name_english in ('audio',
'computers',
'computers_accessories',
'consoles_games',
'electronics',
'pc_gamer',
'telephony');
