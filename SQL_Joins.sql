-- 2. Customers & Orders
-- Given tables:
-- customers(customer_id, name, email)
-- orders(order_id, customer_id, total_amount, order_date)
-- Write an SQL query to:
-- Retrieve all customers who have placed an order.

select c.name
from customers c
left join orders o on c.customer_id=o.customer_id
where order_id is not null;

-- List orders along with the customer names.
select c.name,o.order_id
from customers c
left join orders o on c.customer_id=o.customer_id;

-- Find customers who haven’t placed any orders.
select c.name
from customers c
left join orders o on c.customer_id=o.customer_id
where order_id is null;

-- 3.Employees & Departments
-- Given tables:
-- employees(emp_id, name, department_id, salary)
-- departments(department_id, dept_name)
-- Write a query to:
-- Retrieve all employees and their department names, ensuring employees without a department are still listed.
select e.name,d.dept_name
from employees e
left join departments d on e.department_id=d.department_id;

-- Find departments that have no employees.

select d.dept_name
from employees e
right join departments d on e.department_id=d.department_id
where e.emp_id is null;

-- 4.Filtering with Aggregation & JOIN
-- Given tables:
-- students(student_id, name)
-- courses(course_id, title)
-- enrollments(student_id, course_id, grade)

-- Write a query to:
-- Retrieve the average grade per course.
select c.title,avg(e.grade) as average_grade
from courses c
join enrollments e on c.course_id=e.course_id
group by c.title

-- List students who are not enrolled in any courses.
select s.name
from students s
left join enrollments e on s.student_id=e.student_id
where e.course_id is null;

-- Find students who scored above the course average grade.
select s.name 
from students s
join enrollments e on s.student_id=e.student_id
where e.grade>(select avg(e.grade) from enrollments e);

-- Medium Level (Complex JOINS & Aggregations)
-- 1. Combining Multiple JOINS: Employee & Manager Details
-- Given tables:
-- employees(emp_id, name, department_id, salary, manager_id)
-- departments(department_id, dept_name, manager_id)
-- managers(manager_id, manager_name, bonus)

-- Write an SQL query to:
-- Retrieve all employees with their department name and manager details.
select e.emp_id,e.name,d.dept_name,m.manager_id,m.manager_name
from employees e
join departments d on e.department_id=d.department_id
join managers m on e.manager_id=m.manager_id;

-- Find departments that do not have a manager assigned.

select dept_name 
from departments
where manager_id is null;

-- Retrieve employees who earn more than their department’s average salary.

SELECT 
    e.emp_id, e.name AS employee_name, e.salary, d.dept_name
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.department_id
WHERE
    e.salary > (SELECT 
            AVG(e2.salary)
        FROM
            employees e2
        WHERE
            e2.department_id = e.department_id);

-- 2.Product Sales Analysis with JOINS
-- Given tables:
-- products(product_id, product_name, category)
-- orders(order_id, customer_id, order_date)
-- order_items(order_item_id, order_id, product_id, quantity, price)
-- Write SQL queries to:
-- Retrieve all products that have never been sold.
SELECT 
    product_name
FROM
    products p
        LEFT JOIN
    order_items oi ON p.product_id = oi.product_id
WHERE
    oi.order_id IS NULL; 


-- Find the top 3 best-selling products based on total quantity sold.
SELECT 
	p.product_name,sum(oi.quantity) as total_quantity_sold
FROM 
	products p
JOIN order_items oi on p.product_id=oi.product_id
GROUP BY p.product_id,p.product_name
ORDER BY sum(oi.quantity) desc
limit 3;

-- Get the total revenue per product category.
SELECT 
    p.category, SUM(oi.quantity * oi.price) AS total_revenue
FROM
    products p
        JOIN
    order_items oi ON p.product_id = oi.product_id
GROUP BY p.category;

-- 3.Advanced Filtering with JOINS: Employee Performance
-- Given tables:
-- employees(emp_id, name, salary, department_id)
-- departments(department_id, dept_name, manager_id)
-- projects(project_id, project_name, budget)
-- employee_projects(emp_id, project_id, role)
-- Write SQL queries to:
-- Retrieve all employees and the projects they are working on.

select e.name,p.project_name from employee_projects ep
join employees e on ep.emp_id=e.emp_id
join projects p on ep.project_id=p.project_id;


-- Find employees who are not assigned to any project.

select e.name from employees e
left join employee_projects ep on e.emp_id=ep.emp_id
where ep.project_id is null;

-- List projects that have no employees assigned.

select p.project_name from projects p
left join employee_projects ep on p.project_id=ep.project_id
where ep.emp_id is null;

-- 4.Customer Order Behavior Analysis
-- Given tables:
-- customers(customer_id, name, email)
-- orders(order_id, customer_id, total_amount, order_date)
-- Write SQL queries to:
-- Find customers who have placed more than 5 orders.

SELECT 
    c.name, COUNT(o.order_id) AS no_of_orders
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY c.name , c.customer_id
HAVING COUNT(o.order_id) > 5

-- Retrieve the total amount spent per customer.

SELECT 
    c.name, SUM(total_amount) AS total_spent
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY c.name , c.customer_id;


-- Get customers who haven’t placed any orders in the last 6 months.

SELECT 
    c.name
FROM
    customers c
        LEFT JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    o.order_date IS NULL
        OR TIMESTAMPDIFF(MONTH,
        o.order_date,
        CURDATE()) > 6;
        
-- 5.Mastering Aggregations with HAVING & JOINS
-- Given a sales table with:
-- sale_id, product_name, quantity, price, region
-- Write queries to:
-- Find total revenue per region, but only for regions where revenue exceeds $10,000.

select region, sum(quantity * price) as total_revenue
from sales
group by region
having total_revenue > 10000;

-- Retrieve the lowest revenue-generating product.

select product_name, sum(quantity * price) as total_revenue
from sales
group by product_name
order by total_revenue asc
limit 1;

-- Get the monthly revenue for the past 6 months.
 
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    SUM(quantity * price) AS total_revenue
FROM
    sales
WHERE
    sale_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY month
ORDER BY month DESC;


-- Hard Level (Advanced JOINS & Real-World Scenarios)
-- Mastering SQL Joins: Employees, Departments, and Managers
-- Given tables:
-- employees(emp_id, name, department_id, salary)
-- departments(department_id, dept_name, manager_id)
-- managers(manager_id, manager_name, bonus)
-- Write SQL queries to:
-- Retrieve all employees with their department names and managers.

select e.emp_id,e.name,d.dept_name,m.manager_id,m.manager_name
from employees e
join departments d on e.department_id=d.department_id
join managers m on e.manager_id=m.manager_id;

-- Find employees who earn more than their department’s average salary.

SELECT 
    e.emp_id, e.name AS employee_name, e.salary, d.dept_name
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.department_id
WHERE
    e.salary > (SELECT 
            AVG(e2.salary)
        FROM
            employees e2
        WHERE
            e2.department_id = e.department_id);

-- Calculate the total salary expense per manager, including bonus amounts.

select m.manager_name,sum(e.salary + m.bonus) as total_salary_expense
from employees e
join departments d on e.department_id=d.department_id
join managers m on e.manager_id=m.manager_id
group by m.manager_name,m.manager_id;



-- Complex Many-to-Many Relationship: Student-Course Enrollments
-- Given tables:
-- students(student_id, name)
-- courses(course_id, title, credits)
-- enrollments(student_id, course_id, grade)
-- Write SQL queries to:
-- Retrieve all students along with their enrolled courses.
select s.student_id, s.name, c.title,c.course_id
from enrollments e
join students s on e.student_id=s.student_id
join courses c on e.course_id=c.course_id;

-- Find students who are enrolled in more than 3 courses.
select s.student_id, s.name, 
count(course_id) as no_of_courses
from students s
join enrollments e on s.student_id=e.student_id
group by s.student_id, s.name
having count(course_id)>3;

-- Get the highest and lowest grades for each course.

select c.title, max(e.grade) as highest_grades,
min(e.grade) as lowest_grades 
from courses c
join enrollments e on c.course_id=e.course_id;
group by c.course_id, c.title;

-- E-commerce Data Analysis with JOINS & Aggregation
-- Given tables:
-- customers(customer_id, name, email)
-- orders(order_id, customer_id, total_amount, order_date)
-- order_items(order_item_id, order_id, product_id, quantity, price)
-- products(product_id, product_name, category, supplier_id)
-- Write SQL queries to:
-- Find the total revenue per customer, including product details.

SELECT 
    c.customer_id, 
    c.name, 
    p.product_name, 
    p.category, 
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name, p.product_name, p.category;

-- Retrieve the top 5 customers based on total spending.

SELECT 
    c.customer_id, 
    c.name, 
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- Get the most profitable product category.

SELECT 
    p.category, 
    SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC
LIMIT 1;


-- Find customers who purchased products from at least 3 different categories.

SELECT c.customer_id, c.name, COUNT(DISTINCT p.category) AS category_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT p.category) >= 3;




