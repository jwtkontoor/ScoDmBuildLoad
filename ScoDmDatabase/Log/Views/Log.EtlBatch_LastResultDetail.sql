
CREATE VIEW [Log].[EtlBatch_LastResultDetail] AS 
	
WITH EtlBatch ( BatchKEY ) AS (

	SELECT 
		MAX(a.BatchKEY) AS BatchKEY
	FROM
		Log.EtlBatch a

)

SELECT TOP 500
    a.[EtlProcessKEY]		
    , a.[BatchKEY]			
    , a.[ProcessStartDT]	
    , a.[ProcessEndDT]	
	, DATEDIFF(second, a.[ProcessStartDT], a.[ProcessEndDT]	) AS ElapsedTimeSeconds	
    , a.[RowsInserted]		
    , a.[RowsUpdated]		
    , a.[ProcessNM]			
    , a.[Result]			
FROM
	Log.EtlProcess a
INNER JOIN
	EtlBatch b on a.BatchKEY = b.BatchKey
ORDER BY 
	a.ProcessStartDT DESC