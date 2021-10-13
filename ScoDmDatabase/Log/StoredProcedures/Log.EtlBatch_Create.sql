CREATE PROCEDURE [Log].[EtlBatch_Create]
	
	@BatchTypeDSC VARCHAR(255)
	, @BatchKEY int OUTPUT

AS

	INSERT INTO Log.EtlBatch (

		BatchStartDT
		, BatchResult
		, BatchTypeDSC

	) VALUES (

		GETDATE()
		, 'In Progress'
		, @BatchTypeDSC
	);

	SET @BatchKEY = @@IDentity;

RETURN 1;


