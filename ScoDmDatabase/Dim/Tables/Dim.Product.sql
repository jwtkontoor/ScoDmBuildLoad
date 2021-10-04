/*******************************************************************************/
/**  
	Customer Dim Table 
	Created By: JWT					Created On: 7/26/21


**/
/*******************************************************************************/

CREATE TABLE [Dim].[Product]
(
	[ProductKEY]					INT				NOT NULL
	, [ProductID]					INT				NOT NULL	
	, [ProductDSC]					VARCHAR(255)	NULL
	, [DivisionCD]					VARCHAR(255)	NULL
	, [MaterialGroupCD]				VARCHAR(255)	NULL
	, [MaterialGroupDSC]			VARCHAR(255)	NULL
	, [MaterialGroupLevel1CD]		VARCHAR(255)	NULL
	, [MarketingGroupLevel1DSC]		VARCHAR(255)	NULL
	, [MaterialGroupLevel2CD]		VARCHAR(255)	NULL
	, [MarketingGroupLevel2DSC]		VARCHAR(255)	NULL
	, [MaterialGroupLevel3CD]		VARCHAR(255)	NULL
	, [MarketingGroupLevel3DSC]		VARCHAR(255)	NULL
	, [MaterialGroupLevel4CD]		VARCHAR(255)	NULL
	, [MarketingGroupLevel4DSC]		VARCHAR(255)	NULL
	, [MaterialGroupLevel5CD]		VARCHAR(255)	NULL
	, [MarketingGroupLevel5DSC]		VARCHAR(255)	NULL
	, [ArticleLevel1CD]				VARCHAR(255)	NULL
	, [ArticleLevel1DSC]			VARCHAR(255)	NULL
	, [ArticleLevel2CD]				VARCHAR(255)	NULL
	, [ArticleLevel2DSC]			VARCHAR(255)	NULL
	, [ArticleLevel3CD]				VARCHAR(255)	NULL
	, [ArticleLevel3DSC]			VARCHAR(255)	NULL
	, [MaterialSize1CD]				VARCHAR(255)	NULL
	, [MaterialSize2CD]				VARCHAR(255)	NULL
	, [VendorStyle]					VARCHAR(255)	NULL
	, [OtsStart]					DATETIME		NULL
	, [OtsEnd]						DATETIME		NULL
	, [FitTypeCD]					VARCHAR(255)	NULL
	, [FitTypeDSCR]					VARCHAR(255)	NULL
	, [Color]						VARCHAR(255)	NULL
	, [ColorCD]						VARCHAR(255)	NULL
	, [ZFIBOR]   					VARCHAR(255)	NULL
	, [MaterialCategory]			VARCHAR(255)	NULL
	, [GenericCD]					VARCHAR(255)	NULL
	, [BASEUOM]  					VARCHAR(255)	NULL
	, [SeasonCategoryCD]			VARCHAR(255)	NULL
	, [SeasonYear]					VARCHAR(255)	NULL
	, [BRGEW]						VARCHAR(255)	NULL
	, [NTGEW]	 					VARCHAR(255)	NULL
	, [GEWEI]	 					VARCHAR(255)	NULL
	, [VOLUEH]	 					VARCHAR(255)	NULL
	, [VOLUM]	 					VARCHAR(255)	NULL
	, [EAN11]	 					VARCHAR(255)	NULL
	, [NUMTP]	 					VARCHAR(255)	NULL
	, [LAENG]	 					VARCHAR(255)	NULL
	, [BREIT]	 					VARCHAR(255)	NULL
	, [HOEHE]	 					VARCHAR(255)	NULL
	, [MEABM]	 					VARCHAR(255)	NULL
	, [QuantityPerCaseNUM]			VARCHAR(255)	NULL
	, [QuantityPerPalletNUM]		VARCHAR(255)	NULL
	, [ArticleLevel4CD]				VARCHAR(255)	NULL
	, [ArticleLevel4DSC]			VARCHAR(255)	NULL
	, [ArticleLevel5CD]				VARCHAR(255)	NULL
	, [ArticleLevel5DSC]			VARCHAR(255)	NULL
	, [ArticleLevel6CD]				VARCHAR(255)	NULL
	, [ArticleLevel6DSC]			VARCHAR(255)	NULL
	, [ArticleLevel7CD]				VARCHAR(255)	NULL
	, [ArticleLevel7DSC]			VARCHAR(255)	NULL
	, [ArticleLevel8CD]				VARCHAR(255)	NULL
	, [ArticleLevel8DSC]			VARCHAR(255)	NULL
	, [ArticleLevel9CD]				VARCHAR(255)	NULL
	, [ArticleLevel9DSC]			VARCHAR(255)	NULL
	, [ManufacturingGroup]			VARCHAR(255)	NULL
	, [FabricCD]					VARCHAR(255)	NULL
	, [GenderCD]					VARCHAR(255)	NULL
	, [ModelName]					VARCHAR(255)	NULL
	, [FinishNM]					VARCHAR(255)	NULL
	, [MTART]	 					VARCHAR(255)	NULL
	, [ManufacturingGun] 			VARCHAR(255)	NULL
	, [WashCD]						VARCHAR(255)	NULL
	, [PpelgCD] 					VARCHAR(255)	NULL
	, [TieraCD]						INT				NULL
	, [DmBeginDate]					DATETIME		NOT NULL	DEFAULT ('01-01-1900')
	, [DmEndDate]					DATETIME		NOT NULL	DEFAULT ('12-31-2399')
	, [DmActiveFLG]					VARCHAR(255)	NOT NULL	DEFAULT ('Y')
	, [DmBatchKEY]					INT				NOT NULL	DEFAULT -1
	

    , CONSTRAINT [PK_Dim_Product_ProductKEY] PRIMARY KEY CLUSTERED ([ProductKEY] ASC)
);

GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Dim_Product_ProductKEY]
    ON [Dim].[Product]([ProductKEY] ASC);