--- Discrepancias en variables numericas
--- Encontrar filas con caracteres no válidos en las columnas discount, profit, quantity, sales, shipping_cost, weeknum (sin contar el signo negativo)
SELECT
  discount, profit, quantity, sales, shipping_cost, weeknum
FROM
  `etl-superstore-434600.super_store.ventas`
WHERE
  REGEXP_CONTAINS(CAST(discount AS STRING), r'[^0-9.-]')
  OR REGEXP_CONTAINS(CAST(profit AS STRING), r'[^0-9.-]')
  OR REGEXP_CONTAINS(CAST(quantity AS STRING), r'[^0-9.-]')
  OR REGEXP_CONTAINS(CAST(sales AS STRING), r'[^0-9.-]')
  OR REGEXP_CONTAINS(CAST(shipping_cost AS STRING), r'[^0-9.-]')
  OR REGEXP_CONTAINS(CAST(weeknum AS STRING), r'[^0-9.-]')
