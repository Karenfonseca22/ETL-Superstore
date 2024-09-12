-- Creation if the fact table (tabla de hechos) named sales_fact, it's foscused in sales
SELECT
order_id,
product_id,
customer_ID,
sales,
shipping_cost,
discount,
quantity,
profit,
 CONCAT(
        LEFT(country, 1), 
        LEFT(market, 1), 
        LEFT(state, 1), 
        LPAD(CAST(ROW_NUMBER() OVER (ORDER BY country) AS STRING), 3, '0')
    ) AS location_register_id
FROM `etl-superstore-434600.super_store.ventas`
