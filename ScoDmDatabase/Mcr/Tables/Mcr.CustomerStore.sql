CREATE TABLE [Mcr].[CustomerStore]
(
	--Surrogate Key
	[CustomerStoreKEY]				INT					NOT NULL			IDENTITY (1,1) 
	
	--Business Key(s) 
	, [RetailSiteID]				VARCHAR(50)			NULL	

	--Information Columns - Keep in aplha order 
	, [City]               			VARCHAR(50)			NULL	
	, [ClosedOnDTS]					DATETIME			NULL
	, [Country]						VARCHAR(50)			NULL	   
	, [CustomerId]					INT					NULL  
	, [CustomerNM]					VARCHAR(50)			NULL	
	, [District]           			VARCHAR(50)			NULL	
	, [KeyAccountCD]				VARCHAR(50)			NOT NULL 
	, [OpenedOnDTS]					DATETIME			NULL
	, [PlantCategoryCD]				VARCHAR(50)			NOT NULL
    , [PlantTypeCD]					VARCHAR(40)         NULL 
	, [Region]  					VARCHAR(50)			NULL   
	, [SellAreaCD]  				VARCHAR(50)			NULL          	
	, [SellAreaUnit]				VARCHAR(50)			NULL  
    , [ShipToCustomerID]		    VARCHAR(40)         NULL 
    , [ShipToDESC]					VARCHAR(40)			NULL 
	, [SiteDESC]					VARCHAR(255)		NULL    
	, [SoldToCustomerID]			VARCHAR(40)         NULL 
	, [SoldToDESC]					VARCHAR(40)         NULL
	, [StoreId]						INT					NOT NULL 
	, [StoreNM]						VARCHAR(50)			NULL	

	--Change Tracking Columns
	, [HasChangedFLG]					INT					NOT NULL				DEFAULT(0)
	, [IsCurrentFLG]					INT					NOT NULL				DEFAULT(1)
	, [DmValidToDTS]					DATETIME			NOT NULL				DEFAULT('12/31/2299')
	, [DmValidFromDTS]					DATETIME			NOT NULL				DEFAULT(GETDATE())
	
	, CONSTRAINT [PK_Mcr_CustomerStore_CustomerStoreKEY] PRIMARY KEY CLUSTERED (CustomerStoreKEY ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Mcr_Customer_CustomerId] ON [Mcr].[CustomerStore] (CustomerId ASC)