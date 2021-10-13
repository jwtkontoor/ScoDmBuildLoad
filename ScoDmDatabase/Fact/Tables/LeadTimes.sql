/*******************************************************************************/
/**  
	Inventory Fact Table 
	Created By: JWT					Created On: 7/26/21

	Contains measures related to inventory counts in variouse stages for a
	given customer on a given day

**/
/*******************************************************************************/

CREATE TABLE [Fact].[LeadTimes]
(
	
	--Surrogate (Primary) Key
	  [LeadTimesKEY]                   INT                 NOT NULL 

	--ForignKeys
    , [RetailStoreKEY]                 INT                 NOT NULL  

	--Measures
    , [LeadTimeNUM]                      INT                 NULL


	-- Data Mart Logging
	, [DmBatchKEY]			INT					NOT NULL		DEFAULT(-1)
	, [DmCreateDate]		DATETIME			NOT NULL		DEFAULT(GETDATE())
	, [DmModifiedDate]		DATETIME			NOT NULL		DEFAULT(GETDATE()) 

	--Table Constraints PK First then Foerign Keys
    , CONSTRAINT [PK_Fact_LeadTimes_LeadTimesKEY] PRIMARY KEY CLUSTERED ([LeadTimesKEY] ASC) 
)
