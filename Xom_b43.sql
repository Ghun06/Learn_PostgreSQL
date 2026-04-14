--Nhân viên không được phân công dự án nào (dùng NOT EXISTS)

```sql

SELECT e.id, e.full_name, e.departments
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM assignments ass
    JOIN projects p ON ass.project_id = p.id
    WHERE ass.employee_id = e.id
      AND p.status = 'active'
);
