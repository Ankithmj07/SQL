-- PARTITION BY() - divides the rows into logical groups and it does not collapse or removes the rows

-- ROW_NUMBER() - Assigns a unique number to every row.

-- select first_name, job_id,DEPARTMENT_ID, salary,
-- row_number() over (
--     order by salary
-- )
-- from hr.EMPLOYEES

-- ROW_NUMBER() with partition by

-- select first_name, job_id,DEPARTMENT_ID, salary,
-- row_number() over (
--     partition by DEPARTMENT_ID
--     order by salary
-- )
-- from hr.EMPLOYEES


-- RANK() - Assigns rankings but leaves a gap when there are duplicates. -> like 1,2,2,4 -> 3 is skipped as 2 appears 2 times

-- select first_name, job_id,DEPARTMENT_ID, salary,
-- rank() over (
--     order by salary
-- )
-- from hr.EMPLOYEES

-- RANK() with partition by

-- select first_name, job_id,DEPARTMENT_ID, salary,
-- rank() over (
--     partition by DEPARTMENT_ID
--     order by salary
-- )
-- from hr.EMPLOYEES

-- DENS_RANK() - Assigns rankings but do not leaves gap whenthere are duplicates -> 1,2,2,3,4 -> assigned 3 even though 2 appears 2 times

-- select first_name, job_id,DEPARTMENT_ID, salary,
-- dense_rank() over (
--     order by salary
-- )
-- from hr.EMPLOYEES

-- DENSE_RANK() eith partition by

-- select first_name, job_id,DEPARTMENT_ID, salary,
-- dense_rank() over (
--     partition by DEPARTMENT_ID
--     order by salary
-- )
-- from hr.EMPLOYEES

-- LAG() - Give the previous row value

-- select month_id,sales,
-- lag(sales) over (
--     order by month_id 
-- ) as next_month_sales
-- from av.SALES_FACT

-- LEAD() - Give the next row value, opposite to LAG()

-- select month_id,sales, 
-- lead(sales) over (
--     order by month_id 
-- ) as next_month_sales
-- from av.SALES_FACT

-- Lag(sales,2) -> gives 2 rows previous values

-- select month_id,sales,
-- lag(sales,2) over (
--     order by month_id 
-- ) as next_month_sales
-- from av.SALES_FACT

-- LAG(sales,1,0) -> Gives 0 for the first row instead of Null

-- select month_id,sales,
-- lag(sales,1,0) over (
--     order by month_id 
-- ) as next_month_sales
-- from av.SALES_FACT

-- FIRST_VALUE() - Gives the first value within every group.

-- select first_name,salary,DEPARTMENT_ID,
-- first_value(salary) over(
--     PARTITION by department_id
-- ) as first_value_slary
-- from hr.EMPLOYEES

-- Get lowest salary of the each department

-- select first_name,salary,DEPARTMENT_ID,
-- first_value(salary) over(
--     PARTITION by department_id
--     order by salary
-- ) as lowest_slary
-- from hr.EMPLOYEES

--  Get highest salary

select first_name,salary,DEPARTMENT_ID,
first_value(salary) over(
    PARTITION by department_id
    order by salary desc
) as highest_slary
from hr.EMPLOYEES