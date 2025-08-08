SELECT
  product_type,
  product_description,
  reason_for_recall,
  recall_initiation_date
FROM
  `bigquery-public-data.fda_food.food_enforcement`
WHERE
  recall_initiation_date IS NOT NULL
ORDER BY
  recall_initiation_date DESC
LIMIT 10;
