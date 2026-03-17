===========================================================
-- Description:
-- This script performs data validation and correction
-- after loading data into Dimension and Fact tables.
===========================================================
-----------------------------------------------------------
-- 1. VALIDATION – Orders before store opening
-----------------------------------------------------------
SELECT
    f.OrderID,
    f.StoreID,
    f.OrderDateID,
    d.[Date] AS OrderDate,
    s.StoreOpeningDate,
    DATEADD(DAY, 1, s.StoreOpeningDate) AS NewOrderDate
FROM fact.FactOrders f
JOIN dim.DimStore s
    ON f.StoreID = s.StoreID
JOIN dim.DimDate d
    ON f.OrderDateID = d.DateID
WHERE d.[Date] < s.StoreOpeningDate;
GO

-----------------------------------------------------------
--FIX – Adjust order date
-----------------------------------------------------------
UPDATE f
SET f.OrderDateID = dd.DateID
FROM fact.FactOrders f
JOIN dim.DimStore s
    ON f.StoreID = s.StoreID
JOIN dim.DimDate currentDate
    ON f.OrderDateID = currentDate.DateID
JOIN dim.DimDate dd
    ON dd.[Date] = DATEADD(DAY, 1, s.StoreOpeningDate)
WHERE currentDate.[Date] < s.StoreOpeningDate;
GO

-----------------------------------------------------------
-- 2. VALIDATION – Customers under age 18
-----------------------------------------------------------
SELECT
    CustomerID,
    FirstName,
    LastName,
    DateOfBirth,
    DATEDIFF(YEAR, DateOfBirth, GETDATE()) AS Age
FROM dim.DimCustomer
WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) < 18;
GO

-----------------------------------------------------------
-- FIX – Adjust DateOfBirth
-----------------------------------------------------------
UPDATE dim.DimCustomer
SET DateOfBirth = DATEADD(YEAR, 17, DateOfBirth)
WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) < 18;
GO

-----------------------------------------------------------
-- 3. VALIDATION – TotalAmount calculation
-----------------------------------------------------------
SELECT
    f.OrderID,
    f.ProductID,
    f.Quantity,
    p.UnitPrice,
    f.DiscountAmount,
    f.ShippingAmount,
    f.TotalAmount,
    ((f.Quantity * p.UnitPrice) - f.DiscountAmount + f.ShippingAmount) AS CorrectTotalAmount
FROM fact.FactOrders f
JOIN dim.DimProduct p
    ON f.ProductID = p.ProductID
WHERE f.TotalAmount <> ((f.Quantity * p.UnitPrice) - f.DiscountAmount + f.ShippingAmount);
GO

  -----------------------------------------------------------
--FIX – Correct TotalAmount
-----------------------------------------------------------
UPDATE f
SET f.TotalAmount = ((f.Quantity * p.UnitPrice) - f.DiscountAmount + f.ShippingAmount)
FROM fact.FactOrders f
JOIN dim.DimProduct p
    ON f.ProductID = p.ProductID
WHERE f.TotalAmount <> ((f.Quantity * p.UnitPrice) - f.DiscountAmount + f.ShippingAmount);
GO
