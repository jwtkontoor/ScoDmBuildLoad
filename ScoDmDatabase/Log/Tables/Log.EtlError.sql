CREATE TABLE [Log].[EtlError]
(

	  [EtlErrorKEY]		INT						NOT NULL	IDENTITY (1, 1) 
    , [BatchKEY]		INT						NOT NULL
    , [ErrorDT]			DATETIME				NOT NULL	DEFAULT (GETDATE()) 
	, [ErrorMessage]	VARCHAR(MAX)			NOT NULL
);