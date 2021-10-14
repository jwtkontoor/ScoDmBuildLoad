CREATE TABLE [Mcr].[Calendar] 
(
    --Surrogate Key
	[DateKEY]		INT				NOT NULL		IDENTITY (1,1)

    --business Key(s)
    , [DateID]                      INT             NOT NULL
    , [CalendarDT]					DATETIME		NOT NULL 
    , [CalendarDateDSC]				VARCHAR(255)	NOT NULL 
	, [CalendarDayOfWeekID]  		INT				NOT NULL		DEFAULT -1 
    , [CalendarDayOfWeekNM]			VARCHAR(255)	NOT NULL		DEFAULT ('MISSING') 
    , [CalendarDayOfMonthID]		VARCHAR(255)	NOT NULL		DEFAULT ('MISSING') 
    , [CalendarDayOfYearID]			VARCHAR(255)	NOT NULL		DEFAULT ('MISSING') 
    , [CalendarWeekID]				INT				NOT NULL		DEFAULT -1 
    , [CalendarWeekNM]				VARCHAR(255)	NOT NULL		DEFAULT ('MISSING') 
    , [CalendarMonthID]				INT				NOT NULL		DEFAULT -1 
    , [CalendarMonthNM]				VARCHAR(255)	NOT NULL		DEFAULT ('MISSING') 
    , [CalendarQuarterID]			INT				NOT NULL		DEFAULT -1 
    , [CalendarQuarterNM]			VARCHAR(255)	NOT NULL		DEFAULT ('MISSING') 
    , [CalendarYearID]				INT				NOT NULL		DEFAULT -1 
    , [CalendarYearNM]				VARCHAR(255)	NOT NULL		DEFAULT ('MISSING') 
    , [CalendarYearMonthNM]			VARCHAR(255)	NOT NULL		DEFAULT ('MISSING') 
    , [CurrentDateFLG]				VARCHAR(255)	NOT NULL		DEFAULT ('N')  
    , [DefinedHolidayFLG]			VARCHAR(255)	NOT NULL		DEFAULT ('N')   
    , [WeekendFLG]					VARCHAR(255)	NOT NULL		DEFAULT ('N') 
	, [LastWeekFLG]					VARCHAR(255)	NOT NULL		DEFAULT ('N') 


    , CONSTRAINT [PK_MCR_Calendar_DateKEY] PRIMARY KEY CLUSTERED ([DateKEY] ASC)
);

GO
