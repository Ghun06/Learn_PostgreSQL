SELECT Department, Employee, Salary FROM (
    SELECT e.salary AS Salary, d.name AS Department, e.name AS Employee,
    DENSE_RANK() OVER (PARTITION BY d.id ORDER BY e.salary DESC) AS rank
    FROM Employee e
    JOIN Department d ON d.id = e.departmentId
) WHERE rank <= 3
