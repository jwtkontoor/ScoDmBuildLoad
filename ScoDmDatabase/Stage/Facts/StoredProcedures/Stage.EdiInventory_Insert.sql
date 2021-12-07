CREATE PROCEDURE [Stage].[EdiInventory_Insert] 

	@BatchKEY INT

AS 

--============================================================================================================

	DECLARE @ProcessStartDT DATETIME		= GETDATE();
	DECLARE @ProcessEndDT	DATETIME;
	DECLARE @RowsInserted	VARCHAR(255)	= 0;
	DECLARE @RowsUpdated	VARCHAR(255)	= 0;
	DECLARE @ProcessNM		VARCHAR(255)	= OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
	DECLARE @Result			VARCHAR(255);

--============================================================================================================

BEGIN TRY
	 
DECLARE @LastEdiSentDate		AS INT;
DECLARE @LastEdiLoadedDate		AS INT; 

--SELECT DISTINCT @LastEdiLoadedDate = [EdiFileSentDTS] FROM Fact.InventoryPosition;
--20210910 

TRUNCATE TABLE [Stage].[EdiInventoryUpdates];

WITH EdiDetailPivot AS (
	SELECT 
		  [MANDT]		AS [Man]	
		, [UNIQUEID]	AS [UniqueID]
		, CONCAT_WS ( '|', [MANDT], [UNIQUEID])	AS [HeaderUniqueID]
		, [MATERIALNO]	AS [MaterialNUM]	
		, CONCAT_WS('|', [MANDT], [UNIQUEID], [MATERIALNO] ) AS [EdiDetailId]
		, [DG]			AS [DamagedQTY]
		, [DS]			AS [DaysSupplyQTY]
		, [FV]			AS [ForecastVarianceQTY]
		, [HL]			AS [OnHoldQTY]
		, [QA]			AS [AvailableQTY]
		, [QE]			AS [EndingQTY]
		, [QI]			AS [InTransitQTY]
		, [QO]			AS [OutOfStockQTY]
		, [QP]			AS [OnOrderQTY]
		, [QR]			AS [ReceivedQTY]
		, [QS]			AS [SoldQTY]
		, [QT]			AS [InventoryAdjustmentQTY]
		, [QU]			AS [ReturnedQTY]
		, [SS]			AS [SalesQTY]
		, [ST]			AS [SellThruPCT]
		, [TS]			AS [TotalSalesQTY]
		, [WS] 			AS [WeeksSupplyNUM]
	FROM   
	(
		SELECT TOP 1000
			  [MANDT]		
			, [UNIQUEID]	
			, [MATERIALNO]	
			, [ACTIVITYCODE] 
			, [ITEMQUANTITY]
		FROM [LOGILITY_SLT_PPD].[sapee1et1].[ZOTC_T_RFSM_ITEM]
		WHERE 1 = 1 
		AND [ITEMQUANTITY] > 0 
		AND [ITEMDATE] = 20210405
	 ) p  
	PIVOT  
	(  
		MAX([ITEMQUANTITY])	  
		FOR [ACTIVITYCODE] IN  
		( 
			  [DG]
			, [DS]
			, [FV]
			, [HL]
			, [QA]
			, [QE]
			, [QI]
			, [QO]
			, [QP]
			, [QR]
			, [QS]
			, [QT]
			, [QU]
			, [SS]
			, [ST]
			, [TS]
			, [WS] 

		)  
	) AS pvt  

), 

EdiInventoryPosition AS 
(
	SELECT 
		  [Man]	
		, i.[UniqueID]
		, [HeaderUniqueID]
		, [MaterialNUM]	
		, [EdiDetailId]
		, [DamagedQTY]
		, [DaysSupplyQTY]
		, [ForecastVarianceQTY]
		, [OnHoldQTY]
		, [AvailableQTY]
		, [EndingQTY]
		, [InTransitQTY]
		, [OutOfStockQTY]
		, [OnOrderQTY]
		, [ReceivedQTY]
		, [SoldQTY]
		, [InventoryAdjustmentQTY]
		, [ReturnedQTY]
		, [SalesQTY]
		, [SellThruPCT]
		, [TotalSalesQTY]
		, [WeeksSupplyNUM]
		, [KATR7]												AS [Katr7]
		, [IDOC_DATE]											AS [DocumentDTS]
		, NULLIF([LEGACY_STORE_NO],'') 							AS [LegacyStoreNUM]
		, NULLIF([INTERNAL_NUMBER], '')							AS [InternalNUM] 
		, [QUALF_REF_DOC]										AS [RefDoc]
		, [DOC_NO]												AS [DocNUM]
		, [POSNR]												AS [PosNUM]
		, [PATNER_ID]											AS [PartnerID]
		, [SOLD_T_PARTY]										AS [SoldTo]
		, [LEGACY_SOLDTO]										AS [LegacySoldTo]
		, [JURISDIC]											AS [JurisdictionCD]
		, [NAME_TEXT]											AS [NameText]
		, [ZZ000FILESENTDATE]									AS [EdiFileSentDTS]
		, [ZZ001BEGINNINGDATE]									AS [EdiFileStartDTS]
		, [ZZ002ENDDATE]										AS [EdiFileEndDTS]

	FROM EdiDetailPivot i 
	INNER JOIN [LOGILITY_SLT_PPD].[sapee1et1].[ZOTC_T_RFSM_HDR] h 
		ON i.[MAN] = h.[MANDT] AND i.[UNIQUEID] = h.[UNIQUEID]
)
	
INSERT INTO Stage.EdiInventoryUpdates
( 
	  [MaterialLineNUM]	
	, [UniqueID]
	, [HeaderUniqueID]
	, [MaterialNUM]	
	, [EdiDetailId]
	, [DamagedQTY]
	, [DaysSupplyQTY]
	, [ForecastVarianceQTY]
	, [OnHoldQTY]
	, [AvailableQTY]
	, [EndingQTY]
	, [InTransitQTY]
	, [OutOfStockQTY]
	, [OnOrderQTY]
	, [ReceivedQTY]
	, [SoldQTY]
	, [InventoryAdjustmentQTY]
	, [ReturnedQTY]
	, [SalesQTY]
	, [SellThruPCT]
	, [TotalSalesQTY]
	, [WeeksSupplyNUM]
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
) 

SELECT  
	  [Man]	
	, [UniqueID]
	, [HeaderUniqueID]
	, [MaterialNUM]	
	, [EdiDetailId]
	, [DamagedQTY]
	, [DaysSupplyQTY]
	, [ForecastVarianceQTY]
	, [OnHoldQTY]
	, [AvailableQTY]
	, [EndingQTY]
	, [InTransitQTY]
	, [OutOfStockQTY]
	, [OnOrderQTY]
	, [ReceivedQTY]
	, [SoldQTY]
	, [InventoryAdjustmentQTY]
	, [ReturnedQTY]
	, [SalesQTY]
	, [SellThruPCT]
	, [TotalSalesQTY]
	, [WeeksSupplyNUM]
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
FROM EdiInventoryPosition;


--=================================================================================================

	SET @RowsInserted	= @@ROWCOUNT;
	SET @ProcessEndDT	= GETDATE();
	SET @Result			= 'SUCCESS';

	EXECUTE [Log].[EtlProcess_Create] @BatchKEY, @ProcessStartDT, @ProcessEndDT, @RowsInserted, @RowsUpdated, @ProcessNM, @Result;

	RETURN 1;

END TRY

BEGIN CATCH

	SET @RowsUpdated	= 0;
	SET @ProcessEndDT	= GETDATE();
	SET @Result			= 'FAIL';

	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
				
	EXECUTE [Log].EtlError_Create  @BatchKEY, @ErrorMessage;

	EXECUTE [Log].[EtlProcess_Create] @BatchKEY, @ProcessStartDT, @ProcessEndDT, @RowsInserted, @RowsUpdated, @ProcessNM, @Result;
    
	RAISERROR (

		@ErrorMessage,
		@ErrorSeverity, 
		@ErrorState 
	);

END CATCH;
