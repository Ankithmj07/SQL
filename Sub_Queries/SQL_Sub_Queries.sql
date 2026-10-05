-- SUB QUERIES

select *
from hr.EMPLOYEES
where salary > 
(select avg(salary) from hr.EMPLOYEES)

-- IN operator -> To handle the multiple values returned from sub query

select * from hr.EMPLOYEES
where DEPARTMENT_ID in 
(select department_id
 from hr.DEPARTMENTS
 where department_name like '%Sales%'
)


-- Sub queries inside the FROM

select department_id, avg_salary
from (
    select department_id, avg(salary) as avg_salary
    from hr.employees
    group by department_id
)
where avg_salary > 8000

-- 3 level sub queries

select first_name,salary,department_id
from hr.EMPLOYEES
where DEPARTMENT_ID in 
(
    select department_id 
    from hr.EMPLOYEES
    where salary = (
        select max(salary)
        from hr.EMPLOYEES
    )
)

