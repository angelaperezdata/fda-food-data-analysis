SELECT
  product_type,
  classification,
  COUNT(*) AS recall_count
FROM
  `bigquery-public-data.fda_food.food_enforcement`
WHERE
  product_type IN (
    SELECT product_type
    FROM `bigquery-public-data.fda_food.food_enforcement`
    GROUP BY product_type
    ORDER BY COUNT(*) DESC
    LIMIT 10
  )
GROUP BY
  product_type, classification
ORDER BY
  product_type, classification;
