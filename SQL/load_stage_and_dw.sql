-----------------------------------------------------------
-- Load DimCustomer
-----------------------------------------------------------

IF OBJECT_ID('stage.DimCustomerRow', 'U') IS NOT NULL
    DROP TABLE stage.DimCustomerRow;
GO

CREATE TABLE stage.DimCustomerRow(
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Gender NVARCHAR(10),
    DateOfBirth DATE,
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(100),
    [Address] NVARCHAR(100),
    City NVARCHAR(100),
    [State] NVARCHAR(100),
    Country NVARCHAR(100),
    ZipCode NVARCHAR(100),
    LoyaltyProgramID INT
);
GO

BULK INSERT stage.DimCustomerRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DimCustomers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO

INSERT INTO dim.DimCustomer
(
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    Email,
    PhoneNumber,
    [Address],
    City,
    [State],
    Country,
    ZipCode,
    LoyaltyProgramID
)
SELECT
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    Email,
    PhoneNumber,
    [Address],
    City,
    [State],
    Country,
    ZipCode,
    LoyaltyProgramID
FROM stage.DimCustomerRow;
GO

-----------------------------------------------------------
-- Load DimProduct
-----------------------------------------------------------

IF OBJECT_ID('stage.DimProductRow', 'U') IS NOT NULL
    DROP TABLE stage.DimProductRow;
GO

CREATE TABLE stage.DimProductRow(
    ProductName NVARCHAR(100),
    Category NVARCHAR(100),
    Brand NVARCHAR(100),
    UnitPrice INT
);
GO

BULK INSERT stage.DimProductRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DimProduct.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO

INSERT INTO dim.DimProduct
(
    ProductName,
    Category,
    Brand,
    UnitPrice
)
SELECT
    ProductName,
    Category,
    Brand,
    UnitPrice
FROM stage.DimProductRow;
GO

-----------------------------------------------------------
-- Load DimStore
-----------------------------------------------------------

IF OBJECT_ID('stage.DimStoreRow', 'U') IS NOT NULL
    DROP TABLE stage.DimStoreRow;
GO

CREATE TABLE stage.DimStoreRow(
    StoreName NVARCHAR(100),
    StoreType NVARCHAR(100),
    StoreOpeningDate DATE,
    City NVARCHAR(100),
    [State] NVARCHAR(100),
    ZipCode NVARCHAR(100),
    Country NVARCHAR(100),
    Region NVARCHAR(10),
    ManagerName NVARCHAR(10)
);
GO

BULK INSERT stage.DimStoreRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DimStore.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO

INSERT INTO dim.DimStore
(
    StoreName,
    StoreType,
    StoreOpeningDate,
    City,
    [State],
    ZipCode,
    Country,
    Region,
    ManagerName
)
SELECT
    StoreName,
    StoreType,
    StoreOpeningDate,
    City,
    [State],
    ZipCode,
    Country,
    Region,
    ManagerName
FROM stage.DimStoreRow;
GO

-----------------------------------------------------------
-- Load FactOrders Stage Table
-----------------------------------------------------------

IF OBJECT_ID('stage.FactOrdersRow', 'U') IS NOT NULL
    DROP TABLE stage.FactOrdersRow;
GO

CREATE TABLE stage.FactOrdersRow(
    CustomerID INT,
    StoreID INT,
    OrderDateID INT,
    ProductID INT,
    Quantity INT,
    DiscountPercent DECIMAL(5,2),
    ShippingPercent DECIMAL(5,2),
    DiscountAmount DECIMAL(10,2),
    ShippingAmount DECIMAL(10,2),
    TotalAmount DECIMAL(12,2)
);
GO

-----------------------------------------------------------
-- Load Historical FactOrders File
-----------------------------------------------------------

BULK INSERT stage.FactOrdersRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\FactOrders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO

-----------------------------------------------------------
-- Load DailyOrders Files (50 stores for 2026-01-01)
-----------------------------------------------------------

DECLARE @i INT = 1;
DECLARE @path NVARCHAR(500);
DECLARE @sql NVARCHAR(MAX);

WHILE @i <= 50
BEGIN
    SET @path = 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DailyOrders\Store_'
                + CAST(@i AS NVARCHAR(10))
                + '_20260101.csv';

    SET @sql = '
    BULK INSERT stage.FactOrdersRow
    FROM ''' + @path + '''
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = '','',
        ROWTERMINATOR = ''\n''
    );';

    EXEC (@sql);

    SET @i = @i + 1;
END;
GO

-----------------------------------------------------------
-- Load FactOrders
-----------------------------------------------------------

INSERT INTO fact.FactOrders
(
    CustomerID,
    StoreID,
    OrderDateID,
    ProductID,
    Quantity,
    DiscountPercent,
    ShippingPercent,
    DiscountAmount,
    ShippingAmount,
    TotalAmount
)
SELECT
    CustomerID,
    StoreID,
    OrderDateID,
    ProductID,
    Quantity,
    DiscountPercent,
    ShippingPercent,
    DiscountAmount,
    ShippingAmount,
    TotalAmount
FROM stage.FactOrdersRow;
GO
