---- Data Digger project ----
---- E comarce story database ---
create database data_digger;
use data_digger;

--- === Customers table === ---
create table Customers ( 
CustomerID int primary key auto_increment,
Name varchar(50),
Email Varchar(50),
Address varchar(100)
);

insert into Customers (Name, Email, Address) values
('Ramesh Sharma', 'ramesh.sharma@gmail.com', 'Sirohi, Rajasthan'),
('Priya Verma', 'priya.verma@gmail.com', 'Jaipur, Rajasthan'),
('Alice Fernandes', 'alice.f@gmail.com', 'Mumbai, Maharashtra'),
('Suresh Patel', 'suresh.p@gmail.com', 'Ahmedabad, Gujarat'),
('Neha Gupta', 'neha.gupta@gmail.com', 'Delhi');

Select * from Customers;
Update Customers
set Address = 'Udaipur , Rajathan'
where CustomerID = 1;



delete from Customers 
where CustomerID = 5;

select * from Customers where Name = 'Alice Fernandes';


--- ==== Orders table === ---


 
create table Orders (
OrderID int primary key auto_increment,
CustomerID int,
OrderDate date,
TotalAmount decimal(10,2),
foreign key (CustomerID) references Customers(CustomerID)
);
 
insert into Orders (CustomerID, OrderDate, TotalAmount) values
(1, '2026-06-05', 1500.00),
(2, '2026-06-10', 2500.50),
(3, '2026-06-15', 800.00),
(1, '2026-06-20', 3200.00),
(4, '2026-06-25', 950.75);

select * from Orders
where CustomerID = 1;

update Orders 
set TotalAmount = 1750.00
where OrderID = 1;

delete from Orders
where OrderID = 5;

select * from Orders 
Where OrderDate >= date_sub(curdate(), interval 30 day);



select max(TotalAmount) as HighestOrder,
       min(TotalAmount) as LowestOrder,
       avg(TotalAmount) as AverageOrder
from Orders;

---- === Products table === ----

CREATE TABLE Products (
ProductID int primary key auto_increment,
ProductName varchar(50),
Price decimal(10,2),
Stock int
);

insert into Products (productName , Price , Stock) value
('Wireless Mouse', 600.00, 25),
('Bluetooth Speaker', 1800.00, 0),
('USB Cable', 150.00, 100),
('Laptop Stand', 1200.00, 15),
('Keyboard', 900.00, 30);


select * from Products 
order by Price desc;


update Products 
set Price = 650.00
where ProductID = 1;

select * from Products
where Price between 500 and 2000;

select
(select ProductName from Products order by Price desc limit 1) as MostExpensive,
(select ProductName from products order by Price asc limit 1 ) as Cheapest;

--- ==== OrderDetails table ====


create table OrderDetails (
OrderDetailID int primary key auto_increment,
OrderID int,
ProductID int,
Quantity int,
SubTotal decimal(10,2),
foreign key (OrderID) references Orders(OrderID),
foreign key (ProductID) references Products(ProductID)
);
 
insert into OrderDetails (OrderID, ProductID, Quantity, SubTotal) values
(1, 1, 2, 1300.00),
(2, 3, 5, 750.00),
(3, 4, 1, 1200.00),
(4, 1, 3, 1950.00),
(1, 3, 4, 600.00);


select * from OrderDetails 
where OrderID = 1 ;

 

select sum(SubTotal) as TotalRevenue 
from OrderDetails;



select p.ProductName, sum(od.Quantity) as TotalSold 
from OrderDetails od
join Products p on od.ProductID = p.ProductID
group by p.ProductName
order by TotalSold desc
limit 3;

select count(*) as TimesSold
from OrderDetails
Where ProductID = 1;