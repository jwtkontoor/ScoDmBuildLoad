CREATE TABLE [Stage].[EdiInventoryUpdates]
(
	  [MaterialLineNUM]			VARCHAR(255)		NOT NULL		
	, [UniqueID]				VARCHAR(255)		NULL
	, [HeaderUniqueID]			VARCHAR(255)		NULL
	, [EdiDetailId]				VARCHAR(255)		NULL
	, [MaterialNUM]				VARCHAR(255)		NULL
	, [ActivityCD]				VARCHAR(255)		NULL
	, [LegacyMaterialNUM]		VARCHAR(255)		NULL		
	, [UniversalProductCD]		VARCHAR(255)		NOT NULL
	, [UnitOfMeasure]			VARCHAR(255)		NULL
	, [ItemDTS]					VARCHAR(255)		NULL
	, [ItemNUM]					VARCHAR(255)		NULL
	, [QuantityAMT]				VARCHAR(255)		NULL
	, [ItemPrice]				DATE				NULL
	, [ItemQualifierCD]			INT					NULL
	, [ObjectNUM]				VARCHAR(255)		NULL
	, [Katr7]					VARCHAR(255)		NULL
	, [DocumentDTS]				VARCHAR(255)		NULL
	, [LegacyStoreNUM]			INT					NULL
	, [InternalNUM] 			INT					NULL
	, [RefDoc]					INT					NULL
	, [DocNUM]					INT					NULL
	, [PosNUM]					VARCHAR(255)		NULL
	, [PartnerID]				VARCHAR(255)		NULL
	, [SoldTo]					VARCHAR(255)		NULL
	, [LegacySoldTo]			VARCHAR(255)		NULL
	, [JurisdictionCD]			VARCHAR(255)		NULL
	, [NameText]				INT					NULL
	, [DamagedQTY]				INT					NULL
	, [DaysSupplyQTY]			INT					NULL
	, [ForecastVarianceQTY]		INT					NULL
	, [OnHoldQTY]				INT					NULL
	, [AvailableQTY]			INT					NULL
	, [EndingQTY]				INT					NULL
	, [InTransitQTY]			INT					NULL
	, [OutOfStockQTY]			INT					NULL
	, [OnOrderQTY]				INT					NULL
	, [ReceivedQTY]				INT					NULL
	, [SoldQTY]					INT					NULL
	, [InventoryAdjustmentQTY]	INT					NULL
	, [ReturnedQTY]				INT					NULL
	, [SalesQTY]				INT					NULL
	, [SellThruPCT]				INT					NULL
	, [TotalSalesQTY]			INT					NULL
	, [WeeksSupplyNUM]			INT					NULL
	, [EdiFileSentDTS]			DATE				NULL
	, [EdiFileSentKEY]			INT					NULL
	, [EdiFileStartDTS]			DATE				NULL
	, [EdiFileStartKEY]			INT					NULL
	, [EdiFileEndDTS]			DATE				NULL
	, [EdiFileEndKEY]			INT					NULL

)