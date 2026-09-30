
-- -- 1. UNION
-- -- Combines results from both queries
-- -- Removes duplicate rows

-- SELECT employee_id, first_name, salary,DEPARTMENT_ID
-- FROM hr.employees
-- WHERE department_id = 50

-- UNION

-- SELECT employee_id, first_name, salary,DEPARTMENT_ID
-- FROM hr.employees
-- WHERE department_id = 80;


-- -- ============================================================


-- -- 2. UNION ALL
-- -- Combines results from both queries
-- -- Keeps duplicate rows

-- SELECT employee_id, first_name, salary,department_id
-- FROM hr.employees
-- WHERE department_id = 50

-- UNION ALL

-- SELECT employee_id, first_name, salary,department_id
-- FROM hr.employees
-- WHERE salary > 5000;


-- -- ============================================================


-- -- 3. INTERSECT
-- -- Returns rows that are common in both queries

-- SELECT employee_id, first_name, salary,department_id
-- FROM hr.employees
-- WHERE department_id = 50

-- INTERSECT

-- SELECT employee_id, first_name, salary,department_id
-- FROM hr.employees
-- WHERE salary > 5000;


-- -- ============================================================


-- -- 4. MINUS
-- -- Returns rows from the first query
-- -- that are NOT present in the second query

-- SELECT employee_id, first_name, salary,department_id
-- FROM hr.employees
-- WHERE department_id = 50

-- MINUS

-- SELECT employee_id, first_name, salary,department_id
-- FROM hr.employees
-- WHERE salary > 5000;

-- Above query gave the detailes with department_id is 50 and salary is less than 5000

-- -- ============================================================
-- -- SIMPLE EXAMPLES USING DEPARTMENT_ID
-- -- ============================================================


-- -- UNION
-- -- Get departments having employees with salary > 10000
-- -- OR employees receiving commission
-- -- Duplicates are removed

-- SELECT department_id
-- FROM hr.employees
-- WHERE salary > 10000

-- UNION

-- SELECT department_id
-- FROM hr.employees
-- WHERE commission_pct IS NOT NULL;


-- -- UNION ALL
-- -- Same as UNION, but duplicates are retained

-- SELECT department_id
-- FROM hr.employees
-- WHERE salary > 10000

-- UNION ALL

-- SELECT department_id
-- FROM hr.employees
-- WHERE commission_pct IS NOT NULL;


-- -- INTERSECT
-- -- Get departments satisfying BOTH conditions

-- SELECT department_id
-- FROM hr.employees
-- WHERE salary > 10000

-- INTERSECT

-- SELECT department_id
-- FROM hr.employees
-- WHERE commission_pct IS NOT NULL;


-- -- MINUS
-- -- Get departments from first query
-- -- which are not present in second query

SELECT department_id
FROM hr.employees
WHERE salary > 10000

MINUS

SELECT department_id
FROM hr.employees
WHERE commission_pct IS NOT NULL;

