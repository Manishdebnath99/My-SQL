use dataset;

create table customers(CustomerID int primary key,	CustomerName varchar(30),
	Region	varchar(30) ,JoinDate date);
    
insert into customers(CustomerID,	CustomerName,	Region,	JoinDate)
values(1,	'Alice',	'North',	'2021-01-10'),
(2,	'Bob',	'South',	'2020-05-15'),
(3,	'Charlie',	'East',	'2019-11-20'),
(4,	'David',	'West',	'2022-03-05'),
(5,	'Eve',	'North',	'2021-07-22'),
(6,	'Frank',	'South'	,'2020-09-12');


create table orders (OrderID int primary key,	CustomerID int,	OrderDate date,	
TotalAmount decimal, foreign key(CustomerID) references customers(CustomerID));

insert into orders(OrderID,	CustomerID,	OrderDate,	TotalAmount)
values(101,	1,	'2023-02-15',	500.00),
(102,	1,	'2023-03-10',	750.00),
(103,	2,	'2023-01-20',	300.00),
(104,	3,	'2023-05-05',	1200.00),
(105,	4,	'2023-04-10',	950.00),
(106,	5,	'2023-06-12',	600.00),
(107,	6,	'2023-07-01',	1100.00);

create table orderdetails (OrderDetailID int primary key,
	OrderID	int,ProductID int,	Quantity int,	Discount decimal(5,2),
    foreign key(OrderID) references orders(OrderID));


insert into orderdetails(OrderDetailID,	OrderID,	ProductID,	Quantity,	
Discount)
values(301,	101,	201,	1,	0.10),
(302,	101	,204,	2	,0.05),
(303,	102	,202	,1	,0.15),
(304	,103,	203,	1,	0.05),
(305,	104,	201,	1	,0.10),
(306,	104,	204,	1,	0.00),
(307,	105,	202,	2,	0.20),
(308,	106	,203,	1	,0.00),
(309,	107,	201,	1,	0.05),
(310,	107,	204	,1	,0.10);

create table products(ProductID int primary key,	ProductName varchar(40),
	Category varchar(40),	Price decimal(6,2));

insert into products(ProductID,	ProductName,	Category,	Price)
values(201,	'Laptop',	'Electronics',	1000.00),
(202,	'Smartphone',	'Electronics',	800.00),
(203,	'Tablet',	'Electronics',	500.00),
(204,	'Headphones',	'Electronics'	,200.00),
(205,	'Office Chair',	'Furniture',	300.00),
(206,	'Desk',	'Furniture',	450.00);

-- Medium Level Questions
-- Find the total revenue generated from each product, accounting for quantity and discount.

with total_revenue_generated as (
select 
p.productID,
p.productname,
sum(od.quantity*p.price*(1-od.Discount)) as Total_Spent
from orders o
join orderdetails od on od.orderid=o.orderid
join products p on p.productid=od.productid
group by p.productID,p.productname
)

select 
productID,
productname,
Total_Spent
from total_revenue_generated;

-- Retrieve the average order amount for each customer.

with average_spending as (
select 
c.customerID,
c.customername,
sum(od.quantity*p.price*(1-od.Discount)) as Total_Spent,
count(distinct o.orderID) as Total_Orders
from customers c
join orders o on o.customerID=c.customerID
join orderdetails od on od.orderid=o.orderid
join products p on p.productid=od.productid
group by c.customerid,c.customername
)

select 
customerID,
CustomerName,
total_spent/total_orders as AverageOrderAmount
from average_spending;

-- List customers who placed more than 2 orders along with their order count.

select c.customername, count(distinct o.orderID) as order_count
from customers c
join orders o on c.customerID=o.customerID
group by c.customername
having count(distinct o.orderID)>2;


-- Hard Level Question
-- Identify the top 3 customers who spent the most on "Electronics" products. Show their total spending, average spending per order, and the date of their first electronics purchase.

with electronics_spending as (
select 
c.customerID,
c.customername,
sum(od.quantity*p.price*(1-od.Discount)) as Total_Spent,
Min(o.orderdate) as first_order_date,
count(distinct o.orderID) as Total_Orders
from customers c
join orders o on o.customerID=c.customerID
join orderdetails od on od.orderid=o.orderid
join products p on p.productid=od.productid
where p.category='Electronics'
group by c.customerid,c.customername
)

select 
customerID,
CustomerName,
Total_spent,
total_spent/total_orders as AverageOrderAmount,
First_order_date
from electronics_spending
order by total_spent desc
limit 3;




