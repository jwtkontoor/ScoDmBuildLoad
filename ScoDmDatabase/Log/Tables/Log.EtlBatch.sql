CREATE TABLE [Log].[EtlBatch]
(

      [BatchKEY]			INT 					NOT NULL		IDENTITY (1, 1)
	, [BatchTypeDSC]		VARCHAR(255)			NULL
	, [BatchStartDT]		DATETIME				NOT NULL		DEFAULT (GETDATE()) 
	, [BatchEndDT]			DATETIME				NULL
    , [BatchResult]			VARCHAR(255)			NULL 

	, CONSTRAINT [PK_LogEtlBatch_BatchKEY] PRIMARY KEY CLUSTERED ([BatchKEY] ASC)
)