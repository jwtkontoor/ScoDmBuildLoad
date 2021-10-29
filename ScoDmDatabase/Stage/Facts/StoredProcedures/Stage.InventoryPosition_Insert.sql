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
	
	TRUNCATE TABLE Stage.Shipment; 

WITH SapShipments AS 
(
  SELECT 
        [ORDERTYPE] AS OrderTypeCD
      ,[SORDER] AS SalesOrderNUM
      ,[SORDER_ITEM] AS SaledOrderItemNUM
      ,[SORDER_SCHEDLINE] 
      ,[MATNR] AS MaterialID
      ,[PLANT] AS PlantId
      ,[SOLDTO] AS SoldToCustomerId
      ,[SHIPTO]
      ,[MARKFOR]
      ,[DISTCHANNEL]
      ,[REGION]
      ,[FISCVRNT_MTH]
      ,[FISCMONTH]
      ,[CALDAY]
      ,[UOM]
      ,[ZQTY_OPEN]
      ,[ZQTY_CONFIRMED]
      ,[ZQTY_DELIVERED]
      ,[ZQTY_CANCELLED]
      ,[KEYACCOUNT]
      ,[TRACKING_NUM]
      ,[REQ_SEGMENT]
      ,[SEASON]
      ,[SEASON_YEAR]
      ,[REASON]
      ,[ORG_ORD_QTY]
      ,[ORG_ORD_DAY]
  FROM [DB_WW_LOGILITY_DEV].[dbo].[SAP_TD_SALESORDERS]
  --FROM [dbo].[LOG_RO_RETAILSITE_NONOWNED]
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
