SELECT Department, Employee, Salary FROM (
    SELECT e.salary AS Salary, d.name AS Department, e.name AS Employee,
    DENSE_RANK() OVER (PARTITION BY d.id ORDER BY e.salary DESC) AS rank
    FROM Employee e
    JOIN Department d ON d.id = e.departmentId
) WHERE rank <= 3


-- Customers Who Bought All Products
SELECT  customer_id FROM Customer GROUP BY customer_id
HAVING COUNT(distinct product_key) = (SELECT COUNT(product_key) FROM Product)
