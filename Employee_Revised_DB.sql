-- Department Table
CREATE TABLE departments (
	dept_no CHAR(4) PRIMARY KEY,
	dept_name VARCHAR(100) NOT NULL
);

-- Titles Table
CREATE TABLE titles(
	title_id VARCHAR(10) PRIMARY KEY,
	title VARCHAR(100) NOT NULL
);

-- Employee Table
CREATE TABLE employee(
	emp_no INT PRIMARY KEY,
	emp_title VARCHAR(10) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);

-- Dept_EMP Table
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no CHAR(4) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employee(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Dept_Manager Table
CREATE TABLE dept_manager(
	dept_no CHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employee(emp_no)
);

-- Salaries Table
CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	PRIMARY KEY (emp_no, salary),
	FOREIGN KEY (emp_no) REFERENCES employee(emp_no)
);

-- List the employee number, last name, first name, sex, and salary of each employee
Select emp_no, last_name, first_name, sex, salary From employee
JOIN salaries Using (emp_no);

-- List the first name, last name, and hire date for the employees who were hired in 1986
Select first_name, last_name, hire_date From employee
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name
Select d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name From departments d
JOIN dept_manager m ON d.dept_no = m.dept_no
JOIN employee e ON m.emp_no = e.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name
Select de.emp_no, de.dept_no, e.last_name, e.first_name, d.dept_name From dept_emp de
JOIN employee e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
Select first_name, last_name, sex From employee
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name
Select e.emp_no, e.last_name, e.first_name From employee e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
Select e.emp_no, e.last_name, e.first_name, d.dept_name From employee e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Development','Sales');

-- List the frequency counts, in descending order, of all the employee last names
Select last_name, COUNT(*) As frequency From employee
GROUP BY last_name
ORDER BY frequency DESC;