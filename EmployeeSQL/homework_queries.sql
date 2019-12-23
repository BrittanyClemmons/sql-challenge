--List employee details: employee number, last name, first name, gender, and salary

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
JOIN salaries AS s
	ON e.emp_no = s.emp_no;


--List employees who were hired in 1986
--Note to Self: write dates in YYYY-MM_DD format and put in quotes or else SQL reads unquoted date as an integer

SELECT e.emp_no, e.last_name, e.first_name, e.hire_date
FROM employees AS e
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';


--List manager of each department: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
--Adding department number / name
WITH dept_info AS (
	SELECT d.dept_no, d.dept_name
	FROM departments AS d
),
	--Join management employee IDs
	mgmt_emp_no AS(
	SELECT d.dept_no, d.dept_name, dm.emp_no
	FROM dept_info AS d
	JOIN dept_manager AS dm
		ON d.dept_no = dm.dept_no
	),
		--Join management legal names
		legal_name AS (
			SELECT dm.dept_no, dm.dept_name, dm.emp_no, e.last_name, e.first_name
			FROM mgmt_emp_no AS dm
			JOIN employees AS e
				ON dm.emp_no = e.emp_no
		),
			--Join employee start and end employment dates
			hire_dates AS (
				SELECT l.dept_no, l.dept_name, l.emp_no, l.last_name, l.first_name, dm.from_date, dm.to_date
				FROM legal_name AS l
				JOIN dept_manager AS dm
					ON l.emp_no = dm.emp_no
			),
				--Create final table for users to query
				management AS (
				SELECT *
				FROM hire_dates
				)
					SELECT *
					FROM management;

--List the department of each employee: employee number, last name, first name, and department name

--Select department names from department table
--Join with dept_emp table to get emp_no
WITH department_name AS (
	SELECT de.emp_no, d.dept_name
	FROM departments AS d
	JOIN dept_emp AS de
		ON d.dept_no = de.dept_no

),
    --Adding employee legal names
	employee_info AS (
		SELECT e.emp_no, e.last_name, e.first_name, dn.dept_name
		FROM employees AS e
		JOIN department_name AS dn
			ON e.emp_no = dn.emp_no
	
	),
        --Create final table for users to query
		department_staff AS (
			SELECT *
			FROM  employee_info
		)
		
			SELECT *
			FROM department_staff;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List the all employees in the Sales department: employee number, last name, first name, and department name
WITH department_name AS (
	SELECT de.emp_no, d.dept_name
	FROM departments AS d
	JOIN dept_emp AS de
		ON d.dept_no = de.dept_no

),
	employee_info AS (
		SELECT e.emp_no, e.last_name, e.first_name, dn.dept_name
		FROM employees AS e
		JOIN department_name AS dn
			ON e.emp_no = dn.emp_no
	
	),
        --Final table for users to query
		department_staff AS (
			SELECT *
			FROM  employee_info
		)
            --Create query for all 'Sales' employees
			SELECT *
			FROM department_staff
			WHERE dept_name = 'Sales';

--List the all employees in the Sales and Development departments: employee number, last name, first name, and department name
WITH department_name AS (
	SELECT de.emp_no, d.dept_name
	FROM departments AS d
	JOIN dept_emp AS de
		ON d.dept_no = de.dept_no

),
	employee_info AS (
		SELECT e.emp_no, e.last_name, e.first_name, dn.dept_name
		FROM employees AS e
		JOIN department_name AS dn
			ON e.emp_no = dn.emp_no
	
	),
        --Final table for users to query
		department_staff AS (
			SELECT *
			FROM  employee_info
		)
            --Create query for all 'Sales' and 'Development' employees
			SELECT *
			FROM department_staff
			WHERE dept_name = 'Sales'
			   OR dept_name = 'Development';


--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY 1
ORDER BY 2 DESC;