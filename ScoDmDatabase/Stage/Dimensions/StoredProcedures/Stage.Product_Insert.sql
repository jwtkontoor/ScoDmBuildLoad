CREATE PROCEDURE [Stage].[Product_Insert]

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
	
	TRUNCATE TABLE Stage.Product; 

	WITH SapProduct AS 
	(
		SELECT 
			  [MATNR]								AS [ProductID]	
			, [MATDESC]								AS [ProductDSC]
			, [DIVISION]							AS [DivisionCD]
			, [MATGROUP]							AS [MaterialGroupCD]
			, [MATGROUPTXT]							AS [MaterialGroupDSC]
			, [MATGROUP_L1]							AS [MaterialGroupLevel1CD]
			, [MARGROUPTXT_L1]						AS [MarketingGroupLevel1DSC]
			, [MATGROUP_L2]							AS [MaterialGroupLevel2CD]
			, [MARGROUPTXT_L2]						AS [MarketingGroupLevel2DSC]
			, [MATGROUP_L3]							AS [MaterialGroupLevel3CD]
			, [MARGROUPTXT_L3]						AS [MarketingGroupLevel3DSC]
			, [MATGROUP_L4]							AS [MaterialGroupLevel4CD]
			, [MARGROUPTXT_L4]						AS [MarketingGroupLevel4DSC]
			, [MATGROUP_L5]							AS [MaterialGroupLevel5CD]
			, [MARGROUPTXT_L5]						AS [MarketingGroupLevel5DSC]
			, [ARTICLE_L1]							AS [ArticleLevel1CD]
			, [ARTICLETXT_L1]						AS [ArticleLevel1DSC]
			, [ARTICLE_L2]							AS [ArticleLevel2CD]
			, [ARTICLETXT_L2]						AS [ArticleLevel2DSC]
			, [ARTICLE_L3]							AS [ArticleLevel3CD]
			, [ARTICLETXT_L3]						AS [ArticleLevel3DSC]
			, [MATSIZE1]							AS [MaterialSize1CD]
			, [MATSIZE2] 							AS [MaterialSize2CD]
			, [VENDSTYLE]							AS [VendorStyle]
			, [OTS_START]							AS [OtsStart]
			, [OTS_END]								AS [OtsEnd]
			, [ZFITPR]								AS [FitTypeCD]
			, [ZFITDESC]							AS [FitTypeDSCR]
			, [COLOR]								AS [Color]
			, [NRFCOLOR]							AS [ColorCD]
			, [ZFIBOR]								AS [ZFIBOR]  --Do Not have translations for these columns
			, [MATCATEGORY]							AS [MaterialCategory]
			, [GENERIC]								AS [GenericCD]
			, [BASEUOM]  							AS [BASEUOM]  --Do Not have translations for these columns
			, [SEASONCAT]							AS [SeasonCategoryCD]
			, [SEASONYEAR]							AS [SeasonYear]
			, [BRGEW]								AS [BRGEW]	--Do Not have translations for these columns
			, [NTGEW]								AS [NTGEW]	--Do Not have translations for these columns
			, [GEWEI]								AS [GEWEI]	--Do Not have translations for these columns
			, [VOLUEH]								AS [VOLUEH]	--Do Not have translations for these columns
			, [VOLUM]								AS [VOLUM]	--Do Not have translations for these columns
			, [EAN11]								AS [EAN11]	--Do Not have translations for these columns
			, [NUMTP]								AS [NUMTP]	--Do Not have translations for these columns
			, [LAENG]								AS [LAENG]	--Do Not have translations for these columns
			, [BREIT]								AS [BREIT]	--Do Not have translations for these columns
			, [HOEHE]								AS [HOEHE]	--Do Not have translations for these columns
			, [MEABM]								AS [MEABM]	--Do Not have translations for these columns
			, [QTYCASE]								AS [QuantityPerCaseNUM]
			, [QTYPALLET]							AS [QuantityPerPalletNUM]
			, [ARTICLE_L4]							AS [ArticleLevel4CD]
			, [ARTICLETXT_L4]						AS [ArticleLevel4DSC]
			, [ARTICLE_L5]							AS [ArticleLevel5CD]
			, [ARTICLETXT_L5]						AS [ArticleLevel5DSC]
			, [ARTICLE_L6]							AS [ArticleLevel6CD]
			, [ARTICLETXT_L6]						AS [ArticleLevel6DSC]
			, [ARTICLE_L7]							AS [ArticleLevel7CD]
			, [ARTICLETXT_L7]						AS [ArticleLevel7DSC]
			, [ARTICLE_L8]							AS [ArticleLevel8CD]
			, [ARTICLETXT_L8]						AS [ArticleLevel8DSC]
			, [ARTICLE_L9]							AS [ArticleLevel9CD]
			, [ARTICLETXT_L9]						AS [ArticleLevel9DSC]
			, [MANUFGROUP]							AS [ManufacturingGroup]
			, [FABRICCODE]							AS [FabricCD]
			, [GENDERCODE]							AS [GenderCD]
			, [MODELNAME]							AS [ModelName]	
			, [FINISHNAME]							AS [FinishNM]
			, [MTART]								AS [MTART]	--Do Not have translations for these columns
			, [ZZMFGUN]								AS [ManufacturingGun] --Name needs Checking
			, [ZZWASHC]								AS [WashCD]
			, [ZZPPELG]								AS [PpelgCD] --Name needs Checking
			, [ZZTIERA]								AS [TieraCD]	
			, GETDATE()								AS [DmStartDate]
			, @BatchKEY								AS [DmBatchKEY]		
		FROM [WW_DB_LOGILITY_PRD].[dbo].[SAP_MD_MARA] 
	)

	INSERT INTO Stage.Product ( 

		[ProductID]		
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
		, [DmBeginDate]		
		, [DmEndDate]		
		, [DmActiveFLG]		
		, [DmBatchKEY]		
		--, [DmCrcVAL]		

	) 
	SELECT 
	
		
		a.[ProductID]		
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
		, a.[DmBeginDate]		
		, a.[DmEndDate]		
		, a.[DmActiveFLG]		
		, a.[DmBatchKEY]	
		--, BINARY_CHECKSUM ('Test') AS [DmCrcVAL]
		
	FROM 
		SapProduct a; 

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

