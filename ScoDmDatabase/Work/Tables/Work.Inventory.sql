/*******************************************************************************/
/**  
	Working Fact Table 
	Created By: JWT					Created On: 7/26/21

	Used for loading the Inventory Fact table.  See Inventory Fact for details.

**/
/*******************************************************************************/

CREATE TABLE [Work].[Inventory]
(
	--Primary Key - natural and surrogate
	[InventoryKEY]			INT			NOT NULL		IDENTITY (1,1) 
	, [InventoryId]			INT			NOT NULL 

	--Foreign Keys  - natural and surrogate  
	, [CustomerId]			INT			NOT NULL		
	, [CustomerKEY]			INT			NOT NULL		
	
	-- Data Mart Logging
	, [DmBatchKEY]			INT					NOT NULL		DEFAULT(-1)
	, [DmCreateDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]		DATETIME			NOT NULL		DEFAULT(GETDATE()) 

	--Table Constraints PK First then Forign Keys
	, CONSTRAINT [PK_Work_Inventory_InventoryId] PRIMARY KEY CLUSTERED ([InventoryKEY] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Work_Inventory_InventoryId] ON [Work].[Inventory] (InventoryId ASC)
GO
