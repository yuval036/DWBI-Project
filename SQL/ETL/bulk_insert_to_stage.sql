------------------------------------------------------------------------------
--
------------------------------------------------------------------------------
BULK INSERT stage.DimCustomerRow
FROM 'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DimCustomers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

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
