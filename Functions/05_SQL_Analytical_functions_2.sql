-- ============================================================
-- 1. RANK employees based on highest salary
-- Same salary = same rank, next rank may be skipped
-- ============================================================

SELECT
    employee_id,
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM hr.employees;


-- ============================================================
-- 2. DENSE_RANK employees based on highest salary
-- Same salary = same rank, but ranks are NOT skipped
-- ============================================================

SELECT
    employee_id,
    first_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_dense_rank
FROM hr.employees;


-- ============================================================
-- 3. ROW_NUMBER employees based on highest salary
-- Every employee gets a unique number
-- ============================================================

SELECT
    employee_id,
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_number
FROM hr.employees;


-- ============================================================
-- 4. RANK employees department-wise based on salary
-- Ranking starts again for every department
-- ============================================================

SELECT
    employee_id,
    first_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_salary_rank
FROM hr.employees;


-- ============================================================
-- 5. DENSE_RANK employees department-wise based on salary
-- ============================================================

SELECT
    employee_id,
    first_name,
    department_id,
    salary,
    DENSE_RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_dense_rank
FROM hr.employees;


-- ============================================================
-- 6. ROW_NUMBER department-wise based on salary
-- ============================================================

SELECT
    employee_id,
    first_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_row_number
FROM hr.employees;


-- ============================================================
-- 7. Find Top 5 highest-paid employees using ROW_NUMBER
-- ============================================================

SELECT *
FROM (
    SELECT
        employee_id,
        first_name,
        salary,
        ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM hr.employees
)
WHERE rn <= 5;


-- ============================================================
-- 8. Find employees with Top 3 salary ranks using DENSE_RANK
-- Includes employees having same salary
-- ============================================================

SELECT *
FROM (
    SELECT
        employee_id,
        first_name,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM hr.employees
)
WHERE salary_rank <= 3;


-- ============================================================
-- 9. Display first 10 employees using ROWNUM
-- ============================================================

SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM hr.employees
WHERE ROWNUM <= 10;


-- ============================================================
-- 10. Find Top 10 highest-paid employees using ROWNUM
-- ORDER BY must happen inside the subquery
-- ============================================================

SELECT
    employee_id,
    first_name,
    salary
FROM (
    SELECT
        employee_id,
        first_name,
        salary
    FROM hr.employees
    ORDER BY salary DESC
)
WHERE ROWNUM <= 10;