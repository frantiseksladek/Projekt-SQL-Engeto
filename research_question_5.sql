WITH 
difference_gdp AS (
    SELECT
        t2.year_gdp,
        ROUND(t2.GDP - t2_prev.GDP, 2) AS annual_GDP_difference,
        t2_prev.GDP AS previous_GDP
    FROM t_frantisek_sladek_project_sql_secondary_final AS t2
    JOIN t_frantisek_sladek_project_sql_secondary_final AS t2_prev
        ON t2_prev.year_gdp = t2.year_gdp - 1 
),
price_wage_diff AS (
    SELECT 
        t.year_from,
        ROUND(AVG(t.avg_price), 2) AS avg_price,
        ROUND(AVG(t.avg_wages), 2) AS avg_wages,
        (SELECT ROUND(AVG(t_prev.avg_price), 2)
         FROM t_frantisek_sladek_project_sql_primary_final AS t_prev
         WHERE t_prev.year_from = t.year_from - 1) AS previous_avg_price,
        (SELECT ROUND(AVG(t_prev.avg_wages), 2)
         FROM t_frantisek_sladek_project_sql_primary_final AS t_prev
         WHERE t_prev.year_from = t.year_from - 1) AS previous_avg_wages
    FROM t_frantisek_sladek_project_sql_primary_final AS t
    GROUP BY t.year_from
)
SELECT
    pd.avg_price,
    pd.year_from,
    pd.avg_wages,
    dg.annual_GDP_difference,
    ROUND((dg.annual_GDP_difference / dg.previous_GDP) * 100, 2) AS percentage_GDP_difference,
    ROUND(((pd.avg_price - pd.previous_avg_price) / pd.previous_avg_price) * 100, 2) AS percentage_price_difference,
    ROUND(((pd.avg_wages - pd.previous_avg_wages) / pd.previous_avg_wages) * 100, 2) AS percentage_wage_difference
FROM price_wage_diff AS pd
LEFT JOIN difference_gdp AS dg
    ON dg.year_gdp = pd.year_from
GROUP BY pd.year_from
ORDER BY pd.year_from;


