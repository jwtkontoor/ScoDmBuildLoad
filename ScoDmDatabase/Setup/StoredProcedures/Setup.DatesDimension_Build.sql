CREATE PROCEDURE [Setup].[BuildDatesDimension]
	-- declare variables to hold the start and end date

	AS 

DECLARE @StartDate DATE
DECLARE @EndDate DATE

--- assign values to the start date and end date we 
-- want our reports to cover (this should also take
-- into account any future reporting needs)
SET @StartDate = '01/01/2010'
SET @EndDate = '12/31/2299' 

-- using a while loop increment from the start date 
-- to the end date
DECLARE @LoopDate DATE
DECLARE @Today DATE = GETDATE()
SET @LoopDate = @StartDate

WHILE @LoopDate <= @EndDate
BEGIN
 -- add a record into the date dimension table for this date
 INSERT INTO Dim.Calendar VALUES (
	CAST ( FORMAT ( @LoopDate, 'yyyymmdd' ) AS INT	)		--[DATEKEY]	
	, CAST ( @LoopDate AS DATETIME )			--[CalendarDateTimeDTS]		       
	, CAST ( @LoopDate AS DATE )				--[CalendarDTS]						       
	, FORMAT (@LoopDate, 'D')					--[CalendarDateDESC]				   
	, DATEPART (dw, @LoopDate )				--[CalendarDayOfWeekID]  		       
	, DATENAME (dw, @LoopDate )				--[CalendarDayOfWeekNM]			       
	, DATENAME (dd, @LoopDate )	 --[CalendarDayOfMonthID]		       
	, DATEDIFF (day, DATEFROMPARTS ( YEAR (@LoopDate), 1, 1 ), @LoopDate )				--[CalendarDayOfYearID]			       
	, DATENAME (wk, @LoopDate )				--[CalendarWeekofYearID]				       
	, DATENAME (wk, @LoopDate )				--[CalendarWeekNM]				       
	, MONTH (@LoopDate)				--[CalendarMonthID]				       
	, DATENAME (month, @LoopDate )				--[CalendarMonthNM]				       
	, DATEPART (qq, @LoopDate )				--[CalendarQuarterID]			       
	, DATENAME (qq, @LoopDate )				--[CalendarQuarterNM]			       
	, DATEFROMPARTS ( YEAR (@LoopDate), ((DATEPART (qq, @LoopDate )-1 )* 3)+ 1, 1 )					--[CalendarQuarterFirstDayID]	       
	, EOMONTH (DATEFROMPARTS ( YEAR (@LoopDate), ((DATEPART (qq, @LoopDate ) - 1 )* 3) + 3, 1 ) )					--[CalendarQuarterLastDayID]	       
	, YEAR (@LoopDate)				--[CalendarYearID]				       
	, YEAR (@LoopDate)				--[CalendarYearNM]				       
	, DATEFROMPARTS ( YEAR (@LoopDate), 1, 1 )				--[CalendarYearFirstDayID]		       
	, EOMONTH (DATEFROMPARTS ( YEAR (@LoopDate), 12, 1 ) )				--[CalendarYearLastDayID]		       
	, FORMAT ( @LoopDate, 'MMMM' ) 				--[CalendarYearMonthNM]			       
	, 'N'				--[CurrentDateFLG]				       
	, 'N'				--[DefinedHolidayFLG]		
	, NULL --[FiscalMonthNUM]           		  
	, NULL --[FiscalMonthStartDay]               
	, NULL --[FiscalWeekNUM]           		  
	, NULL --[FiscalWeekStartDay]                
	, NULL --[FiscalYearNUM]           		  
	, NULL --[FiscalYearStartDay]
	, 'N'				--[LastWeekFLG]					       
	, CASE 
		WHEN DATEPART (dw, @LoopDate ) IN ( 1,7 ) THEN 1
		ELSE 0
	END										--[WeekendFLG]					       
	
   
 )  
 --WHERE 1 = 1 
 
 -- increment the LoopDate by 1 day before
 -- we start the loop again
 SET @LoopDate = DateAdd(d, 1, @LoopDate)
END

