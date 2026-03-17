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



