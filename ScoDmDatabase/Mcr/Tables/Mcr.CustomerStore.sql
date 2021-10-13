CREATE TABLE [Mcr].[CustomerStore]
(
	[CustomerStoreKEY]			INT					NOT NULL			IDENTITY (1,1) 
	
	--Information Columns
	, [CustomerNM]				VARCHAR(50)			NULL				
	, [CustomerId]				INT					NOT NULL  
	, [StoreNM]					VARCHAR(50)			NULL				
	, [StoreId]					INT					NOT NULL  
	
	
	, CONSTRAINT [PK_Mcr_CustomerStore_CustomerStoreKEY] PRIMARY KEY CLUSTERED (CustomerStoreKEY ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Mcr_Customer_CustomerId] ON [Mcr].[CustomerStore] (CustomerId ASC)