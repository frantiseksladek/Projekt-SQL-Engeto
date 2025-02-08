
CREATE TABLE `t_frantisek_sladek_project_SQL_primary_final` (
  `id` int(11) NOT NULL,
  `value` int(11) DEFAULT NULL,
  `value_type_code` int(11) NOT NULL,
  `unit_code` int(11) NOT NULL,
  -- `calculation_code` int(11) NOT NULL,
  `industry_branch_code` char(1) DEFAULT NULL,
  `payroll_year` int(11) DEFAULT NULL,
 -- `payroll_quarter` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_czechia_payroll_value_type` (`value_type_code`),
  KEY `fk_czechia_payroll_unit` (`unit_code`),
 -- KEY `fk_czechia_payroll_calculation` (`calculation_code`),
  KEY `fk_czechia_payroll_industry_branch` (`industry_branch_code`),
 -- CONSTRAINT `fk_czechia_payroll_calculation` FOREIGN KEY (`calculation_code`) REFERENCES `czechia_payroll_calculation` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_czechia_payroll_industry_branch` FOREIGN KEY (`industry_branch_code`) REFERENCES `czechia_payroll_industry_branch` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_czechia_payroll_unit` FOREIGN KEY (`unit_code`) REFERENCES `czechia_payroll_unit` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_czechia_payroll_value_type` FOREIGN KEY (`value_type_code`) REFERENCES `czechia_payroll_value_type` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_czech_ci COMMENT='Payrolls of employees in various industries in years 2000-2021, Open data from data.gov.cz, November 2021.';

INSERT INTO t_frantisek_sladek_project_SQL_primary_final (id, value, value_type_code, industry_branch_code, industry_payroll_year)
SELECT 
    cp.id AS id,
    cp.value AS value,
    cp.value_type_code AS value_type_code,
    cp.industry_branch_code AS industry_branch_code,
	cp.industry_payroll_year AS industry_payroll_year,
FROM czechia_payroll AS cp;
--- JOIN  ON 