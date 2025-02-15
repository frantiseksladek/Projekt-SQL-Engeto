
CREATE OR REPLACE TABLE `t_frantisek_sladek_project_SQL_primary_final` AS
SELECT 
    ROUND(AVG(cp.value), 2) AS avg_price,
    YEAR(cp.date_from) AS year,
    cpc.name AS price_category,
    cpc.price_value,
    cpc.price_unit,
    ROUND(AVG(cpay.value), 2) AS avg_wages,
    cpib.name AS industry_category
FROM czechia_price AS cp
JOIN czechia_price_category AS cpc 
    ON cp.category_code = cpc.code
JOIN czechia_payroll AS cpay
    ON cpay.payroll_year = YEAR(cp.date_from)
JOIN czechia_payroll_industry_branch AS cpib 
    ON cpay.industry_branch_code = cpib.code
WHERE
    cpay.value IS NOT NULL 
    AND cpay.value_type_code = 5958
    AND cpay.unit_code = 200
    AND cpay.calculation_code = 200
    AND cpay.industry_branch_code IS NOT NULL
GROUP BY 
    cpc.name, 
    cpc.price_value, 
    cpc.price_unit, 
    YEAR(cp.date_from), 
    cpay.industry_branch_code, 
    cpib.name, 
    cpay.payroll_year;

	
-- propojeni czechia_price a czechia_price_category
SELECT 
	ROUND (AVG (cp.value), 2),
	YEAR (cp.date_from),
	cpc.name,
	cpc.price_value,
	cpc.price_unit
FROM czechia_price AS cp
JOIN czechia_price_category AS cpc 
	ON cp.category_code = cpc.code
GROUP BY  category_code, YEAR (cp.date_from);

-- propojeni czechia_payroll a czechia_payroll_industry
SELECT 
	AVG (cpay.value),
	cpay.industry_branch_code,
	cpib.name,
	cpay.payroll_year
FROM czechia_payroll AS cpay
JOIN czechia_payroll_industry_branch AS cpib 
	ON cpay.industry_branch_code = cpib.code
WHERE
	cpay.value IS NOT NULL 
	AND cpay.value_type_code = 5958
	AND cpay.unit_code = 200
	AND cpay.calculation_code = 200
	AND cpay.industry_branch_code IS NOT NULL
GROUP BY industry_branch_code,payroll_year;
