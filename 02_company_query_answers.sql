-- COMPANY SQL PRACTICE: 60 ANSWERS
-- Database: company_sql_practice | MySQL 8.0+
-- Several query patterns from the uploaded practice file have been retained and corrected.
-- INSERT/UPDATE/DELETE questions are comments so the seed data is not changed on Run All.
USE company_sql_practice;

-- ============================================================
-- EASY (20)
-- ============================================================
-- E01. Retrieve all employees.
SELECT * FROM employee;

-- E02. Retrieve all departments.
SELECT * FROM department;

-- E03. Employee first name, last name and designation.
SELECT first_name, last_name, designation FROM employee;

-- E04. Female employees.
SELECT * FROM employee WHERE gender = 'F';

-- E05. Inactive employees.
SELECT * FROM employee WHERE status = 'Inactive';

-- E06. Employees living in Bangalore (exact filter from the question).
SELECT * FROM employee WHERE city = 'Bangalore';
-- Note: rows labelled 'Bengaluru' are a spelling variant; use IN ('Bangalore', 'Bengaluru') if the analysis should combine both labels.

-- E07. Salary greater than 50000.
SELECT * FROM employee WHERE salary > 50000;

-- E08. Salary between 40000 and 60000 inclusive.
SELECT * FROM employee WHERE salary BETWEEN 40000 AND 60000;

-- E09. Distinct employee cities, including NULL if present.
SELECT DISTINCT city FROM employee ORDER BY city;

-- E10. Distinct designations.
SELECT DISTINCT designation FROM employee ORDER BY designation;

-- E11. Employees sorted by salary descending.
SELECT * FROM employee ORDER BY salary DESC, emp_id;

-- E12. Employees sorted by first name ascending.
SELECT * FROM employee ORDER BY first_name, last_name;

-- E13. First names beginning with A.
SELECT * FROM employee WHERE first_name LIKE 'A%';

-- E14. Email contains 'agarwal'.
SELECT * FROM employee WHERE email LIKE '%agarwal%';

-- E15. Employees without a manager.
SELECT * FROM employee WHERE manager_id IS NULL;

-- E16. Employees who report to a manager.
SELECT * FROM employee WHERE manager_id IS NOT NULL;

-- E17. Total employee records, including rows with NULL salary.
SELECT COUNT(*) AS total_employees FROM employee;

-- E18. Insert one synthetic employee (uncomment and run once only).
-- INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary,
--     bonus, designation, email, city, status, manager_id)
-- VALUES (51, 'Aarohi', 'Sharma', 'F', '2001-04-12', '2025-07-01', 1,
--     42000, 2500, 'Junior Data Analyst', 'aarohi.sharma51@company.example', 'Lucknow', 'Active', 8);

-- E19. Update employee 15 salary to 40000 (uncomment if needed).
-- UPDATE employee SET salary = 40000 WHERE emp_id = 15;

-- E20. Delete employee 9. This employee has no direct reports in the sample data.
-- Uncomment only if intentionally changing the seed data.
-- DELETE FROM employee WHERE emp_id = 9;

-- ============================================================
-- INTERMEDIATE (20)
-- ============================================================
-- I01. Employee name and department name (INNER JOIN).
SELECT e.first_name, e.last_name, d.dept_name
FROM employee AS e
INNER JOIN department AS d ON e.dept_id = d.dept_id
ORDER BY e.first_name, e.last_name;

-- I02. Employee count per department, including zero-employee departments.
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM department AS d
LEFT JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY d.dept_name;

-- I03. Total salary paid in each department (SUM ignores NULL salaries).
SELECT d.dept_name, SUM(e.salary) AS total_salary_paid
FROM department AS d
LEFT JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY d.dept_name;

-- I04. Average salary per department.
SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS average_salary
FROM department AS d
LEFT JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY d.dept_name;

-- I05. Departments with more than 3 employees.
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM department AS d JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(e.emp_id) > 3
ORDER BY employee_count DESC;

-- I06. Departments with average salary above 50000.
SELECT d.dept_name, AVG(e.salary) AS average_salary
FROM department AS d JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) > 50000;

-- I07. Employee with their manager's name (self JOIN; preserves top-level employees).
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM employee AS e
LEFT JOIN employee AS m ON e.manager_id = m.emp_id
ORDER BY e.emp_id;

-- I08. Employees earning above the overall average salary.
SELECT emp_id, first_name, last_name, salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee)
ORDER BY salary DESC;

-- I09. Employee(s) earning the second-highest distinct salary (handles ties).
SELECT emp_id, first_name, last_name, salary
FROM employee
WHERE salary = (
    SELECT MAX(salary) FROM employee
    WHERE salary < (SELECT MAX(salary) FROM employee WHERE salary IS NOT NULL)
)
ORDER BY emp_id;

-- I10. Designation contains 'Executive'.
SELECT first_name, last_name, designation
FROM employee
WHERE designation LIKE '%Executive%'
ORDER BY first_name;

-- I11. Employees in IT or Finance.
SELECT e.emp_id, e.first_name, e.last_name, d.dept_name
FROM employee AS e JOIN department AS d ON e.dept_id = d.dept_id
WHERE d.dept_name IN ('IT', 'Finance')
ORDER BY d.dept_name, e.emp_id;

-- I12. Salary + bonus. COALESCE treats unknown bonus as zero for this calculated total.
SELECT emp_id, first_name, last_name, salary, bonus,
       salary + COALESCE(bonus, 0) AS salary_plus_bonus
FROM employee
ORDER BY emp_id;

-- I13. Age in completed years. NULL DOB returns NULL.
SELECT emp_id, first_name, last_name,
       TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age_years
FROM employee ORDER BY emp_id;

-- I14. Employees who joined after year 2018.
SELECT * FROM employee WHERE doj >= '2019-01-01' ORDER BY doj;

-- I15. Completed years employed.
SELECT emp_id, first_name, last_name,
       TIMESTAMPDIFF(YEAR, doj, CURDATE()) AS years_employed
FROM employee ORDER BY emp_id;

-- I16. Department, location and count of Active employees.
SELECT d.dept_name, d.location,
       SUM(CASE WHEN e.status = 'Active' THEN 1 ELSE 0 END) AS active_employees
FROM department AS d
LEFT JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name, d.location
ORDER BY d.dept_name;

-- I17. Full employee name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employee ORDER BY full_name;

-- I18. Name uppercased and designation lowercased.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS employee_name,
       LOWER(designation) AS designation_lowercase
FROM employee;

-- I19. Salary classification; NULL salary gets an explicit label.
SELECT emp_id, first_name, last_name, salary,
       CASE WHEN salary IS NULL THEN 'Unknown'
            WHEN salary >= 90000 THEN 'High'
            WHEN salary >= 50000 THEN 'Medium'
            ELSE 'Low' END AS salary_band
FROM employee;

-- I20. Departments with zero employees.
SELECT d.dept_id, d.dept_name
FROM department AS d
LEFT JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(e.emp_id) = 0;

-- ============================================================
-- HARD (20)
-- ============================================================
-- H01. Top 3 highest-paid employees without a window function.
SELECT emp_id, first_name, last_name, salary
FROM employee WHERE salary IS NOT NULL
ORDER BY salary DESC, emp_id
LIMIT 3;

-- H02. Employees earning more than their own manager.
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       e.salary AS employee_salary,
       CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
       m.salary AS manager_salary
FROM employee AS e
JOIN employee AS m ON e.manager_id = m.emp_id
WHERE e.salary IS NOT NULL AND m.salary IS NOT NULL AND e.salary > m.salary;

-- H03. Department(s) with the highest average salary, using a subquery.
SELECT d.dept_name, AVG(e.salary) AS average_salary
FROM department AS d JOIN employee AS e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) = (
    SELECT MAX(department_average)
    FROM (
        SELECT AVG(e2.salary) AS department_average
        FROM employee AS e2
        WHERE e2.dept_id IS NOT NULL
        GROUP BY e2.dept_id
    ) AS department_averages
);

-- H04. Each manager and number of direct reports.
SELECT m.emp_id AS manager_id,
       CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
       COUNT(e.emp_id) AS direct_reports
FROM employee AS m
JOIN employee AS e ON e.manager_id = m.emp_id
GROUP BY m.emp_id, m.first_name, m.last_name
ORDER BY direct_reports DESC, manager_name;

-- H05. Employees who do not manage anyone.
SELECT e.emp_id, e.first_name, e.last_name, e.designation
FROM employee AS e
LEFT JOIN employee AS report ON report.manager_id = e.emp_id
WHERE report.emp_id IS NULL
ORDER BY e.emp_id;

-- H06. Employee(s) with maximum salary within their own department.
SELECT e.emp_id, e.first_name, e.last_name, e.dept_id, e.salary
FROM employee AS e
WHERE e.dept_id IS NOT NULL AND e.salary IS NOT NULL
  AND e.salary = (
      SELECT MAX(e2.salary) FROM employee AS e2
      WHERE e2.dept_id = e.dept_id AND e2.salary IS NOT NULL
  )
ORDER BY e.dept_id, e.emp_id;

-- H07. Departments where salary total exceeds the allocated budget.
SELECT d.dept_name, d.budget, SUM(e.salary) AS total_salary
FROM department AS d
JOIN employee AS e ON e.dept_id = d.dept_id
WHERE d.budget IS NOT NULL
GROUP BY d.dept_id, d.dept_name, d.budget
HAVING SUM(e.salary) > d.budget
ORDER BY total_salary DESC;

-- H08. Departments with at least one employee earning more than 80000 (EXISTS).
SELECT d.dept_id, d.dept_name
FROM department AS d
WHERE EXISTS (
    SELECT 1 FROM employee AS e
    WHERE e.dept_id = d.dept_id AND e.salary > 80000
);

-- H09. Rank employees by salary within each department.
SELECT e.emp_id, e.first_name, e.last_name, d.dept_name, e.salary,
       DENSE_RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS salary_rank
FROM employee AS e
LEFT JOIN department AS d ON d.dept_id = e.dept_id
WHERE e.dept_id IS NOT NULL AND e.salary IS NOT NULL
ORDER BY d.dept_name, salary_rank, e.emp_id;

-- H10. Third-highest distinct salary without LIMIT/OFFSET.
SELECT e.emp_id, e.first_name, e.last_name, e.salary
FROM employee AS e
WHERE e.salary IS NOT NULL
  AND 2 = (
      SELECT COUNT(DISTINCT e2.salary)
      FROM employee AS e2 WHERE e2.salary > e.salary
  )
ORDER BY e.emp_id;

-- H11. Employee, manager and manager's manager.
SELECT e.emp_id,
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
       CONCAT(mm.first_name, ' ', mm.last_name) AS manager_of_manager
FROM employee AS e
LEFT JOIN employee AS m ON e.manager_id = m.emp_id
LEFT JOIN employee AS mm ON m.manager_id = mm.emp_id
ORDER BY e.emp_id;

-- H12. Employees earning more than every non-NULL salary in HR.
SELECT e.emp_id, e.first_name, e.last_name, e.salary
FROM employee AS e
WHERE e.salary IS NOT NULL
  AND e.salary > ALL (
      SELECT e2.salary FROM employee AS e2
      JOIN department AS d2 ON d2.dept_id = e2.dept_id
      WHERE d2.dept_name = 'HR' AND e2.salary IS NOT NULL
  )
ORDER BY e.salary DESC;

-- H13. Employees earning more than at least one non-NULL salary in Sales.
SELECT e.emp_id, e.first_name, e.last_name, e.salary
FROM employee AS e
WHERE e.salary IS NOT NULL
  AND e.salary > ANY (
      SELECT e2.salary FROM employee AS e2
      JOIN department AS d2 ON d2.dept_id = e2.dept_id
      WHERE d2.dept_name = 'Sales' AND e2.salary IS NOT NULL
  )
ORDER BY e.salary DESC;

-- H14. Create/replace a view of active employees and their departments.
CREATE OR REPLACE VIEW v_active_employee_department AS
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       d.dept_name, e.salary
FROM employee AS e
LEFT JOIN department AS d ON d.dept_id = e.dept_id
WHERE e.status = 'Active';
-- Inspect view separately when desired:
-- SELECT * FROM v_active_employee_department;

-- H15. Count employees sharing email domains. NULL/invalid emails are skipped.
SELECT SUBSTRING_INDEX(email, '@', -1) AS email_domain, COUNT(*) AS employee_count
FROM employee
WHERE email IS NOT NULL AND email LIKE '%@%'
GROUP BY SUBSTRING_INDEX(email, '@', -1)
HAVING COUNT(*) > 1
ORDER BY employee_count DESC, email_domain;

-- H16. Combine employee names from IT and Finance using UNION.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employee AS e JOIN department AS d ON d.dept_id = e.dept_id
WHERE d.dept_name = 'IT'
UNION
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employee AS e JOIN department AS d ON d.dept_id = e.dept_id
WHERE d.dept_name = 'Finance'
ORDER BY employee_name;

-- H17. Departments where every employee earns above the company-wide average.
-- A NULL salary does not satisfy 'above average'. Empty departments are excluded.
WITH company_average AS (SELECT AVG(salary) AS avg_salary FROM employee)
SELECT d.dept_id, d.dept_name
FROM department AS d
CROSS JOIN company_average AS ca
WHERE EXISTS (SELECT 1 FROM employee AS e WHERE e.dept_id = d.dept_id)
  AND NOT EXISTS (
      SELECT 1 FROM employee AS e
      WHERE e.dept_id = d.dept_id
        AND (e.salary IS NULL OR e.salary <= ca.avg_salary)
  );

-- H18. Employees with longer tenure than their manager (earlier DOJ).
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       e.doj AS employee_doj,
       CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
       m.doj AS manager_doj
FROM employee AS e
JOIN employee AS m ON m.emp_id = e.manager_id
WHERE e.doj IS NOT NULL AND m.doj IS NOT NULL AND e.doj < m.doj
ORDER BY e.doj;

-- H19. Each department's payroll as a percentage of company-wide payroll.
WITH department_payroll AS (
    SELECT d.dept_id, d.dept_name, COALESCE(SUM(e.salary), 0) AS total_salary
    FROM department AS d
    LEFT JOIN employee AS e ON e.dept_id = d.dept_id
    GROUP BY d.dept_id, d.dept_name
), company_payroll AS (
    SELECT SUM(salary) AS company_total_salary FROM employee
)
SELECT dp.dept_name, dp.total_salary, cp.company_total_salary,
       ROUND(100.0 * dp.total_salary / NULLIF(cp.company_total_salary, 0), 2) AS payroll_percentage
FROM department_payroll AS dp
CROSS JOIN company_payroll AS cp
ORDER BY payroll_percentage DESC, dp.dept_name;

-- H20. Mid-level managers: manage someone and report to someone else.
SELECT DISTINCT m.emp_id, CONCAT(m.first_name, ' ', m.last_name) AS mid_level_manager,
       CONCAT(boss.first_name, ' ', boss.last_name) AS reports_to
FROM employee AS m
JOIN employee AS boss ON boss.emp_id = m.manager_id
WHERE EXISTS (SELECT 1 FROM employee AS report WHERE report.manager_id = m.emp_id)
ORDER BY m.emp_id;

-- ============================================================
-- ADDITIONAL PRACTICE QUERIES (4)
-- Merged from the original practice file so all answer queries are in this script.
-- ============================================================

-- A01. Average salary by gender.
SELECT gender, ROUND(AVG(salary), 2) AS average_salary
FROM employee
GROUP BY gender
ORDER BY gender;

-- A02. Salary status using CASE; boundaries at 50,000 and 90,000 are covered.
SELECT emp_id, first_name, last_name, salary,
       CASE WHEN salary IS NULL THEN 'Salary not available'
            WHEN salary > 90000 THEN 'Highly paid employee'
            WHEN salary >= 50000 THEN 'Well paid employee'
            ELSE 'Under paid' END AS salary_status
FROM employee
ORDER BY salary DESC;

-- A03. Salaries between 50,000 and 90,000, inclusive.
SELECT emp_id, first_name, last_name, salary
FROM employee
WHERE salary BETWEEN 50000 AND 90000
ORDER BY salary DESC;

-- A04. Salary plus bonus per employee; COALESCE handles a NULL bonus.
-- If salary itself is NULL, the calculated result remains NULL.
SELECT emp_id, first_name, last_name, salary, bonus,
       salary + COALESCE(bonus, 0) AS salary_plus_bonus
FROM employee
ORDER BY emp_id;
