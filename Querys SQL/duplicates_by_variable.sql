SELECT
  'category' AS variable,
  category AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  category

UNION ALL

SELECT
  'city' AS variable,
  city AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  city

UNION ALL

SELECT
  'country' AS variable,
  country AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  country

UNION ALL

SELECT
  'market2' AS variable,
  market2 AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  market2

UNION ALL

SELECT
  'order_priority' AS variable,
  order_priority AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  order_priority

UNION ALL

SELECT
  'ship_mode' AS variable,
  ship_mode AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  ship_mode

UNION ALL

SELECT
  'segment' AS variable,
  segment AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  segment

UNION ALL

SELECT
  'state' AS variable,
  state AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  state

UNION ALL

SELECT
  'sub_category' AS variable,
  sub_category AS value,
  COUNT(*) AS count
FROM
  `etl-superstore-434600.super_store.ventas`
GROUP BY
  sub_category

ORDER BY
  variable, value;
