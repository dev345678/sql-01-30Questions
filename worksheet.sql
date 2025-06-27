CREATE DATABASE WORKSHEET;
USE WORKSHEET ;
-- 1. Create employees table
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary DECIMAL(10,2),
    department_id INT,
    join_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- 2. Create departments table
CREATE TABLE departments (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE NOT NULL
);

-- 3. Create projects table
CREATE TABLE projects (
    id INT PRIMARY KEY,
    project_name VARCHAR(100),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- 4. Create attendance table
CREATE TABLE attendance (
    id INT PRIMARY KEY,
    employee_id INT,
    date DATE,
    status VARCHAR(10),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- Insert into departments
INSERT INTO departments (id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Sales');

-- Insert into employees
INSERT INTO employees (id, name, age, salary, department_id, join_date) VALUES
(101, 'John', 35, 55000.00, 2, '2023-01-15'),
(102, 'Alice', 28, 60000.00, 1, '2022-03-10'),
(103, 'Bob', 45, 75000.00, 3, '2021-08-20'),
(104, 'Diana', 32, 52000.00, 2, '2023-09-25'),
(105, 'Ethan', 25, 48000.00, 4, '2024-02-10'),
(106, 'Fiona', 38, 70000.00, 3, '2022-11-05');

-- Insert into projects
INSERT INTO projects (id, project_name, employee_id) VALUES
(1, 'Payroll System', 103),
(2, 'HRMS', 102),
(3, 'Inventory App', 104),
(4, 'Sales CRM', 105);

-- Insert into attendance
INSERT INTO attendance (id, employee_id, date, status) VALUES
 (1, 101, '2024-06-20', 'Present'),
 (2, 102, '2024-06-20', 'Absent'),
 (3, 103, '2024-06-20', 'Present'),
 (4, 104, '2024-06-20', 'Present'),
 (5, 105, '2024-06-20', 'Present'),
 (6, 106, '2024-06-20', 'Absent');
--  Q1)SELECT ALL COLUMNS FROM THE "EMPLYOYESS "TABLE ?
SELECT*FROM EMPLOYEES;
-- Q2)SELECT NAME OF EMPLOYEE  WHO ARE OLDER THAN 30?

SELECT name
FROM employees
WHERE age > 30;
-- Q3)SELECT TOP 5 HIGHEST PAID EMPLOYEES ?
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;
-- Q4)GET A LIST OF EMPLOYEES WITH NAMES STARTING WITH 'A'?-- 

SELECT *
FROM employees
WHERE name LIKE 'A%';
-- Q5)SELECT UNIQUE JOB TITLES FROM THE EMPLOYEES TABLE?
ALTER TABLE employees 
ADD COLUMN job_title VARCHAR(50);
UPDATE employees SET job_title = 'Manager' WHERE id = 101;
UPDATE employees SET job_title = 'Accountant' WHERE id = 102;
UPDATE employees SET job_title = 'Developer' WHERE id = 103;
UPDATE employees SET job_title = 'Tester' WHERE id = 104;
UPDATE employees SET job_title = 'Analyst' WHERE id = 105;
UPDATE employees SET job_title = 'Support Engineer' WHERE id = 106;

SELECT*FROM EMPLOYEES;
 
 
-- Q6)INSERT A NEW EMPLOYEE INTO THE EMPLOYEE TABLE?

INSERT INTO employees (id, name, age, salary, department_id, join_date, job_title)
VALUES (107, 'David', 29, 62000.00, 3, '2025-06-21', 'Software Engineer');

SELECT*FROM EMPLOYEES;

-- Q7)UPDATE THE SALARY OF AN EMPLOYEE WITH ID = 101?
UPDATE EMPLOYEES
SET SALARY = 120000
WHERE ID = 101;
 SELECT*FROM EMPLOYEES;
 
-- Q8)DELETE EMPLOYEE WHO HAVE NOT JOINED YET ?
DELETE FROM employees
WHERE join_date IS NULL ;
SET SQL_SAFE_UPDATES=0;
SELECT*FROM EMPLOYEES;

-- Q9)INSERT MULTIPLE ROWS INTO THE 'DEPARTMENTS' TABLE?-- 
SELECT*FROM DEPARTMENTS ;

-- Q10)DELETE ALL RECORDS FROM 'DEPARTMENTS' WHERE DEPT_NAME ='SALES'?
DELETE  FROM departments 
where dept_name = 'sales';
SELECT*FROM DEPARTMENTS ;

-- Q11)FIND TOTAL NUMBER OF AN EMPLOYEE?
SELECT COUNT(*) AS total_employees
FROM employees;

-- Q12)calculate average salary by department ?
SELECT d.dept_name, AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d ON e.department_id = d.id
GROUP BY d.dept_name;
   
--    Q13)FIND THE MAX AND MIN SALARY ?
 select max(salary) as max_salary from employees;
 select min(salary) as min_salary from employees;

-- Q14)COUNT HOW MANY EMPLOYEES IN EACH DEPARTMENT?
SELECT d.dept_name, COUNT(e.id) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.id
GROUP BY d.dept_name;

-- Q15)GET DEPARTMENTS HAVING MORE THAN 5 EMPLOYEES?
SELECT d.dept_name, COUNT(e.id) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.id
GROUP BY d.dept_name
HAVING COUNT(e.id) > 2;

-- Q16)GET EMPLOYEES NAME ALONG WITH THEIR DEPARTMENTS NAMES ?
SELECT e.name AS employee_name, d.dept_name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

-- Q17)LIST ALL EMPLOYEES EVEN IF THEY DONT BELONG TO ANY DEPARTMENT ?
SELECT e.name AS employee_name, d.dept_name AS department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- Q18)LIST ALL DEPARTMENTS EVEN IF NO EMPLOYEES ARE IN THEM ?
SELECT e.name AS employee_name, d.dept_name AS department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- Q19)FIND EMPLOYEES WHO WORK IN THE SAME DEPARTMENT AS JOHN ?
SELECT name FROM employees
WHERE department_id = (
    SELECT department_id FROM employees
    WHERE name = 'John'
)
AND name <> 'John';

-- Q20)COMBINE DATA FROM 'EMPLOYEES'AND'PROJECTS' USING INNER JOIN ?
SELECT e.id AS employee_id,e.name AS employee_name,p.project_name
FROM employees e
INNER JOIN projects p ON e.id = p.employee_id;

-- Q21)GET EMPLOYEES WHO EARN MORE THAN THE AVERAGE SALARY ?
create table projets(
     id int primary key auto_increment,
     projects_name varchar(50) unique not null);
select * from projets;
-- Ques22)get employees who earn more than the average salary.-- 
select name,salary from employees
where salary>(select avg(salary) from employees);
-- Ques23)find departments where no employee is assigned.-- 
select d.id,d.dept_name from departments as d
left join employees e on d.id=e.department_id;
-- Quest24)list employees whose salary matches with someone from another dept-- 
select distinct e2.name,e2.salary,e2.department_id from employees e2
join employees e1 on e1.department_id<>e2.department_id and e1.salary=e2.salary;
-- Ques25)select all employee names using union from two different offices-- 
select e.name,e.department_id,d.dept_name from employees e
join departments as d on d.id=e.department_id
where d.dept_name="HR"
union
select e.name,e.department_id,d.dept_name from employees e
join departments as d on d.id=e.department_id
where d.dept_name="IT";
-- Ques26)Use a subquery to fetch top 3 salaries-- 
select  e.salary , e.name from employees as e
join (select distinct salary from employees
                  order by salary
                  limit 3) as top_salaries on e.salary=top_salaries.salary;
-- Ques27)add a check constraint to allow only salaries >10000-- 
alter table employees
add constraint check_kro
check (salary>10000);
INSERT INTO employees (id, name, age, salary, department_id, join_date)
VALUES (999, 'TestUser', 30, 9000, 1, '2024-01-01');
- Ques28)create a forign key between employees and departments-- 
create table emp(
          id int primary key,
          name varchar(50),
          department_id int,
          foreign key(department_id) references department(id));
	
create table department(
             id int primary key,
             d_name varchar(50));
-- Ques29)alter the table to add a default value to join_date-- 
alter table employees
modify join_date date default CURRENT_DATE;
-- Ques30)drop the projects table if its exist-- 
drop table if exists projects;

select max(salary) from employees where salary<(select max(salary) from employees);

