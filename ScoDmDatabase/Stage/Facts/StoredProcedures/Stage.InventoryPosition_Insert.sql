CREATE PROCEDURE [Stage].[InventoryPosition_Insert] 

	@BatchKEY INT

AS 

--============================================================================================================

	DECLARE @ProcessStartDT DATETIME		= GETDATE();
	DECLARE @ProcessEndDT	DATETIME;
	DECLARE @RowsInserted	VARCHAR(255)	= 0;
	DECLARE @RowsUpdated	VARCHAR(255)	= 0;
	DECLARE @ProcessNM		VARCHAR(255)	= OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
	DECLARE @Result			VARCHAR(255);

--============================================================================================================

BEGIN TRY
	
	TRUNCATE TABLE Stage.InventoryPosition; 

WITH CurrInventoryPosition AS 
(
      SELECT 
    [SORDER] + '|' + [SORDER_ITEM] + '|' + [SORDER_SCHEDLINE] AS InventoryPositionId
    ,[ORDERTYPE]                AS OrderTypeCD
      ,[SORDER]                 AS SalesOrderNUM
      ,[SORDER_ITEM]            AS SaledOrderItemNUM
      ,[SORDER_SCHEDLINE]       AS SaledOrderItemLineNUM
      ,[KEYACCOUNT]		                                        AS [KeyAccountCD]
      ,[MATNR]                  AS MaterialID
      ,[PLANT]                  AS PlantId
      ,[SOLDTO]                 AS SoldToCustomerId
      ,[SHIPTO]                 AS ShipToCustomerId
      ,[MARKFOR]                AS MarkForCD
	  ,[CALDAY]					AS [CalendarDTS]
      ,ISNULL(FORMAT(CAST ([CALDAY] AS DATE), 'yyyyMMdd'), -1) 					AS [CalendarDateKEY]
      ,[DISTCHANNEL]            AS DisributionChannel
      ,[REGION]                 AS RegionCD
      ,[UOM]
      ,[ZQTY_OPEN]
      ,[ZQTY_CONFIRMED]
      ,[ZQTY_DELIVERED]
      ,[ZQTY_CANCELLED]
      ,[TRACKING_NUM]				AS [TrackingNUM]
      ,[REQ_SEGMENT]
      ,[SEASON]
      ,[SEASON_YEAR]
      ,[REASON]						AS [ReasonCD]
      ,[ORG_ORD_QTY]				AS [OrderQuantityAMT]
      ,[ORG_ORD_DAY]				AS [OrderDTS] 
      ,ISNULL(FORMAT(CAST ([ORG_ORD_DAY] AS DATE), 'yyyyMMdd'), -1) 								AS [OrderDateKEY]
  FROM [DB_WW_LOGILITY_DEV].[dbo].[SAP_TD_SALESORDERS]


)
	
INSERT INTO Stage.InventoryPosition ( 

    [InventoryPositionId]				
    , OrderTypeCD						
    , SalesOrderNUM						
    , SalesOrderItemNUM					
    , SalesOrderItemLineNUM 			
    , [KeyAccountCD]					
    , [MaterialId]						
    , [PlantId]							
    , [SoldToCustomerId]				
    , [ShipToCustomerId]				
    , [MarkForCD]						
    , [CalendarDTS] 					
    , [DisributionChannel]				
    , [RegionCD]						
    , [UOM]					
    , [ZQTY_OPEN]						
    , [ZQTY_CONFIRMED]					
    , [ZQTY_DELIVERED]					
    , [ZQTY_CANCELLED]					
    , [TrackingNUM]						
    , [RequestSegmentCD]						
    , [Season]							
    , [SeasonYear]				
    , [ReasonCD]				
	, [OrderQuantityAMT]
    , [OrderDTS]	
    , [OrderDateKEY]		
    )
SELECT 
    
    [InventoryPositionId]				
    , OrderTypeCD						
    , SalesOrderNUM						
    , SaledOrderItemNUM					
    , SaledOrderItemLineNUM 			
    , [KeyAccountCD]					
    , [MaterialId]						
    , [PlantId]							
    , [SoldToCustomerId]				
    , [ShipToCustomerId]				
    , [MarkForCD]						
    , [CalendarDTS] 					
    , [DisributionChannel]				
    , [RegionCD]						
    , [UOM]								
    , [ZQTY_OPEN]						
    , [ZQTY_CONFIRMED]					
    , [ZQTY_DELIVERED]					
    , [ZQTY_CANCELLED]					
    , [TrackingNUM]						
    , [REQ_SEGMENT]						
    , [SEASON]							
    , [SEASON_YEAR]				
    , [ReasonCD]				
	, [OrderQuantityAMT]
    , [OrderDTS]	
    , [OrderDateKEY]

FROM CurrInventoryPosition a ;

--=================================================================================================

	SET @RowsInserted	= @@ROWCOUNT;
	SET @ProcessEndDT	= GETDATE();
	SET @Result			= 'SUCCESS';

	EXECUTE [Log].[EtlProcess_Create] @BatchKEY, @ProcessStartDT, @ProcessEndDT, @RowsInserted, @RowsUpdated, @ProcessNM, @Result;

	RETURN 1;

END TRY

BEGIN CATCH

	SET @RowsUpdated	= 0;
	SET @ProcessEndDT	= GETDATE();
	SET @Result			= 'FAIL';

	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
				
	EXECUTE [Log].EtlError_Create  @BatchKEY, @ErrorMessage;

	EXECUTE [Log].[EtlProcess_Create] @BatchKEY, @ProcessStartDT, @ProcessEndDT, @RowsInserted, @RowsUpdated, @ProcessNM, @Result;
    
	RAISERROR (

		@ErrorMessage,
		@ErrorSeverity, 
		@ErrorState 
	);

END CATCH;
