/*******************************************************************************/
/**  
	Location Dim Table 
	Created By: JWT					Created On: 7/26/21

	Used for loading the Location Dimension table.

**/
/*******************************************************************************/

CREATE TABLE [Dim].[Location]
(
	[LocationKEY]					INT				NOT NULL		IDENTITY (1,1)

	

    , CONSTRAINT [PK_Dim_Location_LocationKEY] PRIMARY KEY CLUSTERED ([LocationKEY] ASC)
);

GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_Dim_Location_LocationKEY]
    ON [Dim].[Location]([LocationKEY] ASC);