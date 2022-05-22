create table Titles (
	title_id varchar,
	title varchar,
	PRIMARY KEY (title_id)
);

create table Employees (
	emp_no int,
	emp_title varchar,
	birth_date varchar,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date varchar,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title) REFERENCES Titles(title_id)
);

create table Salaries (
	emp_no int,
	salary int,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

create table Departments (
	dept_no varchar,
	dept_name varchar,
	PRIMARY KEY (dept_no)
);

create table Dept_emp (
	emp_no int,
	dept_no varchar,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

create table Dept_manager (
	dept_no varchar,
	emp_no int,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

SELECT * FROM departments;

SELECT * FROM titles;

SELECT * FROM Employees;

SELECT * FROM Dept_emp;

SELECT * FROM Dept_manager;

SELECT * FROM Salaries;

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees INNER JOIN Salaries ON employees.emp_no = salaries.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary, e.hire_date 
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no
WHERE (SELECT RIGHT(e.hire_date, 4) = 1986);

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.first_name, e.last_name
FROM dept_manager dm
INNER JOIN departments d on d.dept_no = dm.dept_no
INNER JOIN employees e on dm.emp_no = e.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
INNER JOIN employees e on e.emp_no = de.emp_no
INNER JOIN departments d on de.dept_no = d.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND (LEFT(last_name, 1) = 'B')

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
INNER JOIN employees e on e.emp_no = de.emp_no
INNER JOIN departments d on de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
INNER JOIN employees e on e.emp_no = de.emp_no
INNER JOIN departments d on de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' or d.dept_name = 'Development';

--8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT last_name, COUNT(emp_no) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;