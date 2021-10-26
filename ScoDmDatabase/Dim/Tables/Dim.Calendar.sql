CREATE TABLE [Dim].[Calendar]
(
	[DateKEY]						        INT				        NOT NULL		
    , [CalendarDateTimeDTS]			        DATETIME		        NOT NULL 	
    , [CalendarDTS]					        DATE		            NOT NULL 	
    , [CalendarDateDESC]				    VARCHAR(255)	        NOT NULL 
	, [CalendarDayOfWeekNUM]  		        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarDayOfWeekNM]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarDayOfMonthNUM]		        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarDayOfYearNUM]			    VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarWeekNUM]				        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarWeekNM]				        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarMonthNUM]				    INT				        NOT NULL		    DEFAULT -1 
    , [CalendarMonthNM]				        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarQuarterNUM]			        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarQuarterNM]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarQuarterFirstDayDTS]	        DATE			        NOT NULL		    
    , [CalendarQuarterLastDayDTS]	        DATE			        NOT NULL		    
    , [CalendarYearNUM]				        INT				        NOT NULL		    DEFAULT -1 
    , [CalendarYearNM]				        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CalendarYearFirstDayDTS]		        DATE			        NOT NULL		    DEFAULT '01-01-2021'
    , [CalendarYearLastDayDTS]		        DATE			        NOT NULL		    DEFAULT '12-31-2021'
    , [CalendarYearMonthNM]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('MISSING') 
    , [CurrentDateFLG]				        VARCHAR(255)	        NOT NULL		    DEFAULT ('N')  
    , [DefinedHolidayFLG]			        VARCHAR(255)	        NOT NULL		    DEFAULT ('N') 
	, [LastWeekFLG]					        VARCHAR(255)	        NOT NULL		    DEFAULT ('N')   
    , [WeekendFLG]					        VARCHAR(255)	        NOT NULL		    DEFAULT ('N') 


    , CONSTRAINT [PK_Dim_Calendar_DateKEY] PRIMARY KEY CLUSTERED ([DateKEY] ASC)
);

GO


CREATE UNIQUE NONCLUSTERED INDEX [UIX_Dim_Calendar_CalendarDT]
    ON [Dim].[Calendar]([CalendarDTS] ASC);
