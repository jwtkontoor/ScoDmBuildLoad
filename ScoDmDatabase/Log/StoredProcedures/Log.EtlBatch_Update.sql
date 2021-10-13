CREATE PROCEDURE [Log].[EtlBatch_Update]
	
	@BatchKEY INT 

AS
	DECLARE @ProcessFailureCNT INT = 0;
	DECLARE @BatchErrorCNT INT = 0;
	DECLARE @BatchResult VARCHAR(255);

	SELECT
		@ProcessFailureCNT = count(*)
	FROM
		[Log].[EtlProcess] a
	WHERE
		a.BatchKEY = @BatchKEY 
	AND
		a.Result = 'FAIL';

	SELECT
		@BatchErrorCNT = count(*)
	FROM
		[Log].[EtlError] a
	WHERE
		a.BatchKEY = @BatchKEY;

	IF (@ProcessFailureCNT > 0 OR @BatchErrorCNT > 0) BEGIN

		SET @BatchResult = 'FAIL';
	
	END ELSE BEGIN 

		SET @BatchResult = 'Success';

	END;

	UPDATE 
		[Log].[EtlBatch] 
	SET 
		BatchEndDT = GETDATE()
		, BatchResult = @BatchResult
	WHERE
		BatchKEY = @BatchKEY;

RETURN 1;
