/*******************************************************************************/
/**  
	Inventory Fact Table 
	Created By: JWT					Created On: 7/26/21

	Contains measures related to inventory counts in variouse stages for a
	given customer on a given day

**/
/*******************************************************************************/

CREATE TABLE [Fact].[InventoryPosition]
(
	--Surrogate (Primary) Key
	[InventoryPositionKEY]			INT			NOT NULL
	
	--ForignKeys
	, [CustomerKEY] 		INT			NOT NULL	
	, [ProductKEY] 			INT			NOT NULL	
	, [PositionDateKEY] 	INT			NOT NULL	

	--Data Columns
	, [Material]					VARCHAR(255)		NULL 
	, [HeaderUniqueID]				VARCHAR(255)		NULL
	, [EdiDetailId]				VARCHAR(255)		NULL
	, [MaterialNUM]				VARCHAR(255)		NULL
	, [ActivityCD]				VARCHAR(255)		NULL
	, [LegacyMaterialNUM]				VARCHAR(255)		NULL
	, [UniversalProductCD]				VARCHAR(255)		NULL
	, [UnitOfMeasure]				VARCHAR(255)		NULL
	, [ItemDTS]				VARCHAR(255)		NULL
	, [ItemNUM]				VARCHAR(255)		NULL
	, [QuantityAMT]				VARCHAR(255)		NULL
	, [ItemPrice]				VARCHAR(255)		NULL
	, [ItemQualifierCD]				VARCHAR(255)		NULL
	, [ObjectNUM]				VARCHAR(255)		NULL
	, [Katr7]				VARCHAR(255)		NULL
	, [DocumentDTS]				VARCHAR(255)		NULL
	, [LegacyStoreNUM] 				VARCHAR(255)		NULL
	, [InternalNUM] 				VARCHAR(255)		NULL
	, [RefDoc]				VARCHAR(255)		NULL
	, [DocNUM]				VARCHAR(255)		NULL
	, [PosNUM]				VARCHAR(255)		NULL
	, [PartnerID]				VARCHAR(255)		NULL
	, [SoldTo]				VARCHAR(255)		NULL
	, [LegacySoldTo]				VARCHAR(255)		NULL
	, [JurisdictionCD]				VARCHAR(255)		NULL
	, [NameText]				VARCHAR(255)		NULL
	, [EdiFileSentDTS]				VARCHAR(255)		NULL
	, [EdiFileStartDTS]				VARCHAR(255)		NULL
	, [EdiFileEndDTS]				VARCHAR(255)		NULL

	-- Data Mart Logging
	, [DmBatchKEY]			INT					NOT NULL		DEFAULT(-1)
	, [DmCreateDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]		DATETIME			NOT NULL		DEFAULT(GETDATE()) 

	--Table Constraints PK First then Foerign Keys 
    , CONSTRAINT [PK_Fact_InventoryPosition_InventoryPositionKEY] PRIMARY KEY CLUSTERED ([InventoryPositionKEY] ASC) 
)

--Additional Indexes