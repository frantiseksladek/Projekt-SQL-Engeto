WITH year_limits AS (
    SELECT 
        MIN(year_from) AS min_year,
        MAX(year_from) AS max_year
    FROM t_frantisek_sladek_project_sql_primary_final
    WHERE price_category LIKE '%Chléb%' OR price_category LIKE '%Mléko%'
)
SELECT
	t.avg_price,
	t.year_from,
	t.price_category,
	t.price_value,
	t.price_unit,
	ROUND(AVG(t.avg_wages), 2) AS annual_avg_wages,
	ROUND(AVG(t.avg_wages) / AVG(t.avg_price), 2) AS pieces_per_wage
FROM t_frantisek_sladek_project_sql_primary_final AS t
JOIN year_limits AS yl
	ON t.year_from=yl.min_year OR t.year_from=yl.max_year
WHERE price_category IN ('Chléb', 'Mléko')
GROUP BY price_category, year_from, t.avg_price, t.price_value, t.price_unit;

