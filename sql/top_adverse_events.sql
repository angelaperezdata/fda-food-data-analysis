SELECT
  reactions AS reaction_name,
  COUNT(*) AS total_reports
FROM
  `bigquery-public-data.fda_food.food_events`
GROUP BY
  reaction_name
ORDER BY
  total_reports DESC
LIMIT 10;
