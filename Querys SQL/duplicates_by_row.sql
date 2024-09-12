-- dejado por fuera:
-- shipping cost, profit y row_id
WITH duplicated_rows AS (
  SELECT
    category,
    city,
    country,
    customer_ID,
    customer_name,
    CAST(discount AS STRING) AS discount,
    market,
    unknown,
    order_date,
    order_id,
    order_priority,
    product_id,
    product_name,


    CAST(quantity AS STRING) AS quantity,
    region,
    CAST(sales AS STRING) AS sales,
    segment,
    ship_date,
    ship_mode,


    state,
    sub_category,
    year,
    market2,
    weeknum,
    row_id,
    COUNT(*) OVER (PARTITION BY
      category,
      city,
      country,
      customer_ID,
      customer_name,
      CAST(discount AS STRING),
      market,
      unknown,
      order_date,
      order_id,
      order_priority,
      product_id,
      product_name,


      CAST(quantity AS STRING),
      region,
      CAST(sales AS STRING),
      segment,
      ship_date,
      ship_mode,


      state,
      sub_category,
      year,
      market2,
      weeknum
    ) AS num_appearances,
    ROW_NUMBER() OVER (PARTITION BY
      category,
      city,
      country,
      customer_ID,
      customer_name,
      CAST(discount AS STRING),
      market,
      unknown,
      order_date,
      order_id,
      order_priority,
      product_id,
      product_name,
      CAST(quantity AS STRING),
      region,
      CAST(sales AS STRING),
      segment,
      ship_date,
      ship_mode,


      state,
      sub_category,
      year,
      market2,
      weeknum
    ORDER BY row_id) AS aparicion
  FROM 
        `etl-superstore-434600.super_store.ventas`
)


SELECT
  row_id,
    CONCAT('aparicion_', aparicion) AS aparicion,
  category,
  city,
  country,
  customer_ID,
  customer_name,
  discount,
  market,
  unknown,
  order_date,
  order_id,
  order_priority,
  product_id,
  product_name,
  quantity,
  region,
  sales,
  segment,
  ship_date,
  ship_mode,
  state,
  sub_category,
  year,
  market2,
  weeknum,
  num_appearances
FROM
  duplicated_rows
WHERE
  num_appearances > 1
ORDER BY
  category, city, country, customer_ID, customer_name, discount, market, unknown, order_date, order_id, order_priority, product_id, product_name,  quantity, region, sales, segment, ship_date, ship_mode,  state, sub_category, year, market2, weeknum, aparicion;
