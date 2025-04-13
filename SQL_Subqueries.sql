select * from employee_salary_dataset;

-- Easy Questions (7 Questions)
-- 1.Find the average salary of all employees.
-- Output: AverageSalary
SELECT 
    AVG(Salary) AS AverageSalary
FROM
    employee_salary_dataset;

-- 2.List employees who earn more than the company's average salary.
-- Output: ID, Salary

SELECT 
    ID,SALARY
FROM
    employee_salary_dataset
WHERE
    salary > (SELECT 
            AVG(Salary) AS AverageSalary
        FROM
            employee_salary_dataset);

-- 3.Find the youngest employee(s) in the company.
-- Output: ID, Age

SELECT 
    ID, AGE
FROM
    employee_salary_dataset
WHERE
    AGE = (SELECT 
            MIN(AGE)
        FROM
            employee_salary_dataset);

-- 4.Retrieve employees whose salary is equal to the second-highest salary in the company.
-- Output: ID, Salary

SELECT 
    ID,SALARY
FROM
    employee_salary_dataset
WHERE
    salary = (SELECT DISTINCT
            SALARY
        FROM
            employee_salary_dataset
             ORDER BY SALARY DESC
             LIMIT 1 OFFSET 1);


-- 5.Find employees who have more experience than the company’s average experience.
-- Output: ID, Experience_Years

SELECT 
    ID,Experience_Years
FROM
    employee_salary_dataset
WHERE
    Experience_Years > (SELECT 
            AVG(Experience_Years) AS Average_Experience_Years
        FROM
            employee_salary_dataset);

-- 6.Retrieve employees who earn the lowest salary in the company.
-- Output: ID, Salary

SELECT 
    id, salary
FROM
    employee_salary_dataset
WHERE
    salary = (SELECT 
            MIN(Salary)
        FROM
            employee_salary_dataset);

-- 7.Find employees who are older than the average age of all employees.
-- Output: ID, Age

SELECT 
    ID, AGE
FROM
    employee_salary_dataset
WHERE
    age > (SELECT 
            AVG(age)
        FROM
            employee_salary_dataset);

-- Medium Questions (5 Questions)
-- 8.List employees who earn more than a specific employee (e.g., the employee with ID = 5).
-- Output: ID, Salary

SELECT 
    ID, SALARY
FROM
    employee_salary_dataset
WHERE
    SALARY > (SELECT 
            SALARY
        FROM
            employee_salary_dataset
        WHERE
            ID = 5);


-- 9.Find employees who have the same salary as the youngest employee in the company.
-- Output: ID, Salary

SELECT 
    ID, SALARY
FROM
    employee_salary_dataset
WHERE
    SALARY =(SELECT 
            SALARY
        FROM
            employee_salary_dataset
        ORDER BY AGE ASC
		LIMIT 1);

-- 10.Retrieve employees whose experience is above the company's average and salary is below the company's average.
-- Output: ID, Experience_Years, Salary

SELECT 
    ID, Experience_Years, Salary
FROM
    employee_salary_dataset
WHERE
    Experience_Years > (SELECT 
            AVG(Experience_years)
        FROM
            employee_salary_dataset)
        AND salary < (SELECT 
            AVG(salary)
        FROM
            employee_salary_dataset);

-- 11.Find employees with the second-lowest salary in the company.
-- Output: ID, Salary
SELECT 
    id, salary
FROM
    employee_salary_dataset
ORDER BY salary ASC
LIMIT 1 OFFSET 1;


-- 12.Find employees older than any employee who has the highest salary.
-- Output: ID, Age

SELECT 
    id, age
FROM
    employee_salary_dataset
WHERE
    age > (SELECT 
            age
        FROM
            employee_salary_dataset
        ORDER BY salary DESC
        LIMIT 1);


-- Hard Questions (2 Questions)
-- 13.Find the employee(s) with the highest experience but earning less than the average salary.
-- Output: ID, Experience_Years, Salary

SELECT id, experience_years, salary
FROM employee_salary_dataset
WHERE experience_years = (SELECT MAX(experience_years) FROM employee_salary_dataset)
AND salary < (SELECT AVG(salary) FROM employee_salary_dataset);

-- 14.Find the employee with the highest salary among those who have experience less than the 
-- company’s average experience.
-- Output: ID, Experience_Years, Salary


SELECT id, experience_years, salary
FROM employee_salary_dataset
WHERE experience_years < (SELECT AVG(experience_years) FROM employee_salary_dataset)
ORDER BY salary DESC
LIMIT 1;
