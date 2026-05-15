# Learn_PostgreSQL

Data Analyst cần so sánh hai hàm phân phối: PERCENT_RANK (phần trăm bản ghi có doanh thu thấp hơn) và CUME_DIST (phần trăm bản ghi có doanh thu ≤ hiện tại) trên dữ liệu doanh thu nhân viên.
Dùng PERCENT_RANK() OVER (ORDER BY revenue) và CUME_DIST() OVER (ORDER BY revenue). Sắp xếp theo revenue tăng dần để dễ quan sát sự khác biệt.
```sql
INSERT INTO communes (province_code, district_code, scholastic_id, name)
SELECT province_code, district_code, 4 AS scholastic_id, name
FROM communes
WHERE scholastic_id = 3;
