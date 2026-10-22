-- COMPANY SQL PRACTICE PROJECT: schema + synthetic seed data
-- MySQL 8.0+ recommended. This script only works in company_sql_practice.
-- Re-running drops/recreates the two project tables in that database.

CREATE DATABASE IF NOT EXISTS company_sql_practice;
USE company_sql_practice;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(60) NOT NULL UNIQUE,
    location VARCHAR(60) NULL,
    budget DECIMAL(12,2) NULL
) ENGINE=InnoDB;

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NULL,
    dob DATE NULL,
    doj DATE NULL,
    dept_id INT NULL,
    salary DECIMAL(12,2) NULL,
    bonus DECIMAL(10,2) NULL,
    designation VARCHAR(70) NULL,
    email VARCHAR(120) NULL UNIQUE,
    city VARCHAR(60) NULL,
    status VARCHAR(15) NULL DEFAULT 'Active',
    manager_id INT NULL,
    CONSTRAINT fk_employee_department FOREIGN KEY (dept_id)
        REFERENCES department(dept_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id)
        REFERENCES employee(emp_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    INDEX idx_employee_dept_id (dept_id),
    INDEX idx_employee_manager_id (manager_id),
    INDEX idx_employee_doj (doj)
) ENGINE=InnoDB;

-- Nine departments; Legal intentionally has no staff for LEFT JOIN practice.
INSERT INTO department (dept_id, dept_name, location, budget) VALUES
    (1, 'IT', 'Bengaluru', 750000.0),
    (2, 'Finance', 'Mumbai', 300000.0),
    (3, 'HR', 'Lucknow', 280000.0),
    (4, 'Sales', 'Delhi', 400000.0),
    (5, 'Marketing', 'Noida', 250000.0),
    (6, 'Operations', 'Pune', 350000.0),
    (7, 'Customer Support', 'Hyderabad', 200000.0),
    (8, 'Research & Analytics', 'Bengaluru', 500000.0),
    (9, 'Legal', 'New Delhi', 120000.0);


-- Two top-level managers first. Remaining employees follow in manager-ID order.
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (1, 'Aarav', 'Mehta', 'M', '1978-04-12', '2008-06-01', 1, 180000, 25000, 'Chief Technology Officer', 'aarav.mehta@company.example', 'Bengaluru', 'Active', NULL);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (2, 'Nisha', 'Rao', 'F', '1980-09-03', '2009-02-16', 6, 150000, 20000, 'Chief Operations Officer', 'nisha.rao@company.example', 'Pune', 'Active', NULL);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (3, 'Rohan', 'Sharma', 'M', '1985-03-24', '2012-04-02', 1, 125000, 15000, 'IT Manager', 'rohan.sharma@company.example', 'Bengaluru', 'Active', 1);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (4, 'Priya', 'Kapoor', 'F', '1987-11-19', '2011-08-15', 2, 118000, 12000, 'Finance Manager', NULL, 'Mumbai', 'Active', 1);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (5, 'Karan', 'Agarwal', 'M', '1986-06-08', '2013-01-10', 3, 108000, 10000, 'HR Manager', 'karan.agarwal@company.example', 'Lucknow', 'Active', 1);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (6, 'Meera', 'Iyer', 'F', '1988-07-22', '2014-05-12', 4, 112000, 18000, 'Sales Manager', 'meera.iyer@company.example', 'Delhi', 'Active', 2);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (7, 'Vivek', 'Sinha', 'M', '1989-02-11', '2015-03-09', 5, 99000, 12000, 'Marketing Manager', 'vivek.sinha@company.example', 'Noida', 'Active', 2);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (8, 'Sanjay', 'Verma', 'M', '1990-12-01', '2016-04-18', 1, 92000, 9000, 'Engineering Team Lead', 'sanjay.verma@company.example', 'Bengaluru', 'Active', 3);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (9, 'Aditi', 'Agarwal', 'F', '1997-10-19', '2020-07-01', 3, 47000, 3000, 'HR Executive', 'aditi.agarwal@gmail.com', 'Lucknow', 'Active', 5);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (10, 'Aman', 'Khan', 'M', '1995-05-18', '2019-06-10', 1, 58000, 5000, 'IT Executive', 'aman.khan@company.example', 'Bangalore', 'Active', 8);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (11, 'Isha', 'Patel', 'F', '1994-06-27', '2018-02-12', 1, 72000, 7000, 'Data Analyst', 'isha.patel@company.example', 'Bengaluru', 'Active', 8);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (12, 'Kabir', 'Das', 'M', '1992-01-06', '2017-09-04', 1, 85000, 8500, 'Senior Data Analyst', 'kabir.das@company.example', 'Hyderabad', 'Active', 3);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (13, 'Aditi', 'Nair', 'F', '1993-04-09', '2016-01-11', 1, 78000, 8000, 'Software Engineer', 'aditi.nair@company.example', 'Bengaluru', 'Active', 3);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (14, 'Ritu', 'Malhotra', 'F', '1992-08-12', '2018-11-20', 2, 54000, 4500, 'Accountant', 'ritu.malhotra@company.example', 'Mumbai', 'Active', 4);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (15, 'Abhishek', 'Jain', 'M', '1996-02-28', '2020-03-02', 2, 46000, 2500, 'Finance Executive', 'abhishek.jain@company.example', 'Kanpur', 'Active', 4);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (16, 'Sneha', 'Joshi', 'F', '1997-09-15', '2021-08-16', 3, 44000, 3000, 'HR Executive', 'sneha.joshi@company.example', 'Lucknow', 'Active', 5);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (17, 'Varun', 'Gupta', 'M', '1995-12-17', '2020-02-03', 4, 55000, 6000, 'Sales Executive', 'varun.gupta@company.example', 'Delhi', 'Active', 6);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (18, 'Pooja', 'Bose', 'F', '1998-03-21', '2022-04-25', 4, 38000, 1800, 'Sales Associate', 'pooja.bose@company.example', 'Kolkata', 'Inactive', 6);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (19, 'Nitin', 'Chauhan', 'M', '1996-07-04', '2020-11-09', 5, 51000, 4500, 'Marketing Executive', 'nitin.chauhan@company.example', 'Noida', 'Active', 7);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (20, 'Ananya', 'Reddy', 'F', '1991-10-30', '2017-06-19', 6, 87000, 9000, 'Business Analyst', 'ananya.reddy@company.example', 'Pune', 'Active', 2);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (21, 'Farhan', 'Ali', 'M', '1997-02-14', '2021-05-17', 7, 42000, 2500, 'Customer Support Executive', NULL, 'Hyderabad', 'Active', 2);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (22, 'Dev', 'Kulkarni', 'M', '1988-01-26', '2015-03-12', 1, 76000, 7500, 'Data Engineer', 'dev.kulkarni@company.example', 'Bengaluru', 'Active', 8);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (23, 'Simran', 'Kaur', 'F', '1994-05-11', '2019-07-15', 1, 62000, 5000, 'QA Analyst', 'simran.kaur@company.example', 'Bangalore', 'Active', 3);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (24, 'Neeraj', 'Tiwari', 'M', '1993-11-08', '2017-10-30', 2, 52000, 4000, 'Accountant', 'neeraj.tiwari@company.example', 'Mumbai', 'Active', 4);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (25, 'Kavita', 'Singh', 'F', '1991-08-03', '2016-05-16', 3, 49000, 4000, 'Recruiter', 'kavita.singh@company.example', 'Lucknow', 'Active', 5);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (26, 'Yash', 'Arora', 'M', '1995-04-20', '2020-09-07', 4, 60000, 6500, 'Sales Analyst', 'yash.arora@company.example', 'Delhi', 'Active', 6);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (27, 'Tanya', 'Mehra', 'F', '1997-12-12', '2021-01-18', 4, 47000, 3500, 'Sales Executive', 'tanya.mehra@company.example', 'Jaipur', 'Active', 6);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (28, 'Rajat', 'Kapoor', 'M', '1996-05-28', '2020-06-22', 5, 46000, 3000, 'Content Executive', 'rajat.kapoor@company.example', 'Noida', 'Active', 7);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (29, 'Diya', 'Shah', 'F', '1998-10-02', '2022-07-11', 5, 56000, 5000, 'Digital Marketing Executive', 'diya.shah@company.example', 'Ahmedabad', 'Inactive', 7);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (30, 'Manish', 'Yadav', 'M', '1992-03-16', '2018-01-08', 6, 67000, 6000, 'Operations Analyst', 'manish.yadav@company.example', 'Pune', 'Active', 2);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (31, 'Rhea', 'Dutta', 'F', '1998-06-23', '2022-08-08', 1, 39000, 2000, 'IT Support Executive', 'rhea.dutta@company.example', 'Bengaluru', 'Active', 8);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (32, 'Kunal', 'Mishra', 'M', '2002-09-21', '2024-06-03', 1, 18000, NULL, 'Data Analyst Intern', 'kunal.mishra@company.example', 'Bangalore', 'Active', 11);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (33, 'Maya', 'Fernandes', 'F', NULL, '2024-01-15', 3, 15000, NULL, 'HR Intern', 'maya.fernandes@company.example', 'Goa', 'Active', 25);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (34, 'Arjun', 'Pillai', 'M', '2001-07-11', '2023-05-22', 2, 16000, NULL, 'Finance Intern', 'arjun.pillai@company.example', 'Kochi', 'Active', 14);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (35, 'Zoya', 'Khan', 'F', '1999-12-31', '2022-11-14', 7, 31000, 1500, 'Customer Support Associate', 'zoya.khan@company.example', 'Hyderabad', 'Active', 21);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (36, 'Ira', 'Banerjee', 'F', '1988-02-02', '2014-09-15', 8, 140000, 20000, 'Principal Research Scientist', 'ira.banerjee@company.example', 'Bengaluru', 'Active', 3);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (37, 'Om', 'Chatterjee', 'M', '1990-10-07', '2017-03-13', 8, 120000, 15000, 'Machine Learning Engineer', 'om.chatterjee@company.example', 'Bengaluru', 'Active', 36);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (38, 'Leena', 'Krishnan', 'F', '1991-05-05', '2018-10-01', 8, 110000, 12000, 'Data Scientist', 'leena.krishnan@company.example', 'Chennai', 'Active', 36);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (39, 'Siddharth', 'Bhat', 'M', '1994-09-24', '2019-04-29', 1, 75000, 7000, 'DevOps Engineer', 'siddharth.bhat@company.example', 'Bengaluru', 'Active', 3);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (40, 'Rashi', 'Saxena', 'F', '1993-02-17', '2018-12-03', 2, 69000, 6500, 'Financial Analyst', 'rashi.saxena@company.example', 'Mumbai', 'Active', 4);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (41, 'Aakash', 'Rawat', 'M', '1995-01-13', '2020-10-19', 4, 64000, 7000, 'Account Executive', 'aakash.rawat@company.example', 'Delhi', 'Active', 6);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (42, 'Shreya', 'Bansal', 'F', '1996-04-25', '2021-06-14', 5, 61000, 5000, 'SEO Executive', 'shreya.bansal@company.example', 'Noida', 'Active', 7);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (43, 'Gaurav', 'Tripathi', 'M', '1992-11-14', '2018-04-16', 6, 68000, 5500, 'Operations Coordinator', 'gaurav.tripathi@company.example', 'Pune', 'Active', 2);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (44, 'Nandini', 'Thomas', 'F', '1995-08-26', '2020-02-10', 7, 57000, 4000, 'Support Analyst', 'nandini.thomas@company.example', 'Hyderabad', 'Active', 21);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (45, 'Prateek', 'Sethi', 'M', '1993-06-06', '2017-07-24', 1, 53000, 4500, 'Database Administrator', 'prateek.sethi@company.example', 'Bangalore', 'Inactive', 8);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (46, 'Alisha', 'Kumar', 'F', '1997-11-30', '2021-04-05', 3, 48000, 3500, 'Talent Acquisition Executive', 'alisha.kumar@company.example', 'Lucknow', 'Active', 5);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (47, 'Ritesh', 'Thakur', 'M', '1994-01-29', '2019-09-02', 2, 45000, 3000, 'Payroll Executive', 'ritesh.thakur@company.example', 'Mumbai', 'Active', 4);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (48, 'Mitali', 'Ghosh', 'F', '1998-07-17', '2022-01-17', 4, 41000, 2500, 'Sales Associate', 'mitali.ghosh@company.example', 'Kolkata', 'Active', 6);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (49, 'Bilal', 'Hussain', 'M', '1999-04-14', '2022-09-12', 7, 37000, 1800, 'Support Executive', 'bilal.hussain@company.example', 'Hyderabad', 'Inactive', 21);
INSERT INTO employee (emp_id, first_name, last_name, gender, dob, doj, dept_id, salary, bonus, designation, email, city, status, manager_id) VALUES (50, 'Kiran', 'Shah', NULL, NULL, NULL, NULL, NULL, NULL, 'Unassigned Staff', NULL, NULL, NULL, 7);
SELECT COUNT(*) AS department_rows FROM department;
SELECT COUNT(*) AS employee_rows FROM employee;
