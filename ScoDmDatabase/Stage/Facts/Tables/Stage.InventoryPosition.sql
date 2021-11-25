CREATE TABLE [Stage].[InventoryPosition]
(
	  [Material]				VARCHAR(255)		NOT NULL	
	, [HeaderUniqueID]			VARCHAR(255)		NULL
	, [EdiDetailId]				VARCHAR(255)		NULL
	, [MaterialNUM]				VARCHAR(255)		NULL
	, [ActivityCD]				VARCHAR(255)		NULL
	, [LegacyMaterialNUM]		VARCHAR(255)		NULL		
	, [UniversalProductCD]		VARCHAR(255)		NOT NULL
	, [UnitOfMeasure]			VARCHAR(255)		NULL
	, [ItemDTS]					VARCHAR(255)		NULL
	, [ItemNUM]					VARCHAR(255)		NULL
	, [QuantityAMT]				VARCHAR(255)		NULL
	, [ItemPrice]				DATE				NULL
	, [ItemQualifierCD]			INT					NULL
	, [ObjectNUM]				VARCHAR(255)		NULL
	, [Katr7]					VARCHAR(255)		NULL
	, [DocumentDTS]				VARCHAR(255)		NULL
	, [LegacyStoreNUM]			INT			NULL
	, [InternalNUM] 			INT			NULL
	, [RefDoc]					INT			NULL
	, [DocNUM]					INT			NULL
	, [PosNUM]					VARCHAR(255)	NULL
	, [PartnerID]				VARCHAR(255)	NULL
	, [SoldTo]					VARCHAR(255)	NULL
	, [LegacySoldTo]			VARCHAR(255)	NULL
	, [JurisdictionCD]			VARCHAR(255)			NULL
	, [NameText]				INT			NULL
	, [EdiFileSentDTS]			DATE			NULL
	, [EdiFileStartDTS]			INT			NULL
	, [EdiFileEndDTS]
