
SELECT DISTINCT
    industry_category,
    year_from,
    avg_wages,
   CASE
        WHEN t.year_from = (SELECT MIN(year_from) FROM t_frantisek_sladek_project_sql_primary_final WHERE industry_category = t.industry_category)
        THEN NULL 
  	ELSE avg_wages- 
            (SELECT DISTINCT avg_wages
             FROM t_frantisek_sladek_project_sql_primary_final
             WHERE industry_category = t.industry_category 
               AND year_from = t.year_from - 1) 
   END AS avg_wages_difference   
FROM t_frantisek_sladek_project_sql_primary_final AS t
HAVING avg_wages_difference<0
ORDER BY industry_category, year_from;

