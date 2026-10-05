-- NULL VALUE FUNCTIONS

-- Null means the value is unkown, missing or not applicable

-- NVL(values,replacement_value) -> with this we can put replacement values where there ia an null values.

select first_name, salary, commission_pct,
nvl(commission_pct,0) as commission
from hr.EMPLOYEES

select first_name, salary, commission_pct,
nvl(commission_pct,0) as commission,
salary + nvl(commission_pct,0) as total
from hr.EMPLOYEES

-- NVL2(expression,value_if_not_null,value_if_null) 

select first_name, salary, commission_pct,
nvl2(commission_pct,'commission available','commission not available') as commission_status
from hr.EMPLOYEES

-- COALESCE(value1,value2,value3....valuen) -> It returns the first not null values

select coalesce(NULL,10,20) from dual

select coalesce(null,null,20) from dual

-- NULLIF() -> If both values are same it returns the null value
        --  -> Otherwise it returns first value

select nullif(10,10) from dual

select nullif(10,20) from dual

-- CASE -> usually important and recomended

-- case statement can be used on order by as wel

select * from hr.employees

select first_name,salary,department_id,
case department_id
    when 90 then 'Information Technology'
    when 60 then 'Finance'
    else 'Other'
    end as dept_name
from hr.EMPLOYEES

select first_name,salary,salary,
case 
    when salary > 20000 then 'High Salary'
    when salary < 10000 then 'Low Salary'
    else 'Other'
    end as salary_stats
from hr.EMPLOYEES

-- using case on order by

SELECT employee_id,
       first_name,
       department_id
FROM hr.employees
ORDER BY
       CASE
           WHEN department_id = 60 THEN 1
           WHEN department_id = 80 THEN 3
           WHEN department_id = 50 THEN 2
           ELSE 4
       END;