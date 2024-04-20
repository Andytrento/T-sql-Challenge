USE Northwind
GO


---- 20. Categories, and total products in each category

--- parent(Category table)-child (Products) relationship

Select
    c.CategoryName,
    COUNT(p.ProductID) as 'TotalProducts'
From
    Products as p left join Categories as c on p.CategoryID = c.CategoryID
Group by
    c.CategoryName
Order by 2 desc


--- 21. Total Customers per country/city


Select
    Country,
    City,
    COUNT(CustomerID) as 'TotalCustomers'
From
    Customers
Group by
    Country,
    City
Order by
    3 desc


--- wrong
-- the query engine doesn't know 'which' City that you want to display

Select
    Country,
    City,
    COUNT(CustomerID) as 'TotalCustomers'
From
    Customers
Group by
    Country
-- City
Order by
    3 desc

--- 22. Products that need reordering



Select
    ProductID,
    ProductName,
    UnitsInStock,
    UnitsOnOrder
From
    Products
Where
    UnitsInStock < UnitsOnOrder


--- 22. Products that need reordering, continued

-- Products the nee reordering  : Unit in Stocke + UnitsOnorder are less than or equal to ReorderLevel & The Discontinued flag is false

Select
    ProductID,
    ProductName,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued
From
    Products
Where
    UnitsInStock + UnitsOnOrder <= ReorderLevel
    -- and Discontinued = 'FALSE'
    and Discontinued = Convert(bit, 'FALSE')
Order by
    ProductID


--- 24. Customer list by region

-- hint: create a secondary sort

Select
    c.CustomerID,
    c.CompanyName,
    c.Region
From
    Customers as c
-- WHere
--     c.Region = 'AK'
Order by
    Case when c.Region  is null then 1 else 0 end,c.Region, CustomerID


--- Alternatively

Select
    c.CustomerID,
    c.CompanyName,
    c.Region,
    RegionOrder =
        case when region is null then 1 else 0 end
From
    Customers as c
Order by
    RegionOrder,
    Region,
    CustomerID


--- 25. Hegh freight charges


Select
    top 3
    ---- using Top is easisees and most commonly used method of showing only a certain #of records
    ShipCountry, AVG(Freight) as 'AverageFreight'
From
    Orders
Group by
    ShipCountry
Order by
    2  desc



---- Alternatively : using OFFSET

Select
    ShipCountry, AVG(Freight) as 'AverageFreight'
From
    Orders
Group by
    ShipCountry
Order by 2 DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY



--- 26. High freight charges -2015

--- Not very flexible
Select
    top 3
    ShipCountry, AVG(Freight) as 'AverageFreight'
From
    Orders
Where
    year(OrderDate) >= 1997
Group by
    ShipCountry
Order by
    2  desc


-- Better solution
Select
    top 3
    ShipCountry, AVG(Freight) as 'AverageFreight'
From
    Orders
Where
    ORderDate > '1/1/1997'
    and OrderDate < '1/1/1998'
Group by
    ShipCountry
Order by
    2  desc


--- 27. High Freight charges with between



Select
    top 3
    ShipCountry, AVG(Freight) as 'AverageFreight'
From
    Orders
Where
    OrderDate between '1/1/1997' and '12/31/1997'
Group by
    ShipCountry
Order by
    2  desc



--- 28. High Freight charges - last year

----  Generate a dynamic date range is critical for most data analysis work
--- Most reports and queries will need to be flexible, without hard-code date
--values

Select
    MAX(OrderDate)
From
    Orders

Select
    top 3
    ShipCountry, AVG(Freight) as 'AverageFreight'
From
    Orders
Where
    OrderDate >= Dateadd(year, -1, (Select MAX(ORderDate)
    FROM Orders))
    and
    OrderDate <= (Select MAX(ORderDate)
    FROM Orders)
Group by
    ShipCountry
Order by
    2  desc


--- 29. Inventory list


Select
    [Employees].EmployeeID,
    [LastName]
    OrderID,
    ProductName,
    Quantity


From
    Orders left join [Order Details] on [Orders].OrderID = [Order Details].OrderID
    left join Products on [Order Details].ProductID = [Products].ProductID
    left join Employees on [Orders].EmployeeID = [Employees].EmployeeID




---20. Customer with no orders


Select
    *
From
    Customers left join Orders on Customers.CustomerID = Orders.CustomerID
Where
    Orders.CustomerID is null

--Alternatively (more prefer, easiest to read)

Select
    *
From
    Customers
Where
    CustomerID not in (Select CustomerID
from ORders)


-- 31. Customers with no orders for EmployeeI 4

Select
    CustomerID
From
    Customers
WHere
    CustomerID not in (
Select
    CustomerID
From
    Orders
WHere
    EmployeeID = 4
    )
