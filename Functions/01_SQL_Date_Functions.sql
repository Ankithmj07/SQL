-- SYSDATE - Gives the current date and time according to the servers clock

select sysdate
from dual

-- SYSTIMESTAMP - Gives the current timestamo with fractional secs and time zone

-- 2026-09-25T16:49:51.152822Z 

-- 2026-09-25 -> yyyy-mm-dd
-- T -> seperator between date and time
-- 16:49:51 -> HH:MM:SS
-- 15282 -> Fractional seconds
-- Z -> UTC timezone (Zulu timezone)

-- UTC + 00:00 (Greenwich London, UK)

select systimestamp
from dual

-- ADD_MONTHS() -> Add months to current date

select sysdate, add_months(sysdate,3) from dual

select first_name,hire_date,
add_months(hire_date,6) as probation
from hr.EMPLOYEES

-- MONTHS_BETWEEN() -> Gives the number of months between the two dates

select first_name,hire_date,
ceil(MONTHS_BETWEEN(sysdate,hire_date)) as working_months
from hr.EMPLOYEES

-- LAST_DAY() - Gives last day of current month

select sysdate, last_day(sysdate)
from dual

-- NEXT_DAY(date, day) - Gives the mentioned day from next week, like next monday

select sysdate, next_day(sysdate,'friday')
from dual

select first_name, hire_date,
next_day(hire_date,'monday') as next_monday
from hr.EMPLOYEES

-- EXTRACT() -> extcat specific part form a date

select sysdate, 
extract(day from sysdate) as curr_day,
extract(month from sysdate) as curr_month,
extract(year from sysdate) as curr_year
from dual