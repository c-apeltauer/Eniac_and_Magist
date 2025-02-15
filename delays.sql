SELECT magist.geo.zip_code_prefix, magist.geo.city, count(magist.orders.order_id) AS totalOrders,
	sum(CASE
		WHEN time_to_sec(timediff(magist.orders.order_delivered_customer_date, magist.orders.order_estimated_delivery_date)) > 86400 THEN 1
        ELSE 0
        END
	) AS delayedOrders,
    100 * sum(CASE
		WHEN time_to_sec(timediff(magist.orders.order_delivered_customer_date, magist.orders.order_estimated_delivery_date)) > 86400 THEN 1
        ELSE 0
        END
	) / count(magist.orders.order_id) AS delayedPercentage
    FROM
	(magist.orders INNER JOIN magist.customers ON magist.orders.customer_id = magist.customers.customer_id)
    INNER JOIN magist.geo ON magist.geo.zip_code_prefix = magist.customers.customer_zip_code_prefix
    GROUP BY magist.geo.zip_code_prefix
    ORDER BY delayedPercentage DESC;
    
SELECT
    100 * sum(CASE
		WHEN time_to_sec(timediff(magist.orders.order_delivered_customer_date, magist.orders.order_estimated_delivery_date)) > 86400 THEN 1
        ELSE 0
        END
	) / count(magist.orders.order_id) AS delayedPercentage
    FROM
	(magist.orders INNER JOIN magist.customers ON magist.orders.customer_id = magist.customers.customer_id)
    INNER JOIN magist.geo ON magist.geo.zip_code_prefix = magist.customers.customer_zip_code_prefix
;