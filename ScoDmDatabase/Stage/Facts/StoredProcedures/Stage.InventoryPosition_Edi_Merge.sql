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
	 
DECLARE @LastEdiSentDate		AS INT;
DECLARE @LastEdiLoadedDate		AS INT; 

SELECT DISTINCT @LastEdiLoadedDate = [EdiFileSentDTS] FROM Fact.InventoryPosition;
--20210910 

WITH EdiDetailPivot AS (
	SELECT 
		  [MANDT]		AS [Man]	
		, [UNIQUEID]	AS [UniqueID]
		, [MATERIALNO]	AS [MaterialNUM]	
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
		, [UniqueID]
		, [MaterialNUM]	
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
		ON i.[MANDT] = h.[MANDT] AND i.[UNIQUEID] = h.[UNIQUEID]
)
	
MERGE INTO Stage.InventoryPosition tgt 

USING ( 

    SELECT 
        a.* 
    FROM EdiInventory a

) src 

	ON ( 

		tgt.ProductKEY = src.ProductKEY
	)

	WHEN MATCHED THEN 

		UPDATE SET
        
        

		  tgt.[ProductKEY]								= src.[ProductKEY]				
		, tgt.[ProductID]								= src.[ProductID]				
		, tgt.[ProductDSC]								= src.[ProductDSC]
		, tgt.[DivisionCD]								= src.[DivisionCD]
		, tgt.[MaterialGroupCD]							= src.[MaterialGroupCD]
		, tgt.[MaterialGroupDSC]						= src.[MaterialGroupDSC]
		, tgt.[MaterialGroupLevel1CD]					= src.[MaterialGroupLevel1CD]
		, tgt.[MarketingGroupLevel1DSC]					= src.[MarketingGroupLevel1DSC]
		, tgt.[MaterialGroupLevel2CD]					= src.[MaterialGroupLevel2CD]
		, tgt.[MarketingGroupLevel2DSC]					= src.[MarketingGroupLevel2DSC]
		, tgt.[MaterialGroupLevel3CD]					= src.[MaterialGroupLevel3CD]
		, tgt.[MarketingGroupLevel3DSC]					= src.[MarketingGroupLevel3DSC]
		, tgt.[MaterialGroupLevel4CD]					= src.[MaterialGroupLevel4CD]
		, tgt.[MarketingGroupLevel4DSC]					= src.[MarketingGroupLevel4DSC]
		, tgt.[MaterialGroupLevel5CD]					= src.[MaterialGroupLevel5CD]
		, tgt.[MarketingGroupLevel5DSC]					= src.[MarketingGroupLevel5DSC]
		, tgt.[ArticleLevel1CD]							= src.[ArticleLevel1CD]
		, tgt.[ArticleLevel1DSC]						= src.[ArticleLevel1DSC]
		, tgt.[ArticleLevel2CD]							= src.[ArticleLevel2CD]
		, tgt.[ArticleLevel2DSC]						= src.[ArticleLevel2DSC]
		, tgt.[ArticleLevel3CD]							= src.[ArticleLevel3CD]
		, tgt.[ArticleLevel3DSC]						= src.[ArticleLevel3DSC]
		, tgt.[MaterialSize1CD]							= src.[MaterialSize1CD]
		, tgt.[MaterialSize2CD]							= src.[MaterialSize2CD]
		, tgt.[VendorStyle]								= src.[VendorStyle]
		, tgt.[OtsStart]								= src.[OtsStart]
		, tgt.[OtsEnd]									= src.[OtsEnd]
		, tgt.[FitTypeCD]								= src.[FitTypeCD]
		, tgt.[FitTypeDSCR]								= src.[FitTypeDSCR]
		, tgt.[Color]									= src.[Color]
		, tgt.[ColorCD]									= src.[ColorCD]
		, tgt.[ZFIBOR]  								= src.[ZFIBOR]  
		, tgt.[MaterialCategory]						= src.[MaterialCategory]
		, tgt.[GenericCD]								= src.[GenericCD]
		, tgt.[BASEUOM]  								= src.[BASEUOM]  
		, tgt.[SeasonCategoryCD]						= src.[SeasonCategoryCD]
		, tgt.[SeasonYear]								= src.[SeasonYear]
		, tgt.[BRGEW]	 								= src.[BRGEW]	 
		, tgt.[NTGEW]	 								= src.[NTGEW]	 
		, tgt.[GEWEI]	 								= src.[GEWEI]	 
		, tgt.[VOLUEH] 									= src.[VOLUEH] 
		, tgt.[VOLUM]	 								= src.[VOLUM]	 
		, tgt.[EAN11]	 								= src.[EAN11]	 
		, tgt.[NUMTP]	 								= src.[NUMTP]	 
		, tgt.[LAENG]	 								= src.[LAENG]	 
		, tgt.[BREIT]	 								= src.[BREIT]	 
		, tgt.[HOEHE]	 								= src.[HOEHE]	 
		, tgt.[MEABM]	 								= src.[MEABM]	 
		, tgt.[QuantityPerCaseNUM]						= src.[QuantityPerCaseNUM]
		, tgt.[QuantityPerPalletNUM]					= src.[QuantityPerPalletNUM]
		, tgt.[ArticleLevel4CD]							= src.[ArticleLevel4CD]
		, tgt.[ArticleLevel4DSC]						= src.[ArticleLevel4DSC]
		, tgt.[ArticleLevel5CD]							= src.[ArticleLevel5CD]
		, tgt.[ArticleLevel5DSC]						= src.[ArticleLevel5DSC]
		, tgt.[ArticleLevel6CD]							= src.[ArticleLevel6CD]
		, tgt.[ArticleLevel6DSC]						= src.[ArticleLevel6DSC]
		, tgt.[ArticleLevel7CD]							= src.[ArticleLevel7CD]
		, tgt.[ArticleLevel7DSC]						= src.[ArticleLevel7DSC]
		, tgt.[ArticleLevel8CD]							= src.[ArticleLevel8CD]
		, tgt.[ArticleLevel8DSC]						= src.[ArticleLevel8DSC]
		, tgt.[ArticleLevel9CD]							= src.[ArticleLevel9CD]
		, tgt.[ArticleLevel9DSC]						= src.[ArticleLevel9DSC]
		, tgt.[ManufacturingGroup]						= src.[ManufacturingGroup]
		, tgt.[FabricCD]								= src.[FabricCD]
		, tgt.[GenderCD]								= src.[GenderCD]
		, tgt.[ModelName]								= src.[ModelName]	
		, tgt.[FinishNM]								= src.[FinishNM]
		, tgt.[MTART]	 								= src.[MTART]	 
		, tgt.[ManufacturingGun]  						= src.[ManufacturingGun]  
		, tgt.[WashCD]									= src.[WashCD]
		, tgt.[PpelgCD]  								= src.[PpelgCD]  
		, tgt.[TieraCD]									= src.[TieraCD]		
		--, tgt.DmBeginDT									= src.DmBeginDT
		--, tgt.DmEndDT									= src.DmEndDT
		, tgt.DmActiveFLG								= src.DmActiveFLG
		, tgt.DmBatchKEY								= src.DmBatchKEY	

	WHEN NOT MATCHED THEN 

		INSERT (

			  [ProductKEY]
			, [ProductID]					
			, [ProductDSC]					
			, [DivisionCD]					
			, [MaterialGroupCD]				
			, [MaterialGroupDSC]			
			, [MaterialGroupLevel1CD]		
			, [MarketingGroupLevel1DSC]		
			, [MaterialGroupLevel2CD]		
			, [MarketingGroupLevel2DSC]		
			, [MaterialGroupLevel3CD]		
			, [MarketingGroupLevel3DSC]		
			, [MaterialGroupLevel4CD]		
			, [MarketingGroupLevel4DSC]		
			, [MaterialGroupLevel5CD]		
			, [MarketingGroupLevel5DSC]		
			, [ArticleLevel1CD]				
			, [ArticleLevel1DSC]			
			, [ArticleLevel2CD]				
			, [ArticleLevel2DSC]			
			, [ArticleLevel3CD]				
			, [ArticleLevel3DSC]			
			, [MaterialSize1CD]				
			, [MaterialSize2CD]				
			, [VendorStyle]					
			, [OtsStart]					
			, [OtsEnd]						
			, [FitTypeCD]					
			, [FitTypeDSCR]					
			, [Color]						
			, [ColorCD]						
			, [ZFIBOR]  					
			, [MaterialCategory]			
			, [GenericCD]					
			, [BASEUOM]  					
			, [SeasonCategoryCD]			
			, [SeasonYear]					
			, [BRGEW]	 					
			, [NTGEW]	 					
			, [GEWEI]	 					
			, [VOLUEH] 						
			, [VOLUM]	 					
			, [EAN11]	 					
			, [NUMTP]	 					
			, [LAENG]	 					
			, [BREIT]	 					
			, [HOEHE]	 					
			, [MEABM]	 					
			, [QuantityPerCaseNUM]			
			, [QuantityPerPalletNUM]		
			, [ArticleLevel4CD]				
			, [ArticleLevel4DSC]			
			, [ArticleLevel5CD]				
			, [ArticleLevel5DSC]			
			, [ArticleLevel6CD]				
			, [ArticleLevel6DSC]			
			, [ArticleLevel7CD]				
			, [ArticleLevel7DSC]			
			, [ArticleLevel8CD]				
			, [ArticleLevel8DSC]			
			, [ArticleLevel9CD]				
			, [ArticleLevel9DSC]			
			, [ManufacturingGroup]			
			, [FabricCD]					
			, [GenderCD]					
			, [ModelName]					
			, [FinishNM]					
			, [MTART]	 					
			, [ManufacturingGun]  			
			, [WashCD]						
			, [PpelgCD]  					
			, [TieraCD]						
			--, DmBeginDT						
			--, DmEndDT						
			, DmActiveFLG					
			, DmBatchKEY					

		) VALUES (
		
			  src.[ProductKEY]
			, src.[ProductID]				
			, src.[ProductDSC]
			, src.[DivisionCD]
			, src.[MaterialGroupCD]
			, src.[MaterialGroupDSC]
			, src.[MaterialGroupLevel1CD]
			, src.[MarketingGroupLevel1DSC]
			, src.[MaterialGroupLevel2CD]
			, src.[MarketingGroupLevel2DSC]
			, src.[MaterialGroupLevel3CD]
			, src.[MarketingGroupLevel3DSC]
			, src.[MaterialGroupLevel4CD]
			, src.[MarketingGroupLevel4DSC]
			, src.[MaterialGroupLevel5CD]
			, src.[MarketingGroupLevel5DSC]
			, src.[ArticleLevel1CD]
			, src.[ArticleLevel1DSC]
			, src.[ArticleLevel2CD]
			, src.[ArticleLevel2DSC]
			, src.[ArticleLevel3CD]
			, src.[ArticleLevel3DSC]
			, src.[MaterialSize1CD]
			, src.[MaterialSize2CD]
			, src.[VendorStyle]
			, src.[OtsStart]
			, src.[OtsEnd]
			, src.[FitTypeCD]
			, src.[FitTypeDSCR]
			, src.[Color]
			, src.[ColorCD]
			, src.[ZFIBOR]  
			, src.[MaterialCategory]
			, src.[GenericCD]
			, src.[BASEUOM]  
			, src.[SeasonCategoryCD]
			, src.[SeasonYear]
			, src.[BRGEW]	 
			, src.[NTGEW]	 
			, src.[GEWEI]	 
			, src.[VOLUEH] 
			, src.[VOLUM]	 
			, src.[EAN11]	 
			, src.[NUMTP]	 
			, src.[LAENG]	 
			, src.[BREIT]	 
			, src.[HOEHE]	 
			, src.[MEABM]	 
			, src.[QuantityPerCaseNUM]
			, src.[QuantityPerPalletNUM]
			, src.[ArticleLevel4CD]
			, src.[ArticleLevel4DSC]
			, src.[ArticleLevel5CD]
			, src.[ArticleLevel5DSC]
			, src.[ArticleLevel6CD]
			, src.[ArticleLevel6DSC]
			, src.[ArticleLevel7CD]
			, src.[ArticleLevel7DSC]
			, src.[ArticleLevel8CD]
			, src.[ArticleLevel8DSC]
			, src.[ArticleLevel9CD]
			, src.[ArticleLevel9DSC]
			, src.[ManufacturingGroup]
			, src.[FabricCD]
			, src.[GenderCD]
			, src.[ModelName]	
			, src.[FinishNM]
			, src.[MTART]	 
			, src.[ManufacturingGun]  
			, src.[WashCD]
			, src.[PpelgCD]  
			, src.[TieraCD]		
			--, src.DmBeginDT
			--, src.DmEndDT
			, src.DmActiveFLG
			, src.DmBatchKEY	
		);

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
