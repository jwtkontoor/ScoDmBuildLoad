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
	, [Material]
	, [HeaderUniqueID]
	, [EdiDetailId]
	, [MaterialNUM]
	, [ActivityCD]
	, [LegacyMaterialNUM]
	, [UniversalProductCD]
	, [UnitOfMeasure]
	, [ItemDTS]
	, [ItemNUM]
	, [QuantityAMT]
	, [ItemPrice]
	, [ItemQualifierCD]
	, [ObjectNUM]
	, [Katr7]
	, [DocumentDTS]
	, [LegacyStoreNUM]
	, [InternalNUM] 
	, [RefDoc]
	, [DocNUM]
	, [PosNUM]
	, [PartnerID]
	, [SoldTo]
	, [LegacySoldTo]
	, [JurisdictionCD]
	, [NameText]
	, [EdiFileSentDTS]
	, [EdiFileStartDTS]
	, [EdiFileEndDTS]

	-- Data Mart Logging
	, [DmBatchKEY]			INT					NOT NULL		DEFAULT(-1)
	, [DmCreateDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]		DATETIME			NOT NULL		DEFAULT(GETDATE()) 

	--Table Constraints PK First then Foerign Keys 
    , CONSTRAINT [PK_Fact_InventoryPosition_InventoryPositionKEY] PRIMARY KEY CLUSTERED ([InventoryPositionKEY] ASC) 
)

--Additional Indexes