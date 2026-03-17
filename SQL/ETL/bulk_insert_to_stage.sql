------------------------------------------------------------------------------
--bulk insert into stage.DimCustomerRow
------------------------------------------------------------------------------
BULK INSERT stage.DimCustomerRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DimCustomers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

------------------------------------------------------------------------------
--bulk insert into stage.DimProductRow
------------------------------------------------------------------------------
BULK INSERT stage.DimProductRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DimProduct.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

------------------------------------------------------------------------------
--bulk insert into stage.DimStoreRow
------------------------------------------------------------------------------
BULK INSERT stage.DimStoreRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DimStore.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

------------------------------------------------------------------------------
--bulk insert into stage.FactOrdersRow
------------------------------------------------------------------------------
BULK INSERT stage.FactOrdersRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\FactOrders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

------------------------------------------------------------------------------
--bulk insert into dim.DimDate + insert a new date
------------------------------------------------------------------------------
BULK INSERT dim.DimDate
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DimDate.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

INSERT INTO dim.DimDate
(
    DateID,
    [Date],
    DayOfWeek,
    [Month],
    [Quarter],
    [Year],
    IsWeekend
)
VALUES
(
    20260101,
    '2026-01-01',
    4,
    1,
    1,
    2026,
    0
);

