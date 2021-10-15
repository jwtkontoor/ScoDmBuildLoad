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
	, [District]           					VARCHAR(50)			NULL	
	, [KeyAccountCD]				VARCHAR(50)			NOT NULL 
	, [OpenedOnDTS]					DATETIME			NULL
	, [PlantCategoryCD]				VARCHAR(50)			NOT NULL
	, [Region]  					VARCHAR(50)			NULL
	, [SiteDESC]					VARCHAR(255)		NULL      
	, [SellAreaCD]  				VARCHAR(50)			NULL          	
	, [SellAreaUnit]				VARCHAR(50)			NULL  
	, [StoreId]						INT					NOT NULL 
	, [StoreNM]						VARCHAR(50)			NULL	
	
	, CONSTRAINT [PK_Mcr_CustomerStore_CustomerStoreKEY] PRIMARY KEY CLUSTERED (CustomerStoreKEY ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Mcr_Customer_CustomerId] ON [Mcr].[CustomerStore] (CustomerId ASC)