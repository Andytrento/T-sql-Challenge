---- Which shippers do we have?
Select
    *
From
    dbo.Shippers
--- 2. Certain fields from Categories
Select
    *
From
    Categories
Select
    CategoryName,
    [Description]
From
    Categories
--- VIM
---- 1. Set up  (Northwind)
---- 2.
--- Sales Representative
--- Get the firstName, LastName, and HireDate of all the employees with the Title Sales of Repesenative
Select
    top 3
    *
From
    Employees
Where
    Title = 'Sales Representative'
Select
    FirstName,
    LastName,
    HireDate
From
    Employees
Where
    Title = 'Sales Representative'
    and Country = 'USA'
---- Show all orders placed by a specific employee
Select
    OrderID,
    OrderDate,
    EmployeeID
From
    Orders
Where
    EmployeeID = 5
-- 6. Supplier and ContactTitles
--- Show the SupplierID, ContactName, and ContactTile for those suppliers whose ContactTitle is not Marketing Manager
Select
    SupplierID,
    ContactName,
    ContactTitle
from
    Suppliers
Where
    ContactTitle <> 'Marketing Manager'
---- 7. Products with "queso" in Productname
Select
    ProductID,
    ProductName
From
    Products
Where
    ProductName like '%queso%'
--- regex in SQL
--- 8. ORders shipping to Frange or Belgium
--- Opt 1 : using "IN" operator
Select
    OrderID,
    CustomerID,
    ShipCountry
From
    Orders
Where
    ShipCountry in ('France', 'Belgium')
--- Op2 1 : using "OR" operator
Select
    OrderID,
    CustomerID,
    ShipCountry
From
    Orders
Where
    ShipCountry = 'France'
    or ShipCountry = 'Belgium'
---9. Orders shipping to any country in Latin America
Select
    OrderID,
    CustomerID,
    ShipCountry
From
    Orders
Where
    ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
--- using "IN" statement
--10. Employees, in order of age
--- using Order by clause
Select
    FirstName,
    LastName,
    Title,
    BirthDate
From
    Employees
Order by
    BirthDate asc
---11. Showing only the Date with a DateTime field
-- Hint: use the Convert function  to convert DateTime to Date
Select
    FirstName,
    LastName,
    Title,
    CONVERT(date, BirthDate) as 'BirthDate'
From
    Employees
Order by
    BirthDate asc
---12. Employees full name
---- Show the FirstName and LastName columns from the Employees table
-- Hint : using String Concatenation
Select
    FirstName,
    LastName,
    FullName = FirstName + ' ' + LastName
From
    Employees
---- 13. OrderDetails amout per line item

--- 14 How many customers
-- Hint : using  aggregate function like COUNT, SUM .... 
Select
    COUNT(*) as 'TotalCustomers'
From
    Customers



--- 15. When wwas the first order> 

--- Show the date of the first order ever made in the ORders table 

Select
    top 1
    OrderDate
From
    Orders
Order by 
    OrderDate asc



Select
    MIN(OrderDate)
From
    Orders


--- 16. Countries where there are customers 


Select
    Country,
    COUNT(CustomerID)
From
    Customers
Group by 
    Country


---- 17. Contact titles for customers 

Select
    ContactTitle,
    COUNT(*) 'TotalContactTitle'
From
    Customers
Group by 
    ContactTitle
Order by 2 desc


--- 18. Products with associated supplier names 


Select
    top 3
    *
From
    Products

Select
    top 3
    *
From
    Suppliers


Select
    p.ProductID,
    p.ProductName,
    s.CompanyName as 'Supplier'

From
    Products  as p left join Suppliers as s on p.ProductID = s.SupplierID

Select
    ProductID,
    ProductName,
    CompanyName as 'Supplier'

From
    --Products  as p left join Suppliers as s on p.ProductID = s.SupplierID 
    Products JOin Suppliers on Products.ProductID = Suppliers.SupplierID

--- 19. Orders and Shipper that was used 

Select
    top 3
    *
From
    Orders


Select
    top 3
    *
From
    Shippers

Select
    OrderID,
    OrderDate,
    Shippers.CompanyName as 'Shipper'
From
    Orders left join Shippers on Orders.ShipVia = Shippers.ShipperID
Where
    OrderID < 10300
Order by OrderID 


