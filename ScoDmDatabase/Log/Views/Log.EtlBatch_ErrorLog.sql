
CREATE VIEW [Log].[EtlBatch_ErrorLog] AS

SELECT TOP 100
	a.BatchKEY,
	a.BatchStartDT,
	a.BatchResult,
	b.ErrorMessage
FROM
	Log.EtlBatch a 
INNER JOIN
	Log.EtlError b on a.BatchKEY = b.BatchKEY 
ORDER BY 
	a.BatchStartDT DESC,
	b.ErrorDT DESC 