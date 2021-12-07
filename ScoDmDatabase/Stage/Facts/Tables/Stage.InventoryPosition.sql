CREATE TABLE [Stage].[InventoryPosition]
(	
	  [InventoryPositionId] 				VARCHAR(255)		NOT NULL
	, [OrderTypeCD]							VARCHAR(255)		NULL
	, [SalesOrderNUM]						VARCHAR(255)		NULL
	, [SalesOrderItemNUM]					VARCHAR(255)		NULL
	, [SalesOrderItemLineNUM]				VARCHAR(255)		NULL
	, [KeyAccountCD]						VARCHAR(255)		NULL
	, [MaterialID]							VARCHAR(255)		NULL
	, [PlantId]								VARCHAR(255)		NULL
	, [SoldToCustomerId]					VARCHAR(255)		NULL
	, [ShipToCustomerId]					VARCHAR(255)		NULL
	, [MarkForCD]							VARCHAR(255)		NULL
	, [CalendarDTS]							DATE		NULL
	, [CalendarDateKEY]						INT		NULL
	, [DisributionChannel]					VARCHAR(255)		NULL
	, [RegionCD]							VARCHAR(255)		NULL
	, [OpenQTY]        						INT				NULL
	, [ConfirmedQTY]						INT				NULL
	, [DeliveredQTY]						INT				NULL
	, [CancelledQTY]						INT				NULL
	, [TrackingNUM]							VARCHAR(255)		NULL
	, [Segment]								VARCHAR(255)		NULL
	, [Season]								VARCHAR(255)		NULL
	, [SeasonYear]    						VARCHAR(255)		NULL
	, [ReasonCD] 							VARCHAR(255)		NULL
	, [OrderQuantityAMT]					INT					NULL 
	, [OrderDTS] 							DATE		NULL
	, [OrderDateKEY]						INT		NULL
	, [MaterialLineNUM]						VARCHAR(255)		NOT NULL	
	, [UniqueID]							VARCHAR(255)		NOT NULL	
	, [HeaderUniqueID]						VARCHAR(255)		NOT NULL
	, [EdiDetailId]							VARCHAR(255)		NULL
	, [MaterialNUM]							VARCHAR(255)		NULL
	, [ActivityCD]							VARCHAR(255)		NULL
	, [LegacyMaterialNUM]					VARCHAR(255)		NULL		
	, [UniversalProductCD]					VARCHAR(255)		NOT NULL
	, [UnitOfMeasure]						VARCHAR(255)		NULL
	, [ItemDTS]								VARCHAR(255)		NULL
	, [ItemNUM]								VARCHAR(255)		NULL
	, [QuantityAMT]							VARCHAR(255)		NULL
	, [ItemPrice]							DATE				NULL
	, [ItemQualifierCD]						INT					NULL
	, [ObjectNUM]							VARCHAR(255)		NULL
	, [Katr7]								VARCHAR(255)		NULL
	, [DocumentDTS]							VARCHAR(255)		NULL
	, [LegacyStoreNUM]						INT					NULL
	, [InternalNUM] 						INT					NULL
	, [RefDoc]								INT					NULL
	, [DocNUM]								INT					NULL
	, [PosNUM]								VARCHAR(255)		NULL
	, [PartnerID]							VARCHAR(255)		NULL
	, [SoldTo]								VARCHAR(255)		NULL
	, [LegacySoldTo]						VARCHAR(255)		NULL
	, [JurisdictionCD]						VARCHAR(255)		NULL
	, [NameText]							INT					NULL
	, [DamagedQTY]							INT					NULL			DEFAULT (0)
	, [DaysSupplyQTY]						INT					NULL			DEFAULT (0)
	, [ForecastVarianceQTY]					INT					NULL			DEFAULT (0)
	, [OnHoldQTY]							INT					NULL			DEFAULT (0)
	, [AvailableQTY]						INT					NULL			DEFAULT (0)
	, [EndingQTY]							INT					NULL			DEFAULT (0)
	, [InTransitQTY]						INT					NULL			DEFAULT (0)
	, [OutOfStockQTY]						INT					NULL			DEFAULT (0)
	, [OnOrderQTY]							INT					NULL			DEFAULT (0)
	, [ReceivedQTY]							INT					NULL			DEFAULT (0)
	, [SoldQTY]								INT					NULL			DEFAULT (0)
	, [InventoryAdjustmentQTY]				INT					NULL			DEFAULT (0)
	, [ReturnedQTY]							INT					NULL			DEFAULT (0)
	, [SalesQTY]							INT					NULL			DEFAULT (0)
	, [SellThruPCT]							INT					NULL			DEFAULT (0)
	, [TotalSalesQTY]						INT					NULL			DEFAULT (0)
	, [WeeksSupplyNUM]						INT					NULL
	, [EdiFileSentDTS]						DATE				NULL
	, [EdiFileSentKEY]						INT					NULL
	, [EdiFileStartDTS]						DATE				NULL
	, [EdiFileStartKEY]						INT					NULL
	, [EdiFileEndDTS]						DATE				NULL
	, [EdiFileEndKEY]						INT					NULL 
)