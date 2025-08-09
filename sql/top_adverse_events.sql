WITH cleaned_reactions AS (
  SELECT
    UPPER(TRIM(reaction)) AS reaction_name,
    COUNT(*) AS total_reports
  FROM
    `bigquery-public-data.fda_food.food_events`,
    UNNEST(SPLIT(reactions, ',')) AS reaction
  WHERE
    reaction IS NOT NULL
    AND TRIM(reaction) != ''
  GROUP BY
    reaction_name
),

corrected_reactions AS (
  SELECT
    CASE
      WHEN reaction_name = 'DIARRHOEA' THEN 'DIARRHEA'
      WHEN reaction_name = 'VOMITTING' THEN 'VOMITING'
      WHEN reaction_name = 'MALAISA' THEN 'MALAISE'       -- common typo example
      WHEN reaction_name = 'DYSGEUSIA' THEN 'DYSGEUSIA' 
      WHEN reaction_name = 'DYSPNOEA' THEN  'DYSPNEA'
      WHEN REGEXP_CONTAINS(reaction_name, r'ABDOMINAL PAIN') THEN 'ABDOMINAL PAIN'
       -- keeping medical terms as is
      -- Add more corrections here as needed
      ELSE reaction_name
    END AS reaction_name,
    total_reports
  FROM
    cleaned_reactions
)

SELECT
  reaction_name,
  SUM(total_reports) AS total_reports
FROM
  corrected_reactions
GROUP BY
  reaction_name
ORDER BY
  total_reports DESC
LIMIT 10;
