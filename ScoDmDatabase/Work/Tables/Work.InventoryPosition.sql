/*******************************************************************************/
/**  
	Working Fact Table 
	Created By: JWT					Created On: 7/26/21

	Used for loading the InventoryPosition Fact table.  See InventoryPosition Fact for details.

**/
/*******************************************************************************/

CREATE TABLE [Work].[InventoryPosition]
(
	--Primary Key - natural and surrogate
	[InventoryPositionKEY]			INT			NOT NULL		IDENTITY (1,1) 
	, [InventoryPositionId]			INT			NOT NULL 

	--Foreign Keys  - natural and surrogate  
	, [CustomerId]			INT			NOT NULL		
	, [CustomerKEY]			INT			NOT NULL		
	
	-- Data Mart Logging
	, [DmBatchKEY]			INT					NOT NULL		DEFAULT(-1)
	, [DmCreateDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]		DATETIME			NOT NULL		DEFAULT(GETDATE()) 

	--Table Constraints PK First then Forign Keys
	, CONSTRAINT [PK_Work_InventoryPosition_InventoryPositionId] PRIMARY KEY CLUSTERED ([InventoryPositionKEY] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Work_InventoryPosition_InventoryPositionId] ON [Work].[InventoryPosition] (InventoryPositionId ASC)
GO
