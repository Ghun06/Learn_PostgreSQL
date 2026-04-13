-- Trưởng bộ phận kinh doanh muốn biết sản phẩm bán chạy nhất trong mỗi danh mục để ưu tiên tái nhập hàng. Mỗi danh mục chỉ lấy đúng 1 sản phẩm có số lượng bán cao nhất.

-- Tổng hợp số lượng từ order_items, join với products để lấy danh mục. Dùng window function ROW_NUMBER() phân vùng theo danh mục, lấy hàng đầu tiên mỗi nhóm.

-- Kết quả cần trả về các cột: categories, product_name, total_quantity.

-- RESULTS
```sql
WITH facttb AS (
    SELECT 
        ps.categories,
        ps.name AS product_name,
        SUM(ois.quantity) AS total_quantity
    FROM products ps
    JOIN order_items ois ON ps.id = ois.product_id
    GROUP BY ps.categories, ps.name
)
SELECT 
    categories,
    product_name,
    total_quantity
FROM (
    SELECT 
        categories,
        product_name,
        total_quantity,
        ROW_NUMBER() OVER (
            PARTITION BY categories 
            ORDER BY total_quantity DESC
        ) AS rn
    FROM facttb
) t
WHERE rn = 1
ORDER BY categories, product_name;
