-- Khách hàng mua sản phẩm từ tất cả danh mục

```sql
WITH total_categories AS (
    SELECT COUNT(*) AS total FROM categories
)
SELECT 
    o.customer_id,
    COUNT(DISTINCT p.category_id) AS categories_bought
FROM orders o
JOIN details d ON d.order_id = o.id
JOIN products p ON p.id = d.product_id
GROUP BY o.customer_id
HAVING COUNT(DISTINCT p.category_id) = (SELECT total FROM total_categories);

-- B49: Tỷ lệ tồn kho so với doanh số 30 ngày

WITH sales_30d AS (
    SELECT 
        product_id,
        SUM(quantity) AS sales_30d
    FROM sales
    WHERE date >= '2024-04-01'
      AND date < '2024-05-01'
    GROUP BY product_id
)

SELECT 
    ps.id AS product_id,
    ps.name,
    ps.inventory,
    sales_30d,
    ROUND(ps.inventory * 1.0 / NULLIF(s.sales_30d, 0), 2) AS ratio
FROM products ps
LEFT JOIN sales_30d s 
    ON ps.id = s.product_id
ORDER BY product_id;
