WITH difference AS (
    SELECT
    	year_from,
        t.avg_price - (
            SELECT avg_price
            FROM t_frantisek_sladek_project_sql_primary_final AS t_prev
            WHERE t_prev.price_category = t.price_category
              AND t_prev.year_from = t.year_from - 1
            LIMIT 1
        ) AS annual_price_difference,
        t.avg_wages  - (
            SELECT avg_wages
            FROM t_frantisek_sladek_project_sql_primary_final AS t_prev
            WHERE t_prev.industry_category = t.industry_category
              AND t_prev.year_from = t.year_from - 1
            LIMIT 1
        ) AS annual_wage_difference
    FROM t_frantisek_sladek_project_sql_primary_final AS t
)
SELECT
    t.avg_price,
    t.year_from,
    t.price_category,
    t.price_value,
    t.price_unit,
    df.annual_price_difference,
	ROUND((t.avg_price- annual_price_difference)/t.avg_price, 2) AS percentage_price_difference,
    df.annual_wage_difference,
    ROUND((t.avg_wages- annual_wage_difference)/t.avg_wages, 2) AS percentage_wage_difference
FROM t_frantisek_sladek_project_sql_primary_final AS t
JOIN  difference AS df
    ON df.year_from = t.year_from
GROUP BY t.price_category, t.year_from, t.avg_price, t.price_value, t.price_unit
HAVING percentage_price_difference  IS NOT NULL 
	AND percentage_wage_difference IS NOT NULL 
	AND percentage_wage_difference != 0
	AND (percentage_price_difference/percentage_wage_difference)>1.1;

