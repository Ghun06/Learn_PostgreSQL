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
