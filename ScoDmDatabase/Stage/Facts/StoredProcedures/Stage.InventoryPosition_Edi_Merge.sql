CREATE PROCEDURE [Stage].[InventoryPosition_Edi_Merge]

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
	 
WITH EdiInventoryPosition AS 
(
	SELECT 
		  [MaterialLineNUM]							AS [MaterialLineNUM]	
		, [HeaderUniqueID]							AS [HeaderUniqueID]
		, [MaterialNUM]								AS [MaterialNUM]	
		, [DamagedQTY]								AS [DamagedQTY]
		, [DaysSupplyQTY]							AS [DaysSupplyQTY]
		, [ForecastVarianceQTY]						AS [ForecastVarianceQTY]
		, [OnHoldQTY]								AS [OnHoldQTY]
		, [AvailableQTY]							AS [AvailableQTY]
		, [EndingQTY]								AS [EndingQTY]
		, [InTransitQTY]							AS [InTransitQTY]
		, [OutOfStockQTY]							AS [OutOfStockQTY]
		, [OnOrderQTY]								AS [OnOrderQTY]
		, [ReceivedQTY]								AS [ReceivedQTY]
		, [SoldQTY]									AS [SoldQTY]
		, [InventoryAdjustmentQTY]					AS [InventoryAdjustmentQTY]
		, [ReturnedQTY]								AS [ReturnedQTY]
		, [SalesQTY]								AS [SalesQTY]
		, [SellThruPCT]								AS [SellThruPCT]
		, [TotalSalesQTY]							AS [TotalSalesQTY]
		, [WeeksSupplyNUM]							AS [WeeksSupplyNUM]
		, [KATR7]									AS [Katr7]
		, [DocumentDTS]								AS [DocumentDTS]
		, [LegacyStoreNUM]							AS [LegacyStoreNUM]
		, [InternalNUM] 							AS [InternalNUM] 
		, [RefDoc]									AS [RefDoc]
		, [DocNUM]									AS [DocNUM]
		, [PosNUM]									AS [PosNUM]
		, [PartnerID]								AS [PartnerID]
		, [SoldTo]									AS [SoldTo]
		, [LegacySoldTo]							AS [LegacySoldTo]
		, [JurisdictionCD]							AS [JurisdictionCD]
		, [NameText]								AS [NameText]
		, [EdiFileSentDTS]							AS [EdiFileSentDTS]
		, [EdiFileStartDTS]							AS [EdiFileStartDTS]
		, [EdiFileEndDTS]							AS [EdiFileEndDTS]

	FROM Stage.EdiInventoryUpdates i 
)
	
MERGE INTO Stage.InventoryPosition tgt 

USING ( 

    SELECT 
        a.* 
    FROM EdiInventoryPosition a

) src 

	ON ( 

		tgt.[MaterialID] = src.[MaterialNUM]
		AND tgt.[ShipToCustomerId] = src.[SoldTo]
	)

	WHEN MATCHED THEN 

		UPDATE SET
        
		  tgt.[MaterialLineNUM]				= src.[MaterialLineNUM]				
		, tgt.[HeaderUniqueID]				= src.[HeaderUniqueID]			
		, tgt.[MaterialNUM]					= src.[MaterialNUM]				
		, tgt.[DamagedQTY]					= src.[DamagedQTY]				
		, tgt.[DaysSupplyQTY]				= src.[DaysSupplyQTY]			
		, tgt.[ForecastVarianceQTY]			= src.[ForecastVarianceQTY]		
		, tgt.[OnHoldQTY]					= src.[OnHoldQTY]				
		, tgt.[AvailableQTY]				= src.[AvailableQTY]			
		, tgt.[EndingQTY]					= src.[EndingQTY]				
		, tgt.[InTransitQTY]				= src.[InTransitQTY]			
		, tgt.[OutOfStockQTY]				= src.[OutOfStockQTY]			
		, tgt.[OnOrderQTY]					= src.[OnOrderQTY]				
		, tgt.[ReceivedQTY]					= src.[ReceivedQTY]				
		, tgt.[SoldQTY]						= src.[SoldQTY]					
		, tgt.[InventoryAdjustmentQTY]		= src.[InventoryAdjustmentQTY]	
		, tgt.[ReturnedQTY]					= src.[ReturnedQTY]				
		, tgt.[SalesQTY]					= src.[SalesQTY]				
		, tgt.[SellThruPCT]					= src.[SellThruPCT]				
		, tgt.[TotalSalesQTY]				= src.[TotalSalesQTY]			
		, tgt.[WeeksSupplyNUM]				= src.[WeeksSupplyNUM]			
		, tgt.[Katr7]						= src.[Katr7]					
		, tgt.[DocumentDTS]					= src.[DocumentDTS]				
		, tgt.[LegacyStoreNUM]				= src.[LegacyStoreNUM]			
		, tgt.[InternalNUM] 				= src.[InternalNUM] 			
		, tgt.[RefDoc]						= src.[RefDoc]					
		, tgt.[DocNUM]						= src.[DocNUM]					
		, tgt.[PosNUM]						= src.[PosNUM]					
		, tgt.[PartnerID]					= src.[PartnerID]				
		, tgt.[SoldTo]						= src.[SoldTo]					
		, tgt.[LegacySoldTo]				= src.[LegacySoldTo]			
		, tgt.[JurisdictionCD]				= src.[JurisdictionCD]			
		, tgt.[NameText]					= src.[NameText]				
		, tgt.[EdiFileSentDTS]				= src.[EdiFileSentDTS]			
		, tgt.[EdiFileStartDTS]				= src.[EdiFileStartDTS]			
		, tgt.[EdiFileEndDTS] 				= src.[EdiFileEndDTS] 			

		;

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
