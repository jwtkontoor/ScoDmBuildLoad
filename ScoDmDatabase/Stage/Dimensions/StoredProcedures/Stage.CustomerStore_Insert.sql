CREATE PROCEDURE [Stage].[CustomerStore_Insert]

	@BatchKEY AS INT = -1

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
	SELECT 
        rs.[RETAILSITE]							AS [RetailSiteID]
      , ka.[RP_KEYACCOUNT]                      AS [KeyAccountCD]
	  , 'INTERNAL'								AS [SoldToCustomerID]
	  , 'KONTOOR'								AS [SoldToDESC]
      , ka.[CUSTOMER]							AS [ShipToCustomerID]		
      , ka.[DESCRIPTION]						AS [SapShipToDESC]
      , rs.[PLANTCATEGORY]
      , rs.[PLANTTYPE]
      , rs.[SITE_DESCRIPTION]					AS [SiteDESC]
      , rs.[REGION]
      , rs.[COUNTRY]
      , rs.[CITY]
      , rs.[DISTRICT]
      , rs.[OPENDATS]
      , rs.[CLOSEDATS]
      , rs.[SELLAREA]
      , rs.[SELLAREA_UNIT]
    FROM [dbo].[SAP_MD_RETAILSITE]  rs
    INNER JOIN SAP_MD_CUSTOMER ka
    ON rs.RETAILSITE = RIGHT(ka.CUSTOMER,4)
    WHERE 1 = 1 
	AND LEFT(ka.CUSTOMER,6) = '000000'
    AND [PLANTCATEGORY] = 'A'

  UNION 

  SELECT 
		[RETAILSITE]							AS [RetailSiteID]
      ,nown.[KEYACCOUNT]						AS [KeyAccountCD]
	  , dbi.[SAP_CUST_ID]						AS [SoldToCustomerID]
	  , dbi.[KEY_ACCOUNT_DESC]					AS [SoldToDESC]
      , c.CUSTOMER								AS [ShipToCustomerID]		
      , c.[DESCRIPTION]							AS [SapShipToDESC]
      ,[PLANTCATEGORY]
      , NULL									AS [PLANTTYPE]
      ,[SITE_DESCRIPTION]						AS [SiteDESC]
      ,nown.[REGION]
      ,nown.[COUNTRY]
      ,nown.[CITY]
      ,nown.[DISTRICT]
      ,[OPENDATS]
      ,[CLOSEDATS]
      ,[SELLAREA]
      ,[SELLAREA_UNIT]
  FROM [dbo].[LOG_RO_RETAILSITE_NONOWNED] nown
  INNER JOIN [DB_WW_LOGILITY_DEV].[dbo].[LOG_RO_KEY_ACCOUNT_DB_INSTANCE] dbi
  ON nown.KEYACCOUNT = dbi.KEY_ACCOUNT
  INNER JOIN [LOGILITY_SLT_PPD].[sapee1et1].[EDPAR] e
  ON [PARVW] = [PARTNER_FUNCTION] AND [KUNNR] = [SAP_CUST_ID] 
  INNER JOIN [dbo].[SAP_MD_CUSTOMER] c ON e.INPNR = c.CUSTOMER
)
	
INSERT INTO Stage.CustomerStore ( 

    [RetailSiteId]   
      ,[KeyAccountCD]       
      , [SoldToCustomerID]
      , [SoldToDESC] 
      ,[ShipToCustomerID]
      ,[ShipToDESC]
      ,[PlantCategoryCD]              
      ,[SiteDESC]            
      ,[Region]                     
      ,[Country]                    
      ,[City]                       
      ,[District]                   
      ,[OpenedOnDTS]                
      ,[ClosedOnDTS]                
      ,[SellAreaCD]                   
      ,[SellAreaUnit]               

)
SELECT 
    a.[RetailSiteID]
    , a.[KeyAccountCD]     
      , [SoldToCustomerID]
      , [SoldToDESC] 
      ,[ShipToCustomerID]
      ,[SapShipToDESC]
      ,[PlantCategory]              
      ,[SiteDESC]  
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
