CREATE PROCEDURE [Mcr].[CustomerStore_Merge]

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

	WITH MergeCustomerStore AS 
	( 		
		SELECT 
			  a.[RetailSiteID]  
			, a.[KeyAccountCD]   
			, a.[SoldToCustomerID] 
			, a.[SoldToDESC]
			, a.[ShipToCustomerID]	
			, a.[ShipToDESC]
			, a.[PlantTypeCD]
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
			, 0							AS [HasChangedFLG]					
			, CASE 
				WHEN a.[ClosedOnDTS] < GETDATE() THEN 0 
				ELSE 1 
			END							AS [IsCurrentFLG]					
			, a.[ClosedOnDTS]			AS [DmValidToDTS]				
			, a.[OpenedOnDTS]			AS [DmValidFromDTS]					
		FROM
			Stage.CustomerStore a

	)

	MERGE INTO Mcr.CustomerStore tgt

	USING ( 

		SELECT 
			  a.[RetailSiteID]  
			, a.[KeyAccountCD]   
			, a.[SoldToCustomerID] 
			, a.[SoldToDESC]
			, a.[ShipToCustomerID]	
			, a.[ShipToDESC]
			, a.[PlantTypeCD]
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
			, a.[HasChangedFLG]					
			, a.[IsCurrentFLG]					
			, a.[DmValidToDTS]				
			, a.[DmValidFromDTS]					
		FROM
			MergeCustomerStore a

	) src 

	ON ( 

		tgt.[RetailSiteID] = src.[RetailSiteID]  
	)

	WHEN MATCHED THEN 

		UPDATE SET

		  tgt.[KeyAccountCD]                  		= src.[KeyAccountCD]       
		, tgt.[SoldToCustomerID]					= src.[SoldToCustomerID] 
		, tgt.[SoldToDESC]							= src.[SoldToDESC]
		, tgt.[ShipToCustomerID]					= src.[ShipToCustomerID]	
		, tgt.[ShipToDESC]							= src.[ShipToDESC]
		, tgt.[PlantTypeCD]							= src.[PlantTypeCD]
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

	WHEN NOT MATCHED THEN 

		INSERT (

			  [KeyAccountCD]        
			 , [SoldToCustomerID] 
			 , [SoldToDESC]
			 , [ShipToCustomerID]	
			 , [ShipToDESC]
			 , [PlantTypeCD]
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
			, [HasChangedFLG]	
			, [IsCurrentFLG]	
			, [DmValidToDTS]	
			, [DmValidFromDTS]	

		) VALUES (
		
			  src.[KeyAccountCD]            
			, src.[SoldToCustomerID] 
			, src.[SoldToDESC]
			, src.[ShipToCustomerID]	
			, src.[ShipToDESC]
			, src.[PlantTypeCD]
			, src.[PlantCategoryCD]     
			, src.[SiteDESC]            
			, src.[Region]              
			, src.[Country]             
			, src.[City]                
			, src.[District]            
			, src.[OpenedOnDTS]         
			, src.[ClosedOnDTS]         
			, src.[SellAreaCD]            
			, src.[SellAreaUnit]   
			, 1		
			, src.[IsCurrentFLG]	
			, src.[DmValidToDTS]	
			, src.[DmValidFromDTS]				
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

