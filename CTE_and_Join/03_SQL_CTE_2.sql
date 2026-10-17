/*==============================================================================
1. BASIC CTE
==============================================================================*/

WITH employee_data AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        salary
    FROM employee
)
SELECT *
FROM employee_data;


/*==============================================================================
2. CTE WITH WHERE CONDITION
Find employees earning more than 60,000.
==============================================================================*/

WITH high_salary_employees AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        salary
    FROM employee
    WHERE salary > 60000
)
SELECT *
FROM high_salary_employees;


/*==============================================================================
3. CTE WITH NULL CONDITION
Find employees whose salary is NULL.
==============================================================================*/

WITH missing_salary AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        salary
    FROM employee
    WHERE salary IS NULL
)
SELECT *
FROM missing_salary;


/*==============================================================================
4. CTE WITH NVL
Replace NULL salary with zero.
==============================================================================*/

WITH clean_salary AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        NVL(salary, 0) AS salary
    FROM employee
)
SELECT *
FROM clean_salary;


/*==============================================================================
5. CTE WITH INNER JOIN
Get employees and their projects.
==============================================================================*/

WITH employee_projects AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        e.department,
        p.project_name,
        p.project_role,
        p.hours_worked
    FROM employee e
    INNER JOIN employee_project p
        ON e.emp_id = p.emp_id
)
SELECT *
FROM employee_projects;


/*==============================================================================
6. CTE WITH LEFT JOIN
Return all employees including employees without projects.
==============================================================================*/

WITH employee_projects AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        e.department,
        p.project_name,
        p.project_role
    FROM employee e
    LEFT JOIN employee_project p
        ON e.emp_id = p.emp_id
)
SELECT *
FROM employee_projects;


/*==============================================================================
7. CTE WITH GROUP BY
Count number of projects assigned to every employee.
==============================================================================*/

WITH project_count AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        COUNT(p.assignment_id) AS total_projects
    FROM employee e
    LEFT JOIN employee_project p
        ON e.emp_id = p.emp_id
    GROUP BY
        e.emp_id,
        e.emp_name
)
SELECT *
FROM project_count
ORDER BY total_projects DESC;


/*==============================================================================
8. CTE WITH SUM
Calculate total project hours.
==============================================================================*/

WITH employee_hours AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        SUM(NVL(p.hours_worked, 0)) AS total_hours
    FROM employee e
    LEFT JOIN employee_project p
        ON e.emp_id = p.emp_id
    GROUP BY
        e.emp_id,
        e.emp_name
)
SELECT *
FROM employee_hours
ORDER BY total_hours DESC;


/*==============================================================================
9. CTE WITH HAVING
Find employees working on more than one project.
==============================================================================*/

WITH multiple_projects AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        COUNT(p.assignment_id) AS total_projects
    FROM employee e
    JOIN employee_project p
        ON e.emp_id = p.emp_id
    GROUP BY
        e.emp_id,
        e.emp_name
    -- HAVING COUNT(p.assignment_id) > 1
)
SELECT *
FROM multiple_projects;


/*==============================================================================
10. CTE WITH CASE
Categorize employees based on salary.
==============================================================================*/

WITH salary_category AS
(
    SELECT
        emp_id,
        emp_name,
        salary,

        CASE
            WHEN salary >= 80000 THEN 'High Salary'
            WHEN salary >= 60000 THEN 'Medium Salary'
            WHEN salary IS NULL THEN 'Salary Missing'
            ELSE 'Low Salary'
        END AS salary_category

    FROM employee
)
SELECT *
FROM salary_category;


/*==============================================================================
11. TWO-LEVEL CTE

Level 1 -> Calculate total hours
Level 2 -> Categorize workload
==============================================================================*/

WITH employee_hours AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        SUM(NVL(p.hours_worked, 0)) AS total_hours
    FROM employee e
    LEFT JOIN employee_project p
        ON e.emp_id = p.emp_id
    GROUP BY
        e.emp_id,
        e.emp_name
),

workload AS
(
    SELECT
        emp_id,
        emp_name,
        total_hours,

        CASE
            WHEN total_hours >= 200 THEN 'High Workload'
            WHEN total_hours >= 100 THEN 'Medium Workload'
            ELSE 'Low Workload'
        END AS workload_category

    FROM employee_hours
)

SELECT *
FROM workload
ORDER BY total_hours DESC;


/*==============================================================================
12. TWO-LEVEL CTE

Level 1 -> Clean salary
Level 2 -> Filter high salary employees
==============================================================================*/

WITH clean_salary AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        NVL(salary, 0) AS salary
    FROM employee
),

high_salary AS
(
    SELECT *
    FROM clean_salary
    WHERE salary >= 70000
)

SELECT *
FROM high_salary
ORDER BY salary DESC;


/*==============================================================================
13. TWO-LEVEL CTE

Level 1 -> Count projects
Level 2 -> Join project count with employee
==============================================================================*/

WITH project_count AS
(
    SELECT
        emp_id,
        COUNT(*) AS total_projects
    FROM employee_project
    WHERE emp_id IS NOT NULL
    GROUP BY emp_id
),

employee_summary AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        e.department,
        NVL(p.total_projects, 0) AS total_projects
    FROM employee e
    LEFT JOIN project_count p
        ON e.emp_id = p.emp_id
)

SELECT *
FROM employee_summary
ORDER BY total_projects DESC;


/*==============================================================================
14. TWO-LEVEL CTE - ACTIVE PROJECTS

Level 1 -> Filter active projects
Level 2 -> Join with employees
==============================================================================*/

WITH active_projects AS
(
    SELECT
        emp_id,
        project_name,
        project_role,
        hours_worked
    FROM employee_project
    WHERE status = 'Active'
),

active_employee_projects AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        e.department,
        p.project_name,
        p.project_role,
        p.hours_worked
    FROM employee e
    JOIN active_projects p
        ON e.emp_id = p.emp_id
)

SELECT *
FROM active_employee_projects;


/*==============================================================================
15. TWO-LEVEL CTE WITH RANKING

Level 1 -> Calculate hours
Level 2 -> Rank employees
==============================================================================*/

WITH employee_hours AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        SUM(NVL(p.hours_worked, 0)) AS total_hours
    FROM employee e
    LEFT JOIN employee_project p
        ON e.emp_id = p.emp_id
    GROUP BY
        e.emp_id,
        e.emp_name
),

employee_ranking AS
(
    SELECT
        emp_id,
        emp_name,
        total_hours,

        DENSE_RANK() OVER
        (
            ORDER BY total_hours DESC
        ) AS employee_rank

    FROM employee_hours
)

SELECT *
FROM employee_ranking
ORDER BY employee_rank;


/*==============================================================================
16. THREE-LEVEL CTE

Level 1 -> Join employee/project
Level 2 -> Aggregate data
Level 3 -> Classify workload
==============================================================================*/

WITH employee_project_data AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        e.department,
        p.project_name,
        NVL(p.hours_worked, 0) AS hours_worked
    FROM employee e
    LEFT JOIN employee_project p
        ON e.emp_id = p.emp_id
),

employee_summary AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        COUNT(project_name) AS total_projects,
        SUM(hours_worked) AS total_hours
    FROM employee_project_data
    GROUP BY
        emp_id,
        emp_name,
        department
),

employee_classification AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        total_projects,
        total_hours,

        CASE
            WHEN total_hours >= 200 THEN 'High'
            WHEN total_hours >= 100 THEN 'Medium'
            ELSE 'Low'
        END AS workload

    FROM employee_summary
)

SELECT *
FROM employee_classification
ORDER BY total_hours DESC;


/*==============================================================================
17. THREE-LEVEL CTE - SALARY ANALYSIS

Level 1 -> Clean employee data
Level 2 -> Calculate department average
Level 3 -> Compare employee with department average
==============================================================================*/

WITH clean_employee AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        NVL(salary, 0) AS salary
    FROM employee
    WHERE department IS NOT NULL
),

department_average AS
(
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM clean_employee
    GROUP BY department
),

salary_comparison AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        e.department,
        e.salary,
        d.avg_salary,

        CASE
            WHEN e.salary > d.avg_salary THEN 'Above Average'
            WHEN e.salary < d.avg_salary THEN 'Below Average'
            ELSE 'Equal to Average'
        END AS salary_status

    FROM clean_employee e
    JOIN department_average d
        ON e.department = d.department
)

SELECT *
FROM salary_comparison
ORDER BY department, salary DESC;


/*==============================================================================
18. THREE-LEVEL CTE - TOP 3 EMPLOYEES

Level 1 -> Calculate hours
Level 2 -> Rank employees
Level 3 -> Select top 3
==============================================================================*/

WITH employee_hours AS
(
    SELECT
        e.emp_id,
        e.emp_name,
        SUM(NVL(p.hours_worked, 0)) AS total_hours
    FROM employee e
    LEFT JOIN employee_project p
        ON e.emp_id = p.emp_id
    GROUP BY
        e.emp_id,
        e.emp_name
),

employee_ranking AS
(
    SELECT
        emp_id,
        emp_name,
        total_hours,

        DENSE_RANK() OVER
        (
            ORDER BY total_hours DESC
        ) AS employee_rank

    FROM employee_hours
),

top_three AS
(
    SELECT *
    FROM employee_ranking
    WHERE employee_rank <= 3
)

SELECT *
FROM top_three
ORDER BY employee_rank;


/*==============================================================================
19. THREE-LEVEL CTE - HIGHEST SALARY PER DEPARTMENT
==============================================================================*/

WITH employee_salary AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        salary
    FROM employee
    WHERE department IS NOT NULL
      AND salary IS NOT NULL
),

salary_ranking AS
(
    SELECT
        emp_id,
        emp_name,
        department,
        salary,

        DENSE_RANK() OVER
        (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_rank

    FROM employee_salary
),

highest_salary AS
(
    SELECT *
    FROM salary_ranking
    WHERE salary_rank = 1
)

SELECT *
FROM highest_salary
ORDER BY department;


/*==============================================================================
20. THREE-LEVEL CTE - PROJECT ANALYSIS
==============================================================================*/

WITH valid_projects AS
(
    SELECT
        emp_id,
        project_name,
        NVL(hours_worked, 0) AS hours_worked
    FROM employee_project
    WHERE emp_id IS NOT NULL
),

project_summary AS
(
    SELECT
        project_name,
        COUNT(DISTINCT emp_id) AS employee_count,
        SUM(hours_worked) AS total_hours,
        AVG(hours_worked) AS avg_hours
    FROM valid_projects
    GROUP BY project_name
),

project_category AS
(
    SELECT
        project_name,
        employee_count,
        total_hours,
        avg_hours,

        CASE
            WHEN total_hours >= 200 THEN 'Large Project'
            WHEN total_hours >= 100 THEN 'Medium Project'
            ELSE 'Small Project'
        END AS project_size

    FROM project_summary
)

SELECT *
FROM project_category
ORDER BY total_hours DESC;
