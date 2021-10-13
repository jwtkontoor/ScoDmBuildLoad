CREATE TABLE [Log].[EtlProcess]
(
	[EtlProcessKEY]				INT				NOT NULL		IDENTITY (1,1)
	, [BatchKEY]				INT				NOT NULL
	, [ProcessStartDT]			DATETIME		NOT NULL		DEFAULT (GETDATE()) 
	, [ProcessEndDT]			DATETIME		NULL
	, [RowsInserted]			INT				NULL
	, [RowsUpdated]				INT				NULL 
	, [ProcessNM]				VARCHAR(255)	NULL 
	, [Result]					VARCHAR(255)	NULL

	, CONSTRAINT [PK_LogEtlProcess_EtlProcessKEY] PRIMARY KEY CLUSTERED ([EtlProcessKEY] ASC )
);
