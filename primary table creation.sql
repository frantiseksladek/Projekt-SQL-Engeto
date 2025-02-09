
USE localhost_new;
CREATE OR REPLACE TABLE `t_frantisek_sladek_project_SQL_primary_final` (
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
 -- CONSTRAINT `fk_czechia_payroll_calculation_final` FOREIGN KEY (`calculation_code`) REFERENCES `czechia_payroll_calculation` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_czechia_payroll_industry_branch_final` FOREIGN KEY (`industry_branch_code`) REFERENCES `czechia_payroll_industry_branch` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_czechia_payroll_unit_final` FOREIGN KEY (`unit_code`) REFERENCES `czechia_payroll_unit` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_czechia_payroll_value_type_final` FOREIGN KEY (`value_type_code`) REFERENCES `czechia_payroll_value_type` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_czech_ci COMMENT='Payrolls of employees in various industries in years 2000-2021, Open data from data.gov.cz, November 2021.';


INSERT INTO t_frantisek_sladek_project_SQL_primary_final (id, value, value_type_code,unit_code, industry_branch_code, payroll_year )
SELECT 
    cp.id AS id,
    cp.value AS value,
    cp.value_type_code AS value_type_code,
    cp.unit_code AS unit_code,
    cp.industry_branch_code AS industry_branch_code,
	cp.payroll_year AS payroll_year  
FROM czechia_payroll AS cp;

ALTER TABLE t_frantisek_sladek_project_SQL_primary_final
ADD industry_code CHAR(1),
ADD industry_name VARCHAR (255),
ADD payroll_unit_code INT(11),
ADD payroll_unit_name VARCHAR(50),
ADD payroll_value_type_code INT(11),
ADD payroll_value_type_name VARCHAR(50);

UPDATE t_frantisek_sladek_project_SQL_primary_final AS t
JOIN czechia_payroll AS cp
  ON t.id = cp.id  
JOIN czechia_payroll_industry_branch AS cpib
  ON cp.industry_branch_code = cpib.code
JOIN czechia_payroll_unit AS cpu
  ON cp.unit_code = cpu.code
 JOIN czechia_payroll_value_type AS cpvt
  ON cp.value_type_code = cpvt.code
SET 
  t.industry_code = cpib.code,  
  t.industry_name = cpib.name,
  t.payroll_unit_code = cpu.code,  
  t.payroll_unit_name = cpu.name,
  t.payroll_value_type_code =cpvt.code,
  t.payroll_value_type_name =cpvt.name;
