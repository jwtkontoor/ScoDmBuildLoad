
CREATE PROCEDURE [Log].[EtlError_Create]
	
	@BatchKEY			INT
	, @ErrorMessage		VARCHAR(MAX)

AS

	INSERT INTO Log.EtlError (

		BatchKEY
		, ErrorMessage

	) VALUES (

		@BatchKEY
		, @ErrorMessage

	);

RETURN 1;