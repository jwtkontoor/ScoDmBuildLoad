CREATE TABLE [Stage].[CustomerStore]
(
    --Business Key
    [RetailSiteID]                    VARCHAR(40)             NOT NULL 

	--Descriptors
      , [KeyAccountCD]              VARCHAR(40)             NOT NULL  
	  , [SoldToCustomerID]          VARCHAR(40)             NULL 
	  , [SoldToDESC]                VARCHAR(40)             NULL 
      , [ShipToCustomerID]		    VARCHAR(40)             NULL 
      , [ShipToDESC]                VARCHAR(40)             NULL 
      , [PlantTypeCD]                VARCHAR(40)             NULL 
      ,[PlantCategoryCD]              VARCHAR(40)             NULL 
      ,[SiteDESC]                   VARCHAR(40)             NULL 
      ,[Region]                     VARCHAR(40)             NULL 
      ,[Country]                    VARCHAR(40)             NULL 
      ,[City]                       VARCHAR(40)             NULL 
      ,[District]                   VARCHAR(40)             NULL 
      ,[OpenedOnDTS]                VARCHAR(40)             NULL 
      ,[ClosedOnDTS]                VARCHAR(40)             NULL 
      ,[SellAreaCD]                   VARCHAR(40)             NULL 
      ,[SellAreaUnit]               VARCHAR(40)             NULL 
)

GO
