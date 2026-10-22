# SQL Practice Questions — Employee & Department

Based on `employee_department.sql`. 20 Easy + 20 Intermediate + 20 Hard = 60 questions.
Covers: SELECT basics, WHERE/BETWEEN/IN/LIKE, DISTINCT, ORDER BY, DML (INSERT/UPDATE/DELETE),
JOIN, self-JOIN, GROUP BY, HAVING, aggregates, subqueries (simple, correlated, nested),
EXISTS, ALL/ANY, string & date functions, CASE, VIEW, UNION, and window functions (RANK/DENSE_RANK).

---

## EASY (20)

1. Retrieve all columns and rows from the `employee` table.
2. Retrieve all columns and rows from the `department` table.
3. Display `first_name`, `last_name`, and `designation` of all employees.
4. List all female employees (`gender = 'F'`).
5. List all employees whose `status` is `'Inactive'`.
6. Find all employees living in `'Bangalore'`.
7. Display employees with a salary greater than 50000.
8. Display employees with a salary between 40000 and 60000 (use `BETWEEN`).
9. List all distinct cities employees live in.
10. List all distinct designations across the company.
11. Display all employees sorted by salary in descending order.
12. Display all employees sorted by `first_name` in ascending order.
13. Find all employees whose first name starts with the letter 'A'.
14. Find all employees whose email contains `'agarwal'`.
15. Display all employees who don't report to a manager (`manager_id IS NULL`).
16. Display all employees who report to a manager (`manager_id IS NOT NULL`).
17. Count the total number of employees in the company.
18. Insert a new employee of your choice into the `employee` table.
19. Update the salary of the employee with `emp_id = 15` to 40000.
20. Delete the employee record with `emp_id = 9`.

---

## INTERMEDIATE (20)

1. Display each employee's name along with their department name (`INNER JOIN` employee & department).
2. Display department name and the number of employees in each department (`GROUP BY`).
3. Display department name and total salary paid in each department.
4. Display department name and average salary of employees in each department.
5. List departments having more than 3 employees (`HAVING`).
6. List departments where the average salary is above 50000 (`HAVING`).
7. Display each employee's name along with their manager's name (self `JOIN`).
8. Display employees who earn more than the average salary of the entire company (subquery).
9. Display the employee with the second highest salary (subquery).
10. Display all employees whose designation contains the word `'Executive'` (`LIKE`).
11. Display employees who work in either the `'IT'` or `'Finance'` department (`IN`).
12. Display each employee's name along with a new column showing `salary + bonus`.
13. Display the age of each employee in years, calculated from `dob`.
14. Display employees who joined the company after the year 2018.
15. Display the number of years each employee has worked at the company, calculated from `doj`.
16. Display department name, location, and count of only `'Active'` employees in each department.
17. Display the full name (`first_name` + `last_name`) of each employee using string concatenation.
18. Display each employee's name in uppercase and designation in lowercase.
19. Use `CASE WHEN` to label employees as `'High'`, `'Medium'`, or `'Low'` earners based on salary ranges.
20. Display departments that currently have zero employees (if any), using `LEFT JOIN`.

---

## HARD (20)

1. Display the top 3 highest paid employees (subquery/`LIMIT`, no window function).
2. Find employees who earn more than their own manager (self `JOIN` + comparison).
3. Find the department with the highest average salary using a subquery.
4. Display each manager along with the total number of employees they manage (self `JOIN` + `GROUP BY`).
5. Find employees who do not manage anyone (self `JOIN` + `LEFT JOIN`/`IS NULL`).
6. Display the employee(s) who earn the maximum salary within their own department (correlated subquery).
7. Find departments whose total employee salary exceeds the department's allocated `budget`.
8. Use `EXISTS` to list departments that have at least one employee earning above 80000.
9. Use `RANK()` or `DENSE_RANK()` to rank employees by salary within each department (window function).
10. Find the third highest salary in the company without using `LIMIT`/`OFFSET`.
11. Display a full reporting hierarchy — employee, their manager, and their manager's manager (multi-level self `JOIN`).
12. Find all employees whose salary is greater than every employee in the `'HR'` department (`ALL`).
13. Find all employees whose salary is greater than at least one employee in the `'Sales'` department (`ANY`).
14. Create a `VIEW` that shows employee name, department name, and salary for only `'Active'` employees.
15. Find how many employees share the same email domain (duplicate/grouping check).
16. Combine employee names from the `'IT'` and `'Finance'` departments into one result using `UNION`.
17. Find department(s) where every employee earns above the company-wide average salary (correlated subquery / `NOT EXISTS`).
18. Display employees who have been with the company longer than their own manager (date comparison + self `JOIN`).
19. Using a CTE (or subquery), calculate each department's total salary as a percentage of the company's total salary.
20. Find employees who are managers themselves but also report to someone else — i.e., mid-level managers (nested self `JOIN`).
