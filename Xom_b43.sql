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

--B63 DevOps Engineer cần báo cáo tỷ lệ lỗi theo từng module hệ thống để ưu tiên sửa lỗi

```sql
SELECT
    module,
    COUNT(*)                                       AS total_actions,
    SUM(CASE WHEN success = 0 THEN 1 ELSE 0 END)   AS error_count,
    ROUND(
        SUM(CASE WHEN success = 0 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
    2)                                             AS error_rate
FROM logs
GROUP BY module
HAVING COUNT(*) >= 5
ORDER BY error_rate DESC;
