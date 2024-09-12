-- Creation of a dimension table named location_dim
SELECT
CONCAT(
        LEFT(country, 1), 
        LEFT(market2, 1), 
        LEFT(state, 1), 
        LPAD(CAST(ROW_NUMBER() OVER (ORDER BY country) AS STRING), 3, '0')
    ) AS location_register_id,
    country,
    market2,
    state
FROM 
    `etl-superstore-434600.super_store.ventas`
