SELECT 
year AS order_year,
CAST (row_id AS STRING) AS row_id
FROM `etl-superstore-434600.super_store.ventas`
