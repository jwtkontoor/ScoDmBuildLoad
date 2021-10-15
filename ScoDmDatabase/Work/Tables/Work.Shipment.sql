/*******************************************************************************/
/**  
	Working Fact Table 
	Created By: JWT					Created On: 7/26/21

	Used for loading the Shipment Fact table.  See Shipment Fact for details.

**/
/*******************************************************************************/

CREATE TABLE [Work].[Shipment]
(
	--Primary Key - natural and surrogate
	[ShipmentKEY]			INT			NOT NULL		IDENTITY (1,1) 
	, [ShipmentId]			INT			NOT NULL 

	--Foreign Keys  - natural and surrogate  
	, [CustomerId]			INT			NOT NULL		
	, [CustomerKEY]			INT			NOT NULL		
	
	-- Data Mart Logging
	, [DmBatchKEY]			INT					NOT NULL		DEFAULT(-1)
	, [DmCreateDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]		DATETIME			NOT NULL		DEFAULT(GETDATE()) 

	--Table Constraints PK First then Forign Keys
	, CONSTRAINT [PK_Work_Shipment_ShipmentId] PRIMARY KEY CLUSTERED ([ShipmentKEY] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Work_Shipment_ShipmentId] ON [Work].[Shipment] (ShipmentId ASC)
GO
