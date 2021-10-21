CREATE TABLE [Dim].[Calendar]
(
	[DateKEY]						        INT				        NOT NULL		
    , [CalendarDateTimeDTS]			        DATETIME		        NOT NULL 	
    , [CalendarDTS]					        DATE		            NOT NULL 	
    , [CalendarDateDESC]				    VARCHAR(255)	        NOT NULL 
	, [CalendarDayOfWeekID]  		        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarDayOfWeekNM]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarDayOfMonthID]		        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarDayOfYearID]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarWeekID]				        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarWeekNM]				        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarMonthID]				        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarMonthNM]				        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarQuarterID]			        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarQuarterNM]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarQuarterFirstDayID]	        DATE			        NOT NULL		    
    , [CalendarQuarterLastDayID]	        DATE			        NOT NULL		    
    , [CalendarYearID]				        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarYearNM]				        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarYearFirstDayID]		        DATE			        NOT NULL		    DEFAULT '01-01-2021'
    , [CalendarYearLastDayID]		        DATE			        NOT NULL		    DEFAULT '12-31-2021'
    , [CalendarYearMonthNM]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CurrentDateFLG]				        VARCHAR(255)	        NOT NULL		    DEFAULT ('N')  
    , [DefinedHolidayFLG]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('N') 
	, [LastWeekFLG]					        VARCHAR(255)	        NOT NULL		    DEFAULT ('N')   
    , [WeekendFLG]					        VARCHAR(255)	        NOT NULL		    DEFAULT ('N') 


    , CONSTRAINT [PK_Dim_Calendar_DateKEY] PRIMARY KEY CLUSTERED ([DateKEY] ASC)
);

GO


CREATE UNIQUE NONCLUSTERED INDEX [UIX_Dim_Calendar_CalendarDT]
    ON [Dim].[Calendar]([CalendarDT] ASC);
