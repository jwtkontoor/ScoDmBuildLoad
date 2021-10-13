

CREATE PROCEDURE [Log].[GetLastSuccessfulRunDate]
AS
	SELECT MAX([BatchEndDT]) 
      
  FROM [Log].[EtlBatch]
  WHERE [BatchResult] = 'SUCCESS'

RETURN 0

