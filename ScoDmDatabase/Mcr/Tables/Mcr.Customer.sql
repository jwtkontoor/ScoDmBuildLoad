CREATE TABLE [Mcr].[Customer]
(
	[CustomerKEY]			INT			NOT NULL			IDENTITY (1,1)  
	, [CustomerId]			INT			NOT NULL  
	, CONSTRAINT [PK_Mcr_Customer_CustomerKEY] PRIMARY KEY CLUSTERED (CustomerKEY ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Mcr_Customer_CustomerId] ON [Mcr].[Customer] (CustomerId ASC)