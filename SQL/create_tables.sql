-----------------------------------------------------------
--Create DimLoyaltyProgram table
-----------------------------------------------------------
IF OBJECT_ID('dim.DimLoyaltyProgram', 'U') IS NOT NULL
	DROP TABLE dim.DimLoyaltyProgram;

CREATE TABLE dim.DimLoyaltyProgram(
	LoyaltyProgramID INT PRIMARY KEY, 
	ProgramName NVARCHAR(50),
	ProgramTier NVARCHAR(50),
	PointsAccrued INT
)


--Insert valus into DimLoyaltyProgram table
IF NOT EXISTS(SELECT 1 FROM dim.DimLoyaltyProgram)
BEGIN
	INSERT INTO dim.DimLoyaltyProgram
	(LoyaltyProgramID, ProgramName, ProgramTier, PointsAccrued)
	VALUES 
	(1, 'Gold Rewards', 'Gold', 1500),
	(2, 'Platinum Perks', 'Platinum', 2500),
	(3, 'Silver Savers', 'Silver', 800),
	(4, 'Bronze Benefits', 'Bronze', 400),
	(5, 'Exclusive Elite', 'Elite', 3000);
END;

-----------------------------------------------------------
--Create DimDate table
-----------------------------------------------------------
IF OBJECT_ID('dim.DimDate', 'U') IS NOT NULL
	DROP TABLE dim.DimDate;

CREATE TABLE dim.DimDate(
	DateID INT PRIMARY KEY, 
	[Date] DATE NOT NULL,
	[DayOfWeek] NVARCHAR(10) NOT NULL,
	[Month] NVARCHAR(10) NOT NULL, 
	[Quarter] INT NOT NULL, 
	[Year] INT NOT NULL, 
	IsWeekend BIT NOT NULL
);

-----------------------------------------------------------
--Create DimCustomer table
-----------------------------------------------------------
IF OBJECT_ID('dim.DimCustomer', 'U') IS NOT NULL
	DROP TABLE dim.DimCustomer;

CREATE TABLE dim.DimCustomer(
	CustomerID INT IDENTITY(1,1) PRIMARY KEY, 
	FirstName NVARCHAR(100),
	LastName NVARCHAR(100),
	Gender NVARCHAR(10),
	DateOfBirth DATE,
	Email NVARCHAR(100),
	[Address] NVARCHAR(100),
	PhoneNumber NVARCHAR(100),
	City NVARCHAR(100),
	[State] NVARCHAR(100),
	ZipCode NVARCHAR(100),
	Country NVARCHAR(100),
	LoyaltyProgramID INT,

	CONSTRAINT FK_Customer_LoyaltyProgram
	FOREIGN KEY (LoyaltyProgramID)
	REFERENCES dim.DimLoyaltyProgram(LoyaltyProgramID)
);

-----------------------------------------------------------
--Create DimProduct table
-----------------------------------------------------------
IF OBJECT_ID('dim.DimProduct', 'U') IS NOT NULL
	DROP TABLE dim.DimProduct;

CREATE TABLE dim.DimProduct(
	ProductID INT IDENTITY(1,1) PRIMARY KEY, 
	ProductName NVARCHAR(100),
	Category NVARCHAR(100),
	Brand NVARCHAR(100),
	UnitPrice INT
);

-----------------------------------------------------------
--Create DimStore table
-----------------------------------------------------------
IF OBJECT_ID('dim.DimStore', 'U') IS NOT NULL
	DROP TABLE dim.DimStore;

CREATE TABLE dim.DimStore(
	StoreID INT IDENTITY(1,1) PRIMARY KEY, 
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

-----------------------------------------------------------
--Create FactOrders table
-----------------------------------------------------------
IF OBJECT_ID('fact.FactOrders', 'U') IS NOT NULL
	DROP TABLE fact.FactOrders;

CREATE TABLE fact.FactOrders(
	OrderID INT IDENTITY(1,1) PRIMARY KEY, 
	CustomerID INT NOT NULL, 
	StoreID INT NOT NULL, 
	OrderDateID INT NOT NULL, 
	ProductID INT NOT NULL,
	Quantity INT NOT NULL, 
	DiscountPercent DECIMAL(5,2) NOT NULL,
	DiscountAmount DECIMAL(10,2) NOT NULL,
	ShippingPercent DECIMAL(5,2) NOT NULL,
	ShippingAmount DECIMAL(10,2) NOT NULL,
	TotalAmount DECIMAL(12,2) NOT NULL,

	FOREIGN KEY (OrderDateID) REFERENCES dim.DimDate(DateID),
	FOREIGN KEY (ProductID) REFERENCES dim.DimProduct(ProductID),
	FOREIGN KEY (StoreID) REFERENCES dim.DimStore(StoreID),
	FOREIGN KEY (CustomerID) REFERENCES dim.DimCustomer(CustomerID)
);
