CREATE OR REPLACE TABLE `t_frantisek_sladek_project_SQL_secondary_final` AS
SELECT
	e.country,
	e.`year` AS year_gdp,
	e.GDP
FROM economies AS e
WHERE e.country LIKE '%Czech%' 
		AND e.`year` BETWEEN 2005 AND 2020;