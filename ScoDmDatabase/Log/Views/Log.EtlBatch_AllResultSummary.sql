
CREATE VIEW [Log].[EtlBatch_AllResultSummary] AS 

	WITH ProcessResults AS (

		SELECT 
			a.BatchKEY	AS BatchKEY
			, count(*)	AS ProcessCNT
		FROM
			Log.EtlProcess a
		GROUP BY 
			a.BatchKEY
	)

	SELECT TOP 10
		a.BatchStartDT					AS BatchStartDT
		, a.BatchEndDT					AS BatchEndDT
		, a.BatchTypeDSC				AS BatchTypeDSC
		, FORMAT(a.BatchEndDT - a.BatchStartDT, 'mm:ss') AS ElapsedTM
		, b.ProcessCNT					AS ProcessCNT
		, a.BatchResult					AS BatchResult

	FROM
		Log.EtlBatch a
	INNER JOIN
		ProcessResults b on a.BatchKEY = b.BatchKEY
	ORDER BY 
		a.BatchStartDT DESC;
