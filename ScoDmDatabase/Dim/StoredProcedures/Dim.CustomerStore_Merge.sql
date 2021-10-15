CREATE PROCEDURE [Dim].[CustomerStore_Merge]

	@BatchKEY AS INT = -1

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

	MERGE INTO Dim.CustomerStore tgt

	USING ( 

		SELECT 
			  a.[CustomerStoreKEY]	
			, a.[RetailSiteID]  
			, a.[CustomerId]
			, a.[KeyAccountCD]                  
			, a.[PlantCategoryCD]              
			, a.[SiteDESC]            
			, a.[Region]                     
			, a.[Country]                    
			, a.[City]                       
			, a.[District]                   
			, a.[OpenedOnDTS]                
			, a.[ClosedOnDTS]                
			, a.[SellAreaCD]                   
			, a.[SellAreaUnit]        
			--, a.DmBeginDT
			--, a.DmEndDT
			, @BatchKey  AS DmBatchKEY	
		FROM
			Mcr.CustomerStore a

	) src 

	ON ( 

		tgt.CustomerStoreKEY = src.CustomerStoreKEY
	)

	WHEN MATCHED THEN 

		UPDATE SET

		  tgt.[RetailSiteID]   						= src.[RetailSiteID]   
		, tgt.[KeyAccountCD]                  		= src.[KeyAccountCD]                  
		, tgt.[PlantCategoryCD]              		= src.[PlantCategoryCD]              
		, tgt.[SiteDESC]            				= src.[SiteDESC]            
		, tgt.[Region]                     			= src.[Region]                     
		, tgt.[Country]                    			= src.[Country]                    
		, tgt.[City]                       			= src.[City]                       
		, tgt.[District]                   			= src.[District]                   
		, tgt.[OpenedOnDTS]                			= src.[OpenedOnDTS]                
		, tgt.[ClosedOnDTS]                			= src.[ClosedOnDTS]                
		, tgt.[SellArea]                   			= src.[SellArea]                   
		, tgt.[SellAreaUnit]        				= src.[SellAreaUnit]        
		, tgt.DmActiveFLG							= src.DmActiveFLG
		, tgt.DmBatchKEY							= src.DmBatchKEY	

	WHEN NOT MATCHED THEN 

		INSERT (

			  [CustomerStoreKEY]
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

