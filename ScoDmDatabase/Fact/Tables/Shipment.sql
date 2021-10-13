CREATE TABLE [Fact].[Shipment]
(
	
	--Surrogate (Primary) Key
	[ShipmentKEY] 			INT			NOT NULL
	
	--ForignKeys
	, [CustomerStoreKEY] 		INT			NOT NULL		

	--Measure Columns

	-- Data Mart Logging
	, [DmBatchKEY]			INT					NOT NULL		DEFAULT(-1)
	, [DmCreateDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]		DATETIME			NOT NULL		DEFAULT(GETDATE()) 

	--Table Constraints PK First then Foerign Keys 
    , CONSTRAINT [PK_Fact_Shipment_ShipmentKEY] PRIMARY KEY CLUSTERED ([ShipmentKEY] ASC) 
)

--Additional Indexes

