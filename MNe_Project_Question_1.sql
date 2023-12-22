-- První ukol
SELECT
	t1.industry,
	t1.payroll_year,
	round(avg(t1.average_wages), 0) AS average_wages
FROM
	t_milan_nemecek_project_sql_primary_final t1
WHERE 
	t1.industry IS NOT NULL
GROUP BY
	t1.industry,
	t1.payroll_year
ORDER BY
	t1.industry,
	t1.payroll_year 
;




-- 1 ukol_porovnani
SELECT
	t.industry,
	min(t.payroll_year) AS 'FIRST_YEAR',
		(SELECT
			t1.average_wages
		FROM
			t_milan_nemecek_project_sql_primary_final t1
		WHERE
			t1.industry = t.industry AND 
			t1.payroll_year = min(t.payroll_year) LIMIT 1) AS 'FIRST_AVG_WAGES',
	max(t.payroll_year) AS 'LAST_YEAR',
		(SELECT
			t1.average_wages
		FROM
			t_milan_nemecek_project_sql_primary_final t1
		WHERE
			t1.industry = t.industry AND 
			t1.payroll_year = max(t.payroll_year) LIMIT 1) AS 'LAST_AVG_WAGES',
	CASE
		WHEN (
			SELECT
				t1.average_wages
			FROM
				t_milan_nemecek_project_sql_primary_final t1
			WHERE
				t1.industry = t.industry AND t1.payroll_year = min(t.payroll_year) LIMIT 1) 
		> (
			SELECT
				t1.average_wages
			FROM
				t_milan_nemecek_project_sql_primary_final t1
			WHERE
				t1.industry = t.industry AND t1.payroll_year = max(t.payroll_year) LIMIT 1) 
			THEN 'decreasing'
		WHEN (
			SELECT
				t1.average_wages
			FROM
				t_milan_nemecek_project_sql_primary_final t1
			WHERE
				t1.industry = t.industry
				AND t1.payroll_year = min(t.payroll_year) LIMIT 1) 
		= (
			SELECT
				t1.average_wages
			FROM
				t_milan_nemecek_project_sql_primary_final t1
			WHERE
				t1.industry = t.industry AND t1.payroll_year = max(t.payroll_year) LIMIT 1) 
			THEN 'no_change'
		ELSE 'increasing'
	END AS 'TREND_TYPE'
FROM
	t_milan_nemecek_project_sql_primary_final t
WHERE
	industry IS NOT NULL
	AND industry <> ''
GROUP BY
	industry
ORDER BY
	industry
;