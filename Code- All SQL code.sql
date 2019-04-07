CREATE TABLE dbo.DimChannel
(
dimChannelKey INT IDENTITY(1,1) CONSTRAINT PK_DimChannel PRIMARY KEY CLUSTERED NOT NULL,
ChannelCategoryID INT NOT NULL,
ChannelCategoryName NVARCHAR(50) NOT NULL,
ChannelID INT NOT NULL,
ChannelName NVARCHAR(50) NOT NULL
);
GO

DROP TABLE dbo.DimChannel;

-- =============================
-- Begin load of unknown member
-- =============================
-- You have to set identity insert to ON so the table will let you force in a key value for the Identify column
SET IDENTITY_INSERT dbo.dimChannel ON;
-- Load the row for Unknown member
INSERT INTO dbo.dimChannel
(
dimChannelKey -- include the surrogate key column in the list
,ChannelCategoryID
,ChannelCategoryName
,ChannelID
,ChannelName
)
VALUES
(
-1 -- I use -1 as an ID for my unknown members so I always know what they are
,0 -- because there is a hierarchy flattened into this dimension, you have to pass a key here, so make sure you use one that is not a real value
,'Unknown'
,0 -- same for this key
,'Unknown'
);
-- Turn the identity insert to OFF so new rows auto assign identities
SET IDENTITY_INSERT dbo.dimChannel OFF;
GO

INSERT INTO dbo.DimChannel
(
ChannelCategoryID
,ChannelCategoryName
,ChannelID
,ChannelName
)
SELECT t2.ChannelCategoryID,
t2.ChannelCategory, 
t1.ChannelID,
t1.Channel
FROM StageChannel t1
LEFT JOIN StageChannelCategory t2
ON t1.ChannelCategoryID=t2.ChannelCategoryID;

DELETE FROM dbo.DimChannel;
DBCC CHECKIDENT ('dbo.DimChannel', RESEED, 0);
GO

SELECT * FROM dbo.DimChannel;


---------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.DimProduct
(
dimProductKey INT IDENTITY(1,1) CONSTRAINT PK_DimProduct PRIMARY KEY CLUSTERED NOT NULL,
ProductID INT NOT NULL,
Product NVARCHAR(50) NOT NULL,
Color NVARCHAR(50),
Style NVARCHAR(50),
ProWeight DECIMAL(18,4) NOT NULL,
Price DECIMAL(18,2) NOT NULL,
WholesalePrice DECIMAL(18,2) NOT NULL,
Cost DECIMAL(18,2) NOT NULL,
ProductTypeID INT NOT NULL,
ProductType NVARCHAR(50) NOT NULL,
ProductCategoryID INT NOT NULL,
ProductCategory NVARCHAR(50) NOT NULL
);
GO

DROP TABLE dbo.DimProduct;

-- =============================
-- Begin load of unknown member
-- =============================
-- You have to set identity insert to ON so the table will let you force in a key value for the Identify column
SET IDENTITY_INSERT dbo.DimProduct ON;
-- Load the row for Unknown member
INSERT INTO dbo.DimProduct
(
dimProductKey, -- include the surrogate key column in the list
ProductID,
Product,
Color,
Style,
ProWeight,
Price,
WholesalePrice,
Cost,
ProductTypeID,
ProductType,
ProductCategoryID,
ProductCategory
)
VALUES
(
-1 -- I use -1 as an ID for my unknown members so I always know what they are
,0 -- because there is a hierarchy flattened into this dimension, you have to pass a key here, so make sure you use one that is not a real value
,'Unknown'
,'Unknown'
,'Unknown'
,0
,0
,0
,0
,0
,'Unknown'
,0
,'Unknown'
);
-- Turn the identity insert to OFF so new rows auto assign identities
SET IDENTITY_INSERT dbo.DimProduct OFF;
GO

INSERT INTO dbo.DimProduct
(
ProductID,
Product,
Color,
Style,
ProWeight,
Price,
WholesalePrice,
Cost,
ProductTypeID,
ProductType,
ProductCategoryID,
ProductCategory
)
SELECT t1.ProductID,
t1.Product,
t1.Color,
t1.Style,
t1.Weight,
t1.Price,
t1.WholesalePrice,
t1.Cost,
t2.ProductTypeID,
t2.ProductType,
t3.ProductCategoryID,
t3.ProductCategory
FROM StageProduct t1
LEFT JOIN StageProductType t2
ON t1.ProductTypeID=t2.ProductTypeID
LEFT JOIN StageProductCategory t3
ON t2.ProductCategoryID=t3.ProductCategoryID;

DELETE FROM dbo.DimProduct;
DBCC CHECKIDENT ('dbo.DimProduct', RESEED, 0);
GO

SELECT * FROM dbo.DimProduct;


-------------------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.DimCustomer
(
dimCustomerKey INT IDENTITY(1,1) CONSTRAINT PK_DimCustomer PRIMARY KEY CLUSTERED NOT NULL,
CustomerID UNIQUEIDENTIFIER default NEWID(),
FirstName NVARCHAR(255) NOT NULL,
LastName NVARCHAR(255) NOT NULL,
Gender NVARCHAR(1) NOT NULL,
EmailAddress NVARCHAR(255) NOT NULL,
CusAddress NVARCHAR(255) NOT NULL,
City NVARCHAR(255) NOT NULL,
StateProvince NVARCHAR(255) NOT NULL,
Country NVARCHAR(255) NOT NULL,
PostalCode NVARCHAR(255) NOT NULL,
PhoneNumber NVARCHAR(20) NOT NULL
);
GO

DROP TABLE dbo.DimCustomer;

-- =============================
-- Begin load of unknown member
-- =============================
-- You have to set identity insert to ON so the table will let you force in a key value for the Identify column
SET IDENTITY_INSERT dbo.DimCustomer ON;
-- Load the row for Unknown member
INSERT INTO dbo.DimCustomer
(
dimCustomerKey,
CustomerID,
FirstName,
LastName,
Gender,
EmailAddress,
CusAddress,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
)
VALUES
(
-1 -- I use -1 as an ID for my unknown members so I always know what they are
,'00000000-0000-0000-0000-000000000000'
,'Unknown'
,'Unknown'
,' '
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
);
-- Turn the identity insert to OFF so new rows auto assign identities
SET IDENTITY_INSERT dbo.DimCustomer OFF;
GO

INSERT INTO dbo.DimCustomer
(
CustomerID,
FirstName,
LastName,
Gender,
EmailAddress,
CusAddress,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
)
SELECT CustomerID,
FirstName,
LastName,
Gender,
EmailAddress,
Address,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
FROM StageCustomer;

DELETE FROM dbo.DimCustomer;
DBCC CHECKIDENT ('dbo.DimCustomer', RESEED, 0);
GO

SELECT * FROM dbo.DimCustomer;


-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.DimReseller
(
dimResellerKey INT IDENTITY(1,1) CONSTRAINT PK_DimReseller PRIMARY KEY CLUSTERED NOT NULL,
ResellerID UNIQUEIDENTIFIER default NEWID(),
ResellerName NVARCHAR(255) NOT NULL,
Contact NVARCHAR(255) NOT NULL,
EmailAddress NVARCHAR(255) NOT NULL,
ResAddress NVARCHAR(255) NOT NULL,
City NVARCHAR(255) NOT NULL,
StateProvince NVARCHAR(255) NOT NULL,
Country NVARCHAR(255) NOT NULL,
PostalCode NVARCHAR(255) NOT NULL,
PhoneNumber NVARCHAR(20) NOT NULL
);
GO

DROP TABLE dbo.DimReseller;

-- =============================
-- Begin load of unknown member
-- =============================
-- You have to set identity insert to ON so the table will let you force in a key value for the Identify column
SET IDENTITY_INSERT dbo.DimReseller ON;
-- Load the row for Unknown member
INSERT INTO dbo.DimReseller
(
dimResellerKey,
ResellerID,
ResellerName,
Contact,
EmailAddress,
ResAddress,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
)
VALUES
(
-1 -- I use -1 as an ID for my unknown members so I always know what they are
,'00000000-0000-0000-0000-000000000000'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
);
-- Turn the identity insert to OFF so new rows auto assign identities
SET IDENTITY_INSERT dbo.DimReseller OFF;
GO

INSERT INTO dbo.DimReseller
(
ResellerID,
ResellerName,
Contact,
EmailAddress,
ResAddress,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
)
SELECT ResellerID,
ResellerName,
Contact,
EmailAddress,
Address,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
FROM StageReseller;

DELETE FROM DimReseller;
DBCC CHECKIDENT ('dbo.DimReseller', RESEED, 0);
GO

SELECT * FROM DimReseller;


----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.DimStore
(
dimStoreKey INT IDENTITY(1,1) CONSTRAINT PK_DimStore PRIMARY KEY CLUSTERED NOT NULL,
StoreID INT NOT NULL,
StoreNumber INT NOT NULL,
StoreManager NVARCHAR(255) NOT NULL,
StoAddress NVARCHAR(255) NOT NULL,
City NVARCHAR(255) NOT NULL,
StateProvince NVARCHAR(255) NOT NULL,
Country NVARCHAR(255) NOT NULL,
PostalCode NVARCHAR(255) NOT NULL,
PhoneNumber NVARCHAR(20) NOT NULL
);
GO

DROP TABLE dbo.DimStore;

-- =============================
-- Begin load of unknown member
-- =============================
-- You have to set identity insert to ON so the table will let you force in a key value for the Identify column
SET IDENTITY_INSERT dbo.DimStore ON;
-- Load the row for Unknown member
INSERT INTO dbo.DimStore
(
dimStoreKey,
StoreID,
StoreNumber,
StoreManager,
StoAddress,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
)
VALUES
(
-1 -- I use -1 as an ID for my unknown members so I always know what they are
,0
,0
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
,'Unknown'
);
-- Turn the identity insert to OFF so new rows auto assign identities
SET IDENTITY_INSERT dbo.DimStore OFF;
GO

INSERT INTO dbo.DimStore
(
StoreID,
StoreNumber,
StoreManager,
StoAddress,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
)
SELECT StoreID,
StoreNumber,
StoreManager,
Address,
City,
StateProvince,
Country,
PostalCode,
PhoneNumber
FROM StageStore;

DELETE FROM DimStore;
DBCC CHECKIDENT ('dbo.DimStore', RESEED, 0);
GO

SELECT * FROM DimStore;


--------------------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.FactSales
(
dimDateID INT NOT NULL CONSTRAINT FK_FactSales_DimDate_DimDateID FOREIGN KEY REFERENCES dbo.dimDate (dimDateID),
dimCustomerKey INT CONSTRAINT FK_FactSales_DimCustomer_dimCustomerKey FOREIGN KEY REFERENCES dbo.DimCustomer(dimCustomerKey),
dimResellerKey INT CONSTRAINT FK_FactSales_DimReseller_dimResellerKey FOREIGN KEY REFERENCES dbo.DimReseller(dimResellerKey),
dimStoreKey INT CONSTRAINT FK_FactSales_DimStore_dimStoreKey FOREIGN KEY REFERENCES dbo.DimStore(dimStoreKey),
dimChannelKey INT NOT NULL CONSTRAINT FK_FactSales_DimChannel_dimChannelKey FOREIGN KEY REFERENCES dbo.DimChannel(dimChannelKey),
dimProductKey INT NOT NULL CONSTRAINT FK_FactSales_DimProduct_dimProductKey FOREIGN KEY REFERENCES dbo.DimProduct(dimProductKey),
SalesQuantity INT NOT NULL,
SalesAmount NUMERIC(18,2) NOT NULL,
);
GO

DROP TABLE dbo.FactSales;

INSERT INTO dbo.FactSales
(
dimDateID,
dimCustomerKey,
dimResellerKey,
dimStoreKey,
dimChannelKey,
dimProductKey,
SalesQuantity,
SalesAmount
)
SELECT t2.DimDateID,
t3.dimCustomerKey,
t4.dimResellerKey,
t5.dimStoreKey,
t6.dimChannelKey,
t7.dimProductKey,
SalesQuantity,
SalesAmount
FROM dbo.StageSalesDetail t0
INNER JOIN dbo.StageSalesHeader t1
ON t0.SalesHeaderID=t1.SalesHeaderID
LEFT JOIN dbo.DimDate t2
ON t1.Date=t2.FullDate
LEFT JOIN dbo.DimCustomer t3
ON t1.CustomerID=t3.CustomerID
LEFT JOIN dbo.DimReseller t4
ON t1.ResellerID=t4.ResellerID
LEFT JOIN dbo.DimStore t5
ON t1.StoreID=t5.StoreID
INNER JOIN dbo.DimChannel t6
ON t1.ChannelID=t6.ChannelID
INNER JOIN dbo.DimProduct t7
ON t0.ProductID=t7.ProductID;

UPDATE dbo.FactSales
SET dimResellerKey=-1
WHERE
dimResellerKey IS NULL;
UPDATE dbo.FactSales
SET dimCustomerKey=-1
WHERE
dimCustomerKey IS NULL;
UPDATE dbo.FactSales
SET dimStoreKey=-1
WHERE
dimStoreKey IS NULL;

DELETE FROM dbo.FactSales;

SELECT * FROM dbo.FactSales;


-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.FactTargetQuantity
(
dimDateID INT NOT NULL CONSTRAINT FK_TargetQuantity_DimDate_DimDateID FOREIGN KEY REFERENCES dbo.dimDate (dimDateID),
dimProductKey INT NOT NULL CONSTRAINT FK_TargetQuantity_DimProduct_dimProductKey FOREIGN KEY REFERENCES dbo.DimProduct(dimProductKey),
SalesQuantityTarget NUMERIC(16,6)
);
GO

ALTER TABLE dbo.StageTargetQuantity
ALTER COLUMN [SalesQuantityTarget] NUMERIC(16,6);

INSERT INTO dbo.FactTargetQuantity
(
dimDateID,
dimProductKey,
SalesQuantityTarget
)
SELECT t2.DimDateID,
t3.dimProductKey,
(SalesQuantityTarget/365)
FROM dbo.StageTargetQuantity t1
LEFT JOIN dbo.DimDate t2
ON t1.Year=t2.CalendarYear
LEFT JOIN dbo.DimProduct t3
ON t1.ProductID=t3.ProductID;

DELETE FROM dbo.FactTargetQuantity;

SELECT * FROM dbo.FactTargetQuantity;

DROP TABLE dbo.FactTargetQuantity;


-----------------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.FactTargetSales
(
dimDateID INT NOT NULL CONSTRAINT FK_FactTargetSales_DimDate_DimDateID FOREIGN KEY REFERENCES dbo.dimDate (dimDateID),
dimChannelKey INT CONSTRAINT FK_FactTargetSales_DimChannel_dimChannelKey FOREIGN KEY REFERENCES dbo.DimChannel(dimChannelKey),
dimResellerKey INT CONSTRAINT FK_FactTargetSales_DimReseller_dimResellerKey FOREIGN KEY REFERENCES dbo.DimReseller(dimResellerKey) ,
dimStoreKey INT CONSTRAINT FK_FactTargetSales_DimStore_dimStoreKey FOREIGN KEY REFERENCES dbo.DimStore(dimStoreKey),
TargetSalesAmount NUMERIC(16,6)
);
GO

UPDATE dbo.StageTargetSales
SET [ TargetSalesAmount ] = REPLACE([ TargetSalesAmount ], '$','');
UPDATE dbo.StageTargetSales
SET [ TargetSalesAmount ] = REPLACE([ TargetSalesAmount ], ',','');
UPDATE dbo.StageTargetSales
SET [TargetName]= REPLACE([TargetName], 'pp','p');
SELECT dimStoreKey, ('Store Number '+ CONVERT(VARCHAR(3), StoreNumber)) AS refg INTO tem FROM dbo.DimStore;
UPDATE dbo.DimChannel
SET ChannelName = REPLACE(ChannelName, '-','');

INSERT INTO dbo.FactTargetSales
(
dimDateID,
dimChannelKey,
dimResellerKey,
dimStoreKey,
TargetSalesAmount
)
SELECT t2.DimDateID,
t4.dimChannelKey,
t3.dimResellerKey,
tem.dimStoreKey,
(cast (t1.[ TargetSalesAmount ] AS Numeric(16,6))/365)
FROM dbo.StageTargetSales t1
LEFT JOIN dbo.DimDate t2
ON t1.Year=t2.CalendarYear
LEFT JOIN dbo.DimChannelView t4
ON t1.ChannelName=t4.ChannelName
LEFT JOIN dbo.DimReseller t3
ON t1.TargetName=t3.ResellerName
LEFT JOIN tem
ON t1.TargetName=tem.refg;
DROP TABLE tem;

UPDATE dbo.FactTargetSales
SET dimResellerKey=-1
WHERE
dimResellerKey IS NULL;
UPDATE dbo.FactTargetSales
SET dimStoreKey=-1
WHERE
dimStoreKey IS NULL;

DELETE FROM dbo.FactTargetSales;

SELECT * FROM dbo.FactTargetSales;

DROP TABLE dbo.FactTargetSales;


-------------------------------------------------------------------------------------------------------------------------