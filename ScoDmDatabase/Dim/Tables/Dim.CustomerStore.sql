/*******************************************************************************/
/**  
	CustomerStore Dim Table 
	Created By: JWT					Created On: 7/26/21

	Used for loading the Inventory Fact table.  See Inventory Fact for details.

**/
/*******************************************************************************/


CREATE TABLE [Dim].[CustomerStore]
(
    
	--Surrogate (Primary) Key
	[CustomerStoreKEY]			INT					NOT NULL		
    
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

    --Logging Fields
	, [DmActiveFLG]			VARCHAR (255)		NOT NULL		DEFAULT('Y')
	, [DmBeginDTS]			DATETIME			NOT NULL		DEFAULT('01/01/1900')
	, [DmEndDTS]			DATETIME			NOT NULL		DEFAULT('12/31/2299')
	, [DmBatchKEY]			INT					NOT NULL		DEFAULT(-1)

    --Update And Change Fields
	, [DmCreateDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
    
	--Table Constraints PK First then Foerign Keys 
	, CONSTRAINT [PK_Dim_CustomerStore_CustomerStoreKEY] PRIMARY KEY CLUSTERED ([CustomerStoreKEY] ASC) 
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Is the record currently active? (Y/N)',
    @level0type = N'SCHEMA',
    @level0name = N'Dim',
    @level1type = N'TABLE',
    @level1name = N'CustomerStore',
    @level2type = N'COLUMN',
    @level2name = N'DmActiveFLG'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Mart generated CustomerStore Surrogate Key',
    @level0type = N'SCHEMA',
    @level0name = N'Dim',
    @level1type = N'TABLE',
    @level1name = N'CustomerStore',
    @level2type = N'COLUMN',
    @level2name = N'CustomerStoreKEY'