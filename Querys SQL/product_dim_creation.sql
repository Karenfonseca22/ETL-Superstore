-- Creation if the dimension table named product_dim

SELECT
product_id,
product_name,
category,
sub_category
FROM `etl-superstore-434600.super_store.ventas`
