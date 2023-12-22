-- Druhý ukol
SELECT
	t1.food_category,
	t1.food_price,
	t1.payroll_year,
	t1.average_wages,
	round((t1.average_wages/t1.food_price), 1) AS food_amount,
	t1.price_unit
FROM
	t_milan_nemecek_project_sql_primary_final t1
WHERE 
	t1.food_category_code IN ('114201','111301') AND 
	t1.payroll_year IN ('2006','2018')
GROUP BY
	t1.food_category,
	t1.payroll_year
ORDER BY
	t1.food_category
;
