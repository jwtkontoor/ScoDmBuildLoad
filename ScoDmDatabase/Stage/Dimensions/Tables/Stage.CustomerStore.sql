CREATE TABLE [Stage].[CustomerStore]
(
    --Business Key
    [RetailSite]                    VARCHAR(40)             NOT NULL 

	--Descriptors
      ,[KeyAccount]                 VARCHAR(40)             NOT NULL  
      ,[PlantCategory]              VARCHAR(40)             NOT NULL 
      ,[SiteDescription]            VARCHAR(40)             NOT NULL 
      ,[Region]                     VARCHAR(40)             NOT NULL 
      ,[Country]                    VARCHAR(40)             NOT NULL 
      ,[City]                       VARCHAR(40)             NOT NULL 
      ,[District]                   VARCHAR(40)             NOT NULL 
      ,[OpenedOnDTS]                VARCHAR(40)             NOT NULL 
      ,[ClosedOnDTS]                VARCHAR(40)             NOT NULL 
      ,[SellArea]                   VARCHAR(40)             NOT NULL 
      ,[SellAreaUnit]               VARCHAR(40)             NOT NULL 
)

GO
