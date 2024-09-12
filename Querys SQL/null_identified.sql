SELECT
  SUM(CASE
      WHEN category IS NULL THEN 1
      ELSE 0
  END
    ) AS null_category,
  SUM (CASE
      WHEN city IS NULL THEN 1
      ELSE 0
  END
    ) AS null_city,
  SUM (CASE
      WHEN country IS NULL THEN 1
      ELSE 0
  END
    ) AS null_country,
  SUM(CASE
      WHEN customer_ID IS NULL THEN 1
      ELSE 0
  END
    ) AS null_customerID,
  SUM (CASE
      WHEN customer_name IS NULL THEN 1
      ELSE 0
  END
    ) AS null_customer_name,
  SUM (CASE
      WHEN discount IS NULL THEN 1
      ELSE 0
  END
    ) AS null_discount,
  SUM (CASE
      WHEN market IS NULL THEN 1
      ELSE 0
  END
    ) AS null_market,
  SUM(CASE
      WHEN unknown IS NULL THEN 1
      ELSE 0
  END
    ) AS null_unknown,
  SUM(CASE
      WHEN order_date IS NULL THEN 1
      ELSE 0
  END
    ) AS null_order_date,
  SUM (CASE
      WHEN order_id IS NULL THEN 1
      ELSE 0
  END
    ) AS null_order_id,
  SUM(CASE
      WHEN order_priority IS NULL THEN 1
      ELSE 0
  END
    ) AS null_orer_priority,
  SUM(CASE
      WHEN product_id IS NULL THEN 1
      ELSE 0
  END
    ) AS null_productID,
  SUM (CASE
      WHEN product_name IS NULL THEN 1
      ELSE 0
  END
    ) AS null_productname,
  SUM(CASE
      WHEN profit IS NULL THEN 1
      ELSE 0
  END
    ) AS null_profit,
  SUM(CASE
      WHEN quantity IS NULL THEN 1
      ELSE 0
  END
    ) AS null_quiantity,
  SUM(CASE
      WHEN region IS NULL THEN 1
      ELSE 0
  END
    ) AS null_region,
  SUM(CASE
      WHEN row_id IS NULL THEN 1
      ELSE 0
  END
    ) AS null_rowid,
  SUM(CASE
      WHEN sales IS NULL THEN 1
      ELSE 0
  END
    ) AS null_sales,
  SUM(CASE
      WHEN segment IS NULL THEN 1
      ELSE 0
  END
    ) AS null_segment,
  SUM(CASE
      WHEN ship_date IS NULL THEN 1
      ELSE 0
  END
    ) AS null_ship_date,
  SUM(CASE
      WHEN ship_mode IS NULL THEN 1
      ELSE 0
  END
    ) AS null_ship_mode,
  SUM(CASE
      WHEN shipping_cost IS NULL THEN 1
      ELSE 0
  END
    ) AS null_shipping_cost,
  SUM(CASE
      WHEN state IS NULL THEN 1
      ELSE 0
  END
    ) AS null_state,
  SUM(CASE
      WHEN sub_category IS NULL THEN 1
      ELSE 0
  END
    ) AS null_sub_category,
  SUM(CASE
      WHEN year IS NULL THEN 1
      ELSE 0
  END
    ) AS null_year,
  SUM(CASE
      WHEN market2 IS NULL THEN 1
      ELSE 0
  END
    ) AS null_market2,
  SUM(CASE
      WHEN weeknum IS NULL THEN 1
      ELSE 0
  END
    ) AS null_weeknum
FROM
  `etl-superstore-434600.super_store.ventas`
