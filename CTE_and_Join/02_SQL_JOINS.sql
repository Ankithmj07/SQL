-- BEGIN
--     EXECUTE IMMEDIATE 'DROP TABLE employee_project';
-- EXCEPTION
--     WHEN OTHERS THEN
--         NULL;
-- END;
-- /

-- BEGIN
--     EXECUTE IMMEDIATE 'DROP TABLE employee';
-- EXCEPTION
--     WHEN OTHERS THEN
--         NULL;
-- END;

-- CREATE TABLE employee
-- (
--     emp_id       NUMBER PRIMARY KEY,
--     emp_name     VARCHAR2(50),
--     department   VARCHAR2(30),
--     manager_id   NUMBER,
--     salary       NUMBER(10,2),
--     city         VARCHAR2(30)
-- );

-- CREATE TABLE employee_project
-- (
--     assignment_id NUMBER PRIMARY KEY,
--     emp_id        NUMBER,
--     project_name  VARCHAR2(50),
--     project_role  VARCHAR2(30),
--     hours_worked  NUMBER,
--     status        VARCHAR2(20)
-- );

-- INSERT INTO employee
-- VALUES (101, 'Arun', 'IT', NULL, 90000, 'Bangalore');

-- INSERT INTO employee
-- VALUES (102, 'Priya', 'IT', 101, 65000, 'Hyderabad');

-- INSERT INTO employee
-- VALUES (103, 'Rahul', 'HR', NULL, 55000, 'Chennai');

-- INSERT INTO employee
-- VALUES (104, 'Sneha', 'Finance', 106, 70000, NULL);

-- INSERT INTO employee
-- VALUES (105, 'Kiran', 'IT', 101, NULL, 'Bangalore');

-- INSERT INTO employee
-- VALUES (106, 'Meena', 'Finance', NULL, 95000, 'Mumbai');

-- INSERT INTO employee
-- VALUES (107, 'Ravi', NULL, 101, 60000, 'Pune');

-- INSERT INTO employee
-- VALUES (108, 'Anjali', 'HR', 103, 50000, 'Bangalore');

-- INSERT INTO employee
-- VALUES (109, 'Vijay', 'Sales', NULL, 75000, 'Delhi');

-- INSERT INTO employee
-- VALUES (110, 'Deepa', 'Sales', 109, 58000, NULL);

-- COMMIT;

-- INSERT INTO employee_project
-- VALUES (1, 101, 'ERP Migration', 'Manager', 120, 'Active');

-- INSERT INTO employee_project
-- VALUES (2, 101, 'Cloud Migration', 'Architect', 80, 'Active');

-- INSERT INTO employee_project
-- VALUES (3, 102, 'ERP Migration', 'Developer', 150, 'Active');

-- INSERT INTO employee_project
-- VALUES (4, 102, 'AI Platform', 'Developer', 100, 'Completed');

-- INSERT INTO employee_project
-- VALUES (5, 103, 'HR Automation', 'Lead', 90, 'Active');

-- INSERT INTO employee_project
-- VALUES (6, 104, 'Finance Portal', 'Analyst', 110, 'Active');

-- INSERT INTO employee_project
-- VALUES (7, 104, 'Audit System', NULL, 60, 'Completed');

-- INSERT INTO employee_project
-- VALUES (8, 106, 'Finance Portal', 'Manager', 130, 'Active');

-- INSERT INTO employee_project
-- VALUES (9, 108, 'HR Automation', 'Analyst', NULL, 'Active');

-- INSERT INTO employee_project
-- VALUES (10, 999, 'External Project', 'Consultant', 50, 'Active');

-- INSERT INTO employee_project
-- VALUES (11, NULL, 'Unassigned Project', 'Developer', 40, 'Pending');

-- COMMIT;

-- SELECT *
-- FROM employee
-- ORDER BY emp_id;

-- SELECT *
-- FROM employee_project
-- ORDER BY assignment_id;

SELECT
    e.emp_id,
    e.emp_name,
    e.department,
    p.project_name
FROM employee e
INNER JOIN employee_project p
    ON e.emp_id = p.emp_id
ORDER BY e.emp_id;