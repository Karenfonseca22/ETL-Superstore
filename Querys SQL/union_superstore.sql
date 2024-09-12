-- Union if the dimension tables and the fact table
WITH Orders AS (
    SELECT sf.customer_id,
           sf.order_id,
           pr.category,
           o.order_date,
           sf.product_id,
           sf.profit,
           sf.location_register_id,
           o.year,
           lo.market2,
           o.ship_date,
           o.ship_mode,
           sf.shipping_cost,
           sf.discount,
           o.order_priority,
           ROW_NUMBER() OVER (PARTITION BY sf.customer_id ORDER BY o.order_date ASC) AS rn_first,
           ROW_NUMBER() OVER (PARTITION BY sf.customer_id ORDER BY o.order_date DESC) AS rn_last
    FROM `etl-superstore-434600.super_store.sales_fact` AS sf
    LEFT JOIN `etl-superstore-434600.super_store.orders_dim` AS o
           ON sf.order_id = o.order_id
    LEFT JOIN `etl-superstore-434600.super_store.product_dim` AS pr
           ON sf.product_id = pr.product_id
    LEFT JOIN `etl-superstore-434600.super_store.location_dim` AS lo
           ON sf.location_register_id = lo.location_register_id
),
FirstLastCategories AS (
    SELECT customer_id,
           MAX(CASE WHEN rn_first = 1 THEN category END) AS first_category,
           MAX(CASE WHEN rn_last = 1 THEN category END) AS last_category,
           MAX(CASE WHEN rn_first = 1 THEN profit END) AS first_profit,
           MAX(CASE WHEN rn_last = 1 THEN profit END) AS last_profit,
           MAX(CASE WHEN rn_first = 1 THEN year END) AS first_order_year,
           MAX(CASE WHEN rn_last = 1 THEN year END) AS last_order_year,
           MAX(CASE WHEN rn_first = 1 THEN market2 END) AS first_market,
           MAX(CASE WHEN rn_last = 1 THEN market2 END) AS last_market,
           MAX(CASE WHEN rn_first = 1 THEN ship_date END) AS first_ship_date,
           MAX(CASE WHEN rn_last = 1 THEN ship_date END) AS last_ship_date,
           MAX(CASE WHEN rn_first = 1 THEN ship_mode END) AS first_ship_mode,
           MAX(CASE WHEN rn_last = 1 THEN ship_mode END) AS last_ship_mode,
           MAX(CASE WHEN rn_first = 1 THEN order_priority END) AS first_order_priority,
           MAX(CASE WHEN rn_last = 1 THEN order_priority END) AS last_order_priority
    FROM Orders
    GROUP BY customer_id
),
CustomerAggregates AS (
    SELECT customer_id,
           SUM(quantity) AS total_quantity,
           AVG(sales) AS avg_sales,
           AVG(shipping_cost) AS avg_ship_cost,
           AVG(discount) AS avg_discount
    FROM `etl-superstore-434600.super_store.sales_fact`
    GROUP BY customer_id
)

SELECT sf.customer_id,
       cu.customer_name,
       cu.segment,
       MIN(o.order_date) AS first_order_date,
       ARRAY_AGG(sf.order_id ORDER BY o.order_date ASC LIMIT 1)[OFFSET(0)] AS first_order_id,
       MAX(o.order_date) AS last_order_date,
       ARRAY_AGG(sf.order_id ORDER BY o.order_date DESC LIMIT 1)[OFFSET(0)] AS last_order_id,
       fc.first_category,
       fc.last_category,
       fc.first_profit,
       fc.last_profit,
       fc.first_order_year,
       fc.last_order_year,
       fc.first_market,
       fc.last_market,
       ca.total_quantity,
       ca.avg_sales,
       fc.first_ship_date,
       fc.last_ship_date,
       fc.first_ship_mode,
       fc.last_ship_mode,
       ca.avg_ship_cost,
       ca.avg_discount,
       fc.first_order_priority,
       fc.last_order_priority
FROM `etl-superstore-434600.super_store.sales_fact` AS sf
LEFT JOIN `etl-superstore-434600.super_store.orders_dim` AS o
       ON sf.order_id = o.order_id
LEFT JOIN `etl-superstore-434600.super_store.customer_dim` AS cu
       ON sf.customer_id = cu.customer_id
LEFT JOIN `etl-superstore-434600.super_store.location_dim` AS lo
       ON sf.location_register_id = lo.location_register_id
LEFT JOIN FirstLastCategories AS fc
       ON sf.customer_id = fc.customer_id
LEFT JOIN CustomerAggregates AS ca
       ON sf.customer_id = ca.customer_id
GROUP BY sf.customer_id, cu.customer_name, cu.segment, fc.first_category, fc.last_category, fc.first_profit, fc.last_profit, fc.first_order_year, fc.last_order_year, fc.first_market, fc.last_market, ca.total_quantity, ca.avg_sales, fc.first_ship_date, fc.last_ship_date, fc.first_ship_mode, fc.last_ship_mode, ca.avg_ship_cost, ca.avg_discount, fc.first_order_priority, fc.last_order_priority
