
SELECT 
	t.food_category,
	t.payroll_year,
	round(avg(t.food_price) , 2) AS average_food_price,
	t2.payroll_year AS payroll_year_prev,
	round(t2.food_price , 2) AS average_food_price_prev,
CASE WHEN t2.payroll_year IS NULL THEN NULL
	ELSE round((((avg(t.food_price) - t2.food_price) / t2.food_price) * 100) , 1)
	END AS YoY_growth_percent
FROM
    t_milan_nemecek_project_sql_primary_final t
    LEFT JOIN (
    	SELECT 
    		t1.food_category,
    		t1.payroll_year,
    		avg(t1.food_price) AS food_price
    	FROM 
    		t_milan_nemecek_project_sql_primary_final t1 
    	GROUP BY 
    		t1.food_category,
    		t1.payroll_year
    ) t2 ON t2.food_category = t.food_category AND t.payroll_year = (t2.payroll_year + 1)
GROUP BY 
	t.food_category,
	t.payroll_year
;

