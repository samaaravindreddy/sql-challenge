-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "titles" (
    "title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Department" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "empoloyees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_data" VARCHAR(25)   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR(25)   NOT NULL,
    CONSTRAINT "pk_empoloyees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL
);

ALTER TABLE "empoloyees" ADD CONSTRAINT "fk_empoloyees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "empoloyees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "empoloyees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "empoloyees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");





SELECT * FROM "Department";
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM empoloyees;
SELECT * FROM salaries;
SELECT * FROM titles;




--details of each emp:employee number,last name, first name, sex, and salary.
SELECT e.emp_no,e.last_name,e.first_name,e.sex,s.salary
FROM empoloyees as e
 INNER JOIN salaries as s
ON e.emp_no = s.emp_no;


--first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM empoloyees
WHERE hire_date BETWEEN '1/1/1986'AND '12/31/1986'



-- manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT "Department".dept_no,"Department".dept_name,dept_manager.emp_no,empoloyees.last_name,empoloyees.first_name
FROM "Department"
JOIN dept_manager
ON "Department".dept_no = dept_manager.dept_no
JOIN empoloyees 
ON dept_manager.emp_no = empoloyees.emp_no;



--4
SELECT dept_emp.emp_no,empoloyees.last_name,empoloyees.first_name,"Department".dept_name
FROM dept_emp 
JOIN empoloyees 
ON dept_emp.emp_no = empoloyees.emp_no
JOIN "Department"
ON dept_emp.dept_no = "Department".dept_no;


--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B.

SELECT first_name, last_name, sex
FROM empoloyees
WHERE first_name = 'Hercules' AND last_name LIKE 'B';



--6
SELECT "Department".dept_name, empoloyees.last_name,empoloyees.first_name
FROM dept_emp
JOIN empoloyees
ON dept_emp.emp_no = empoloyees.emp_no
JOIN "Department"
ON dept_emp.dept_no = "Department".dept_no
WHERE "Department".dept_name = 'sales';






--7
SELECT "Department".dept_name, empoloyees.last_name,empoloyees.first_name
FROM dept_emp
JOIN empoloyees
ON dept_emp.emp_no = empoloyees.emp_no
JOIN "Department"
ON dept_emp.dept_no = "Department".dept_no
WHERE "Department".dept_name = 'sales'
OR "Department".dept_name = 'Development';



-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.


SELECT last_name, count(last_name) as "frequency"
FROM empoloyees
GROUP BY last_name
ORDER BY (last_name) DESC;


