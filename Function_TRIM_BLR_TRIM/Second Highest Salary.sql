-- Write a solution to find the second highest distinct salary from the table. If there is no second highest salary, return .Employeenull (return None in Pandas)

SELECT MAX(salary) AS "SecondHighestSalary"
FROM (
    SELECT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) t
WHERE rnk = 2;
