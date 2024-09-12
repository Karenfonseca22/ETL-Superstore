-- Creation if the dimension table named orders_dim
SELECT
order_id,
city,
region,
sales,
ship_date,
order_date,
year,
weeknum,
ship_mode,
order_priority
FROM `etl-superstore-434600.super_store.ventas`
