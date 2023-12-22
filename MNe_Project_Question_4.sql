-- Čtvrtý ukol
SELECT * FROM (
SELECT 
	t.food_category,
	t.payroll_year,
	round(avg(t.food_price) , 2) AS avg_food_price,
	t.average_wages,
	t2.payroll_year AS payroll_year_prev,
	round(t2.food_price , 2) AS avg_food_price_prev,
	t2.average_wages AS average_wages_prev,
CASE WHEN t2.payroll_year IS NULL THEN NULL
	ELSE round((((avg(t.food_price) - t2.food_price) / t2.food_price) * 100) , 1)
	END AS YoY_food_price_growth_percent,
CASE WHEN t2.average_wages IS NULL THEN NULL
	ELSE round((((t.average_wages - t2.average_wages) / t2.average_wages) * 100) , 1)
	END AS YoY_wages_growth_percent,
CASE WHEN (t2.payroll_year IS NULL OR t2.average_wages IS NULL) THEN NULL
	ELSE round((((avg(t.food_price) - t2.food_price) / t2.food_price) * 100) , 1) - round((((t.average_wages - t2.average_wages) / t2.average_wages) * 100) , 1)
	END AS diference
FROM
    t_milan_nemecek_project_sql_primary_final t
    LEFT JOIN (
    	SELECT 
    		t1.food_category,
    		t1.payroll_year,
    		avg(t1.food_price) AS food_price,
    		t1.average_wages
    	FROM 
    		t_milan_nemecek_project_sql_primary_final t1 
    	GROUP BY 
    		t1.food_category,
    		t1.payroll_year
    ) t2 ON t2.food_category = t.food_category AND t.payroll_year = (t2.payroll_year + 1)
GROUP BY 
	t.food_category,
	t.payroll_year
) x
WHERE x.diference >= 10
;
