-- Tỷ Lệ Sử Dụng Ngân Sách 3 Tháng Cuộn

```sql
WITH factb as (
SELECT dept, month, 
SUM(budget) OVER (PARTITION BY dept ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as roll3_budget,
SUM(actual) OVER (PARTITION BY dept ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as roll3_actual
FROM budgets
GROUP BY dept, month
)
SELECT *, ROUND((roll3_actual * 100.0/roll3_budget), 2) AS utilization_pct
FROM factb;

-- Phòng ban vượt ngân sách (lương + chi phí dự án) dùng COALESCE xử lý phòng ban chỉ có một trong hai khoản chi.

WITH dept_salary AS (
    SELECT 
        dept_id,
        SUM(salaries) AS total_salary
    FROM employees
    GROUP BY dept_id
),
dept_project AS (
    SELECT 
        dept_id,
        SUM(cost) AS total_project_cost
    FROM projects
    GROUP BY dept_id
)
SELECT 
    d.id AS dept_id,
    d.name AS dept_name,
    d.budget,
    COALESCE(ds.total_salary, 0) AS total_salary,
    COALESCE(dp.total_project_cost, 0) AS total_cost_spent,
    COALESCE(ds.total_salary, 0) + COALESCE(dp.total_project_cost, 0) AS total_spending,
    COALESCE(ds.total_salary, 0) + COALESCE(dp.total_project_cost, 0) - d.budget AS over_budget
FROM departments d
LEFT JOIN dept_salary ds ON d.id = ds.dept_id
LEFT JOIN dept_project dp ON d.id = dp.dept_id
WHERE COALESCE(ds.total_salary, 0) + COALESCE(dp.total_project_cost, 0) > d.budget
ORDER BY over_budget DESC;
