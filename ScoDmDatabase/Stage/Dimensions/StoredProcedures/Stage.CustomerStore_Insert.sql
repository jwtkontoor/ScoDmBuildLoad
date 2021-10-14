﻿CREATE PROCEDURE [Stage].[CustomerStore_Insert]

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
	
	TRUNCATE TABLE Stage.CustomerStore; 

WITH SapStores AS 
(
	--SELECT 
 --       rs.[RETAILSITE]
 --     , ka.[KEY_ACCOUNT]
 --     , rs.[PLANTCATEGORY]
 --     , rs.[PLANTTYPE]
 --     , rs.[SITE_DESCRIPTION]
 --     , rs.[REGION]
 --     , rs.[COUNTRY]
 --     , rs.[CITY]
 --     , rs.[DISTRICT]
 --     , rs.[OPENDATS]
 --     , rs.[CLOSEDATS]
 --     , rs.[SELLAREA]
 --     , rs.[SELLAREA_UNIT]
 -- FROM [dbo].[SAP_MD_RETAILSITE]  rs
 -- INNER JOIN [dbo].[LOG_RO_KEY_ACCOUNT_DB_INSTANCE] ka
 -- ON rs.[DISTRICT] = ka.REGION
 -- WHERE 1 = 1 
 -- AND [PLANTCATEGORY] = 'A'

 -- UNION 

  SELECT 
    [RETAILSITE]
      ,[KEYACCOUNT]
      ,[PLANTCATEGORY]
      ,[SITE_DESCRIPTION]
      ,[REGION]
      ,[COUNTRY]
      ,[CITY]
      ,[DISTRICT]
      ,[OPENDATS]
      ,[CLOSEDATS]
      ,[SELLAREA]
      ,[SELLAREA_UNIT]
  FROM [DB_WW_LOGILITY_PREPROD].[dbo].[LOG_RO_RETAILSITE_NONOWNED]
)
	
INSERT INTO Stage.CustomerStore ( 
    

)
SELECT 
    a.[RETAILSITE]
    , a.[KEYACCOUNT]
    , a.[PLANTCATEGORY]
    , a.[SITE_DESCRIPTION]
    , a.[REGION]
    , a.[COUNTRY]
    , a.[CITY]
    , a.[DISTRICT]
    , a.[OPENDATS]
    , a.[CLOSEDATS]
    , a.[SELLAREA]
    , a.[SELLAREA_UNIT]
FROM SapStores a ;

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