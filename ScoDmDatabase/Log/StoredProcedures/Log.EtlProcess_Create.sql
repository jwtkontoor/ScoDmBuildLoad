
CREATE PROCEDURE [Log].[EtlProcess_Create]

	@BatchKEY			INT
	, @ProcessStartDT	DATETIME
	, @ProcessEndDT		DATETIME
	, @RowsInserted		VARCHAR(255)
	, @RowsUpdated		VARCHAR(255)
	, @ProcessNM		VARCHAR(255)
	, @Result			VARCHAR(255)

AS

	INSERT INTO Log.EtlProcess (

		[BatchKEY]     
		, [ProcessStartDT]
		, [ProcessEndDT]  
		, [RowsInserted]  
		, [RowsUpdated]   
		, [ProcessNM]     
		, [Result]         

	) VALUES (

		@BatchKEY		
		, @ProcessStartDT	
		, @ProcessEndDT		
		, @RowsInserted		
		, @RowsUpdated		
		, @ProcessNM		
		, @Result		
	);

RETURN 1;