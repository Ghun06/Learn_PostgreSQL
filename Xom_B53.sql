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

-- Học sinh đạt điểm >= 8 ở tất cả môn

```sql
SELECT 
    ps.id AS student_id,
    ps.name,
    ps.classes,
    COUNT(ss.mon) AS subject_count
FROM pupils ps
JOIN scores ss ON ps.id = ss.student_id
GROUP BY ps.id, ps.name, ps.classes
HAVING COUNT(ss.mon) = COUNT(CASE WHEN ss.scores >= 8 THEN 1 END);
