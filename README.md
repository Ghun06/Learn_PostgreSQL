# Learn_PostgreSQL

```sql
INSERT INTO communes (province_code, district_code, scholastic_id, name)
SELECT province_code, district_code, 4 AS scholastic_id, name
FROM communes
WHERE scholastic_id = 3;
