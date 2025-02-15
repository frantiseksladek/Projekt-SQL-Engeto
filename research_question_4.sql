WITH year_limits AS (
    SELECT
        MIN(year_from) AS min_year,
        MAX(year_from) AS max_year
    FROM t_frantisek_sladek_project_sql_primary_final
)   
SELECT
	t.avg_price,
	t.year_from,
	t.price_category,
	t.price_value,
	t.price_unit,
	yl.max_year - yl.min_year AS year_difference,
	(t.avg_price - (
        SELECT avg_price
        FROM t_frantisek_sladek_project_sql_primary_final
        WHERE price_category = t.price_category
          AND year_from = yl.min_year
        LIMIT 1
    )) / (
        SELECT avg_price
        FROM t_frantisek_sladek_project_sql_primary_final
        WHERE price_category = t.price_category
          AND year_from = t.year_from -1
        LIMIT 1
    ) * 100 AS percentage_growth
FROM t_frantisek_sladek_project_sql_primary_final AS t
JOIN year_limits AS yl
	ON t.year_from=yl.min_year OR t.year_from=yl.max_year
GROUP BY price_category, year_from, t.avg_price, t.price_value, t.price_unit, yl.min_year,yl.max_year;