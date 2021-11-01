CREATE PROCEDURE [Stage].[InventoryPositionSap_Insert]

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
	
	TRUNCATE TABLE Stage.Shipment; 

WITH SapShipments AS 
(
      SELECT 
    [SORDER] + '|' + [SORDER_ITEM] + '|' + [SORDER_SCHEDLINE] AS InventoryPositionId
    ,[ORDERTYPE]                AS OrderTypeCD
      ,[SORDER]                 AS SalesOrderNUM
      ,[SORDER_ITEM]            AS SaledOrderItemNUM
      ,[SORDER_SCHEDLINE]       AS SaledOrderItemLineNUM
      ,[KEYACCOUNT]				AS [KEY_ACCOUNT]
      ,[MATNR]                  AS MaterialID
      ,[PLANT]                  AS PlantId
      ,[SOLDTO]                 AS SoldToCustomerId
      ,[SHIPTO]                 AS ShipToCustomerId
      ,[MARKFOR]                AS MarkFor
      ,[CALDAY]
      ,[DISTCHANNEL]            AS DisributionChannel
      ,[REGION]                 AS RegionCD
      ,[UOM]
      ,NULL						AS [EDI852_PROCESS_DTE]		
      ,NULL						AS [EDI852_POST_DTE] 
      , NULL AS [EDI852_OH_QTY]
      , NULL AS [EDI852_INTRANSIT_QTY]
      , NULL AS [EDI852_OO_QTY]
      , NULL AS [EDI852_RCPT_QTY]
      , NULL AS [EDI852_SLS_QTY]
      , NULL AS [EDI852_ADJ_INV_QTY]
      , NULL AS [EDI852_RTN_QTY]
      , NULL AS [SAP_OPEN_ORDER_QTY]
      , NULL AS [SAP_DAY_SHIPPED_QTY]
      , NULL AS [PI_BEG_OH_QTY]
      , NULL AS [PI_OPEN_ORDER_QTY]
      , NULL AS [PI_INTRANSIT_QTY]
      , NULL AS [PI_OO_ADJ_QTY]
      , NULL AS [PI_ASSUMED_RCPT_QTY]
      , NULL AS [PI_END_OH_QTY]
      , NULL AS [PI_ORIG_END_OH_QTY]
      , NULL AS [PI_PROCESSED_FLG]  
      ,[ZQTY_OPEN]
      ,[ZQTY_CONFIRMED]
      ,[ZQTY_DELIVERED]
      ,[ZQTY_CANCELLED]
      ,[TRACKING_NUM]
      ,[REQ_SEGMENT]
      ,[SEASON]
      ,[SEASON_YEAR]
      ,[REASON]
      ,[ORG_ORD_QTY]
      ,[ORG_ORD_DAY]
      ,1                        AS SapOrder
      ,0                        AS EdiOrder
  FROM [DB_WW_LOGILITY_DEV].[dbo].[SAP_TD_SALESORDERS]
  --FROM [dbo].[LOG_RO_RETAILSITE_NONOWNED]

  UNION 

  SELECT 
	[MATNR] + '|' + [MARKFOR] + '|' + [EDI852_POST_DTE]		AS InventoryPositionId 
	, NULL													AS OrderTypeCD 
	, NULL													AS SalesOrderNUM
	, NULL													AS SaledOrderItemNUM
	, NULL													AS SaledOrderItemLineNUM 
      ,[KEY_ACCOUNT]
      ,[MATNR]												AS MaterialId 
	  , NULL												AS PlantId 
      , [CUSTOMER_ID]               AS SoldToCustomerId
      , [CUSTOMER_ID]                  AS ShipToCustomerId
      ,[MARKFOR]
      ,[CALDAY] 
	  , NULL				 AS DisributionChannel
      ,NULL                 AS RegionCD
      ,NULL AS [UOM]
      ,[EDI852_PROCESS_DTE]
      ,[EDI852_POST_DTE]
      ,[EDI852_OH_QTY]
      ,[EDI852_INTRANSIT_QTY]
      ,[EDI852_OO_QTY]
      ,[EDI852_RCPT_QTY]
      ,[EDI852_SLS_QTY]
      ,[EDI852_ADJ_INV_QTY]
      ,[EDI852_RTN_QTY]
      ,[SAP_OPEN_ORDER_QTY]
      ,[SAP_DAY_SHIPPED_QTY]
      ,[PI_BEG_OH_QTY]
      ,[PI_OPEN_ORDER_QTY]
      ,[PI_INTRANSIT_QTY]
      ,[PI_OO_ADJ_QTY]
      ,[PI_ASSUMED_RCPT_QTY]
      ,[PI_END_OH_QTY]
      ,[PI_ORIG_END_OH_QTY]
      ,[PI_PROCESSED_FLG]  
      , NULL AS [ZQTY_OPEN]
      , NULL AS [ZQTY_CONFIRMED]
      , NULL AS [ZQTY_DELIVERED]
      , NULL AS [ZQTY_CANCELLED]
      , NULL AS [TRACKING_NUM]
      , NULL AS [REQ_SEGMENT]
      , NULL AS [SEASON]
      , NULL AS [SEASON_YEAR]
      , NULL AS [REASON]
      , NULL AS [ORG_ORD_QTY]
      , NULL AS [ORG_ORD_DAY]
      ,0                        AS SapOrder
      ,1                        AS EdiOrder
  FROM [dbo].[SAP_EDI852_PI_DATA]  

)
	
INSERT INTO Stage.Shipment ( 

    [ShipmentId]                  

)
SELECT 
    a.[ShipmentId]
FROM SapShipments a ;

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
