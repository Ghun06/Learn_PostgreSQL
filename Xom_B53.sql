-- HR Business Partner cần báo cáo nhân viên có mức lương cao thứ hai trong mỗi phòng ban phục vụ review compensation
-- RESULTS
```sql
SELECT departments, full_name, salaries
FROM (
    SELECT departments, full_name, salaries,
    DENSE_RANK() OVER (PARTITION BY departments ORDER BY salaries DESC) as rnk
    FROM employees
) t
WHERE rnk = 2
ORDER BY departments, full_name
