-- CTE -> Common table expressions

-- CTE is a temporary, named result set that you can reference within a single SELECT, INSERT, UPDATE, or DELETE

with employee_data AS
(
    select employee_id,
    first_name,last_name
    from hr.EMPLOYEES
)
select *
from employee_data

-- CTE with where clause

with employee_data AS
(
    select employee_id,
    first_name,last_name,department_id
    from hr.EMPLOYEES
)
select *
from employee_data
where department_id = 90


-- One time filtering : Go for sub query
-- Complex queries or analytical querie : Go for CTE's

-- Query with multiple CTE's

WITH TotalDeptSalary AS (
    SELECT department_id, SUM(salary) AS total_salary
    FROM hr.employees
    GROUP BY department_id
),
HighYieldDepartments AS (
    SELECT department_id,total_salary
    FROM TotalDeptSalary
    WHERE total_salary > 5000
)
SELECT * 
FROM HighYieldDepartments;

-- CTE with analytical functions

with dept_salary as (
    select department_id,sum(salary) as total_salary
    from hr.EMPLOYEES
    group by department_id
),
ranked_departments as(
    select department_id,
    total_salary,
    dense_rank() over(
        order by total_salary desc
    ) as dept_rank
    from dept_salary
)
select *
from ranked_departments
order by dept_rank

-- CTE's with partition


with ranked_departments as(
    select department_id,
    sum(salary),
    dense_rank() over(
        partition by department_id
        order by sum(salary) desc
    ) as dept_rank
    from hr.EMPLOYEES
    group by department_id
)
select *
from ranked_departments
order by dept_rank


-- CTE's with sub query

with dept_total as (
    select department_id,sum(salary) as total_salary
    from hr.EMPLOYEES
    group by department_id
),
avg_dept as(
    select department_id,
    total_salary
    from dept_total
    WHERE total_salary > (
        select avg(total_salary)
        from dept_total
    )
)
select *
from avg_dept
order by total_salary desc

-- Find the difference between current salary and next salary

with salary_order as(
    select employee_id,first_name,
    department_id,salary,
    lead(salary) over(
        PARTITION by department_id
        order by salary desc
    ) as next_salary
    from hr.EMPLOYEES
),
difference_salary as (
    select employee_id,first_name,
    department_id,salary,next_salary,
    salary - next_salary as differnce
    from salary_order
    where next_salary is not null
)
select *
from difference_salary

-- find the latest hired employees from eavh deaprtment

with hire_rank as(
    select employee_id,first_name,
    department_id,salary,HIRE_DATE,
    row_number() over(
        PARTITION by department_id
        order by HIRE_DATE desc
    ) as rn
    from hr.EMPLOYEES
),
latest_hires as (
    select employee_id,first_name,
    department_id,salary,HIRE_DATE
    from hire_rank
    where rn =1
)
select *
from latest_hires
order by department_id
