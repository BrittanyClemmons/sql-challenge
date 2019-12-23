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