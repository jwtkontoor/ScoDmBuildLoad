CREATE PROCEDURE [Dim].[Product_Merge]

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

	MERGE INTO Dim.Product tgt

	USING ( 

		SELECT 
		  a.[ProductKEY]	
		, a.[ProductID]		
		, a.[ProductDSC]
		, a.[DivisionCD]
		, a.[MaterialGroupCD]
		, a.[MaterialGroupDSC]
		, a.[MaterialGroupLevel1CD]
		, a.[MarketingGroupLevel1DSC]
		, a.[MaterialGroupLevel2CD]
		, a.[MarketingGroupLevel2DSC]
		, a.[MaterialGroupLevel3CD]
		, a.[MarketingGroupLevel3DSC]
		, a.[MaterialGroupLevel4CD]
		, a.[MarketingGroupLevel4DSC]
		, a.[MaterialGroupLevel5CD]
		, a.[MarketingGroupLevel5DSC]
		, a.[ArticleLevel1CD]
		, a.[ArticleLevel1DSC]
		, a.[ArticleLevel2CD]
		, a.[ArticleLevel2DSC]
		, a.[ArticleLevel3CD]
		, a.[ArticleLevel3DSC]
		, a.[MaterialSize1CD]
		, a.[MaterialSize2CD]
		, a.[VendorStyle]
		, a.[OtsStart]
		, a.[OtsEnd]
		, a.[FitTypeCD]
		, a.[FitTypeDSCR]
		, a.[Color]
		, a.[ColorCD]
		, a.[ZFIBOR]  
		, a.[MaterialCategory]
		, a.[GenericCD]
		, a.[BASEUOM]  
		, a.[SeasonCategoryCD]
		, a.[SeasonYear]
		, a.[BRGEW]	 
		, a.[NTGEW]	 
		, a.[GEWEI]	 
		, a.[VOLUEH] 
		, a.[VOLUM]	 
		, a.[EAN11]	 
		, a.[NUMTP]	 
		, a.[LAENG]	 
		, a.[BREIT]	 
		, a.[HOEHE]	 
		, a.[MEABM]	 
		, a.[QuantityPerCaseNUM]
		, a.[QuantityPerPalletNUM]
		, a.[ArticleLevel4CD]
		, a.[ArticleLevel4DSC]
		, a.[ArticleLevel5CD]
		, a.[ArticleLevel5DSC]
		, a.[ArticleLevel6CD]
		, a.[ArticleLevel6DSC]
		, a.[ArticleLevel7CD]
		, a.[ArticleLevel7DSC]
		, a.[ArticleLevel8CD]
		, a.[ArticleLevel8DSC]
		, a.[ArticleLevel9CD]
		, a.[ArticleLevel9DSC]
		, a.[ManufacturingGroup]
		, a.[FabricCD]
		, a.[GenderCD]
		, a.[ModelName]	
		, a.[FinishNM]
		, a.[MTART]	 
		, a.[ManufacturingGun]  
		, a.[WashCD]
		, a.[PpelgCD]  
		, a.[TieraCD]		
		--, a.DmBeginDT
		--, a.DmEndDT
		, a.DmActiveFLG
		, a.DmBatchKEY	
		FROM
			Mcr.Product a

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

