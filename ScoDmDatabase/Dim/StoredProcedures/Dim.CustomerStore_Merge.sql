CREATE PROCEDURE [Dim].[CustomerStore_Merge]

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

	MERGE INTO Dim.CustomerStore tgt

	USING ( 

		SELECT 
			  a.[CustomerStoreKEY]	
			, a.[RetailSiteID]  
			, a.[CustomerId]
			, a.[KeyAccountCD]                  
			, a.[PlantCategoryCD]              
			, a.[SiteDESC]            
			, a.[Region]                     
			, a.[Country]                    
			, a.[City]                       
			, a.[District]                   
			, a.[OpenedOnDTS]                
			, a.[ClosedOnDTS]                
			, a.[SellAreaCD]                   
			, a.[SellAreaUnit]        
			, GETDATE()				AS DmBeginDTS
			, GETDATE()				AS DmEndDTS
			, 1						AS DmActiveKEY
			, @BatchKey				AS DmBatchKEY	
		FROM
			Mcr.CustomerStore a

	) src 

	ON ( 

		tgt.CustomerStoreKEY = src.CustomerStoreKEY
	)

	WHEN MATCHED THEN 

		UPDATE SET

		  tgt.[RetailSiteID]   						= src.[RetailSiteID]   
		, tgt.[KeyAccountCD]                  		= src.[KeyAccountCD]                  
		, tgt.[PlantCategoryCD]              		= src.[PlantCategoryCD]              
		, tgt.[SiteDESC]            				= src.[SiteDESC]            
		, tgt.[Region]                     			= src.[Region]                     
		, tgt.[Country]                    			= src.[Country]                    
		, tgt.[City]                       			= src.[City]                       
		, tgt.[District]                   			= src.[District]                   
		, tgt.[OpenedOnDTS]                			= src.[OpenedOnDTS]                
		, tgt.[ClosedOnDTS]                			= src.[ClosedOnDTS]                
		, tgt.[SellAreaCD]                   		= src.[SellAreaCD]                   
		, tgt.[SellAreaUnit]        				= src.[SellAreaUnit]  
		, tgt.DmBatchKEY							= src.DmBatchKEY	

	WHEN NOT MATCHED THEN 

		INSERT (

			  [CustomerStoreKEY]
			, [KeyAccountCD]        	
			, [PlantCategoryCD]     	
			, [SiteDESC]            	
			, [Region]              	
			, [Country]             	
			, [City]                	
			, [District]            	
			, [OpenedOnDTS]         	
			, [ClosedOnDTS]         	
			, [SellAreaCD]            	
			, [SellAreaUnit]        	
			, DmBatchKEY			
			, DmBeginDTS						
			, DmEndDTS						
			, DmActiveFLG					
			, DmBatchKEY					

		) VALUES (
		
			  src.[CustomerStoreKEY]
			, src.[KeyAccountCD]        
			, src.[PlantCategoryCD]     
			, src.[SiteDESC]            
			, src.[Region]              
			, src.[Country]             
			, src.[City]                
			, src.[District]            
			, src.[OpenedOnDTS]         
			, src.[ClosedOnDTS]         
			, src.[SellArea]            
			, src.[SellAreaUnit]        
			, src.DmBatchKEY	
			, src.DmBeginDTS
			, src.DmEndDTS
			, src.DmActiveFLG
			, src.DmBatchKEY	
		);

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

