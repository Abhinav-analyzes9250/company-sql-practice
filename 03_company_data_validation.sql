-- COMPANY DATA VALIDATION CHECKS
-- Database: company_sql_practice. NULLs in optional fields are intentionally present.
USE company_sql_practice;

-- 1. Row counts: expected 9 departments and 50 employees.
SELECT 'department' AS table_name, COUNT(*) AS row_count FROM department
UNION ALL
SELECT 'employee', COUNT(*) FROM employee;

-- 2. Count NULLs in common validation fields.
SELECT
  SUM(dept_id IS NULL) AS missing_department,
  SUM(manager_id IS NULL) AS no_manager_assigned,
  SUM(salary IS NULL) AS missing_salary,
  SUM(bonus IS NULL) AS missing_bonus,
  SUM(dob IS NULL) AS missing_dob,
  SUM(doj IS NULL) AS missing_join_date,
  SUM(email IS NULL) AS missing_email,
  SUM(city IS NULL) AS missing_city,
  SUM(status IS NULL) AS missing_status
FROM employee;

-- 3. Out-of-range/negative salary values; returns rows only if found.
SELECT emp_id, salary FROM employee
WHERE salary IS NOT NULL AND salary < 0;
SELECT emp_id, bonus FROM employee
WHERE bonus IS NOT NULL AND bonus < 0;

-- 4. Hire date before date of birth; returns rows only if found.
SELECT emp_id, dob, doj FROM employee
WHERE dob IS NOT NULL AND doj IS NOT NULL AND doj < dob;

-- 5. Employees with no department assignment (intentional in the sample).
SELECT emp_id, first_name, last_name FROM employee WHERE dept_id IS NULL;

-- 6. Employees without an assigned manager (root-level leaders and missing manager data).
SELECT emp_id, first_name, last_name FROM employee WHERE manager_id IS NULL;

-- 7. Employee count by department, including the department with no staff.
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM department AS d LEFT JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name ORDER BY d.dept_name;

-- 8. Email domain frequency and missing email visibility.
SELECT CASE WHEN email IS NULL OR email NOT LIKE '%@%' THEN 'Missing/invalid email'
            ELSE SUBSTRING_INDEX(email, '@', -1) END AS email_domain,
       COUNT(*) AS employee_count
FROM employee GROUP BY email_domain ORDER BY employee_count DESC;

-- 9. Direct report count; zero means the employee is not a manager.
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       COUNT(r.emp_id) AS direct_reports
FROM employee AS e LEFT JOIN employee AS r ON r.manager_id = e.emp_id
GROUP BY e.emp_id, e.first_name, e.last_name ORDER BY direct_reports DESC, e.emp_id;

-- 10. Required names are protected by NOT NULL; this should return zero rows.
SELECT emp_id FROM employee WHERE first_name IS NULL OR last_name IS NULL;
