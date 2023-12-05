-- primary table
SELECT *
FROM czechia_price cp ;

SELECT *
FROM czechia_payroll cp2 ;

SELECT *
FROM czechia_payroll_industry_branch cpib ;

SELECT *
FROM czechia_price_category cpc ;

SELECT *
FROM czechia_region cr ;

SELECT *
FROM economies e ;




CREATE TABLE t_milan_nemecek_project_SQL_primary_final_test1
SELECT
	cpc.name AS food_category,
	cp.value AS food_price,
	cpib.name AS industry,
	cp2.value AS average_wages,
	cp2.payroll_year,
	cr.name AS region_name,
	cpc.price_value,
	cpc.price_unit
FROM
	czechia_price cp
JOIN czechia_payroll cp2 
	ON
	YEAR(cp.date_from) = cp2.payroll_year
LEFT JOIN czechia_price_category cpc 
	ON
	cpc.code = cp.category_code
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON
	cp2.industry_branch_code = cpib.code
LEFT JOIN czechia_region cr 
	ON
	cr.code = cp.region_code
WHERE
	cp2.value_type_code = 5958
;

-- smazani tabulky
DROP TABLE t_milan_nemecek_project_sql_primary_final_test1 
