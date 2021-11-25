/*******************************************************************************/
/**  
	Working Fact Table 
	Created By: JWT					Created On: 7/26/21

	Used for loading the InventoryPosition Fact table.  See InventoryPosition Fact for details.

**/
/*******************************************************************************/

CREATE TABLE [Work].[InventoryPosition]
(
	--Primary Key - natural and surrogate
	[InventoryPositionKEY]			INT				NOT NULL		IDENTITY (1,1) 
	, [InventoryPositionId]			INT				NOT NULL 

	--Foreign Keys  - natural and surrogate  
	, [CustomerId]					INT				NOT NULL		
	, [CustomerKEY]					INT				NOT NULL		

	--Measures and Natual keys
	, [Material]					INT				NOT NULL
	, [HeaderUniqueID] 				VARCHAR(255)	NOT NULL
	, [EdiDetailId]					VARCHAR(255)	NOT NULL
	, [MaterialNUM]					VARCHAR(255)	NOT NULL
	, [ActivityCD]					VARCHAR(255)	NOT NULL
	, [LegacyMaterialNUM]			VARCHAR(255)	NOT NULL
	, [UniversalProductCD]			VARCHAR(255)	NOT NULL
	, [UnitOfMeasure]				VARCHAR(255)	NOT NULL
	, [ItemDTS]						VARCHAR(255)	NOT NULL
	, [ItemNUM]						VARCHAR(255)	NOT NULL
	, [QuantityAMT]					DECIMAL(15,3) 	NOT NULL
	, [ItemPrice]					DECIMAL(15,3) 	NOT NULL
	, [ItemQualifierCD]				VARCHAR(255)	NOT NULL
	, [ObjectNUM]					VARCHAR(255)	NOT NULL
	, [Katr7]						VARCHAR(255)	NOT NULL
	, [DocumentDTS]					VARCHAR(255)	NOT NULL
	, [LegacyStoreNUM] 				VARCHAR(255)	NOT NULL
	, [InternalNUM]  				VARCHAR(255)	NOT NULL
	, [RefDoc] 						VARCHAR(255)	NOT NULL
	, [DocNUM] 						VARCHAR(255)	NOT NULL
	, [PosNUM] 						VARCHAR(255)	NOT NULL
	, [PartnerID] 					VARCHAR(255)	NOT NULL
	, [SoldTo] 						VARCHAR(255)	NOT NULL
	, [LegacySoldTo] 				VARCHAR(255)	NOT NULL
	, [JurisdictionCD] 				VARCHAR(255)	NOT NULL
	, [NameText] 					VARCHAR(255)	NOT NULL
	, [EdiFileSentDTS] 				VARCHAR(255)	NOT NULL
	, [EdiFileStartDTS] 			VARCHAR(255)	NOT NULL
	, [EdiFileEndDTS] 				VARCHAR(255)	NOT NULL
	
	-- Data Mart Logging
	, [DmBatchKEY]					INT				NOT NULL		DEFAULT(-1)
	, [DmCreateDate]				DATETIME		NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]				DATETIME		NOT NULL		DEFAULT(GETDATE()) 

	--Table Constraints PK First then Forign Keys
	, CONSTRAINT [PK_Work_InventoryPosition_InventoryPositionId] PRIMARY KEY CLUSTERED ([InventoryPositionKEY] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Work_InventoryPosition_InventoryPositionId] ON [Work].[InventoryPosition] (InventoryPositionId ASC)
GO
