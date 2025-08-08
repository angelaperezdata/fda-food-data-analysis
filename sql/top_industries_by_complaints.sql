SELECT 
products_industry_name, 
COUNT(report_number) AS count_reports
FROM bigquery-public-data.fda_food.food_events
GROUP BY products_industry_name
ORDER BY count_reports DESC
LIMIT 10;
