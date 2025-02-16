WITH difference AS (
    SELECT
        year_from,
        AVG(avg_price) AS avg_price_prev_year,
        AVG(avg_wages) AS avg_wages_prev_year
    FROM t_frantisek_sladek_project_sql_primary_final
    GROUP BY year_from
)
SELECT
    t.year_from,
    AVG(t.avg_price) AS avg_price,
    AVG(t.avg_wages) AS avg_wages,
    df.avg_price_prev_year,
    df.avg_wages_prev_year,
    ROUND(AVG(t.avg_price) - df.avg_price_prev_year, 2) AS annual_price_difference,
    ROUND(AVG(t.avg_wages) - df.avg_wages_prev_year, 2) AS annual_wage_difference,
    ROUND(((AVG(t.avg_price) - df.avg_price_prev_year) / df.avg_price_prev_year)*100, 2) AS percentage_price_difference,
    ROUND(((AVG(t.avg_wages) - df.avg_wages_prev_year) / df.avg_wages_prev_year)*100, 2) AS percentage_wage_difference
FROM t_frantisek_sladek_project_sql_primary_final AS t
JOIN difference AS df 
    ON df.year_from = t.year_from - 1
GROUP BY t.year_from, df.avg_price_prev_year, df.avg_wages_prev_year
HAVING percentage_price_difference IS NOT NULL 
   AND percentage_wage_difference IS NOT NULL
 	AND percentage_price_difference-percentage_wage_difference >= 10 OR percentage_wage_difference-percentage_price_difference >= 10;

