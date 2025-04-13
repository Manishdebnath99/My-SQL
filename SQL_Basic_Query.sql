create database Dataset;

use Dataset;

create table Employees(EmployeeID int primary key,`Name` varchar(30), Salary int, HireDate date, 
Department varchar(20), Age int, City varchar(30) );

insert into Employees(EmployeeID, `Name`, Salary, HireDate, Department, Age, City)
values (1,'John Doe',5500,'2020-03-15','HR',30,'New York'), 
(2,'Jane Smith', 75000, '2018-11-21', 'Marketing', 40, 'Los Angeles'), 
(3, 'Mike Johnson', 45000, '2021-05-01', 'IT', 25, 'Chicago'), 
(4, 'MaryBrown', 85000, '2019-07-09', 'Sales', 35, 'Boston'), 
(5, 'James White', 60000, '2022-01-12', 'HR', 28, 'Miami');

create table Products(ProductID int primary key	,ProductName varchar(30),	
Price int,	Category varchar(30),Quantity int, Discount int);

insert into products(ProductID	,ProductName,	Price,	Category,	Quantity,	Discount)
values (1	,'Laptop',	1200	,'Electronics',	50	,10),(2,	'T-Shirt',	25,	'Apparel',	200,	5),
(3,	'Coffee Maker'	,60,	'Home Goods'	,150,	15),(4,	'Headphones',	'100',	'Electronics',	100,	20),
(5,	'Desk Chair',	150,	'Furniture',	80,	10);

# Easy SQL Questions (5-6 questions)
#Q1: Find all employees whose name starts with the letter "J."
select * from Employees where `Name` like 'J%';

#Q2: Retrieve all employees who are older than 30 years.
select * from Employees where Age>30;

#Q3: Find the employees who work in the HR department and earn more than $55,000.
select * from Employees where Department like 'HR' AND Salary > 55000;

#4: Find all products in the Products table where the product name contains "head."
select * from Products where ProductName like '%head%';

#Q5: List the products whose price is between $50 and $100.
select * from products where Price between 50 and 100;

#Q6: Find all employees whose name ends with the letter "n."
select * from employees where `name` like '%n'; 

#Medium Difficulty SQL Questions (4 questions)
#Q1: Find products where the price is between $50 and $200, and the discount is greater than 10%.
select * from products where price between 50 and 200 and discount > 10;

#Q2: Retrieve the total quantity of all products in the Products table.
select*,(Price*Quantity) as TotalQuantity from Products;

#Q3: Find employees whose age is between 25 and 35.
select * from employees where age between 25 and 35;

#Q4: Retrieve all products where the product name contains the letter "o" but does not end with "s."
select * from products where productname like '%o%' and productname not like '%s'

#Hard SQL Questions (2 questions)
#Q1: Retrieve the highest salary among employees who have been hired after 2020, and display the 
# employee name and salary.

select `name`,salary from employees where hiredate>'2020-12-31' 
and salary=(SELECT MAX(Salary) FROM Employees WHERE HireDate > '2020-12-31');

#Q2: Calculate the total discounted price for each product after applying the discount, and retrieve 
# products where the discounted price is greater than $100.

select * ,(price-price*discount*0.01) as DiscountedPrice from products where (price-price*discount*0.01) > 100; 
