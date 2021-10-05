CREATE PROCEDURE [Setup].[BuildDatesDimension]
	-- declare variables to hold the start and end date

	AS 

DECLARE @StartDate datetime
DECLARE @EndDate datetime

--- assign values to the start date and end date we 
-- want our reports to cover (this should also take
-- into account any future reporting needs)
SET @StartDate = '01/01/2005'
SET @EndDate = '31/12/2007' 

-- using a while loop increment from the start date 
-- to the end date
DECLARE @LoopDate datetime
SET @LoopDate = @StartDate

WHILE @LoopDate <= @EndDate
BEGIN
 -- add a record into the date dimension table for this date
 INSERT INTO Mcr.Calendar VALUES (
	  FORMAT ( @LoopDate, 'yyyymmdd' ) 			--[CalendarDT]				
	--, Year(@LoopDate) 
	--, Month(@LoopDate)  
	--, Day(@LoopDate) 
	--, CASE 
	--	WHEN Month(@LoopDate) IN (1, 2, 3) THEN 1
	--	WHEN Month(@LoopDate) IN (4, 5, 6) THEN 2
	--	WHEN Month(@LoopDate) IN (7, 8, 9) THEN 3
	--	WHEN Month(@LoopDate) IN (10, 11, 12) THEN 4
	--END 			
	, FORMAT (@LoopDate, 'D')					--[CalendarDateDSC]			
	, 											--[CalendarDayOfWeekID]  	
	,											--[CalendarDayOfWeekNM]		
	,											--[CalendarDayOfMonthID]	
	,											--[CalendarDayOfYearID]		
	,											--[CalendarWeekID]			
	,											--[CalendarWeekNM]			
	,											--[CalendarYearWeekID]			
	,											--[CalendarYearWeekNM]			
	, MONTH(@LoopDate) 							--[CalendarMonthID]			
	, FORMAT ( @LoopDate, 'MMM' ) 				--[CalendarMonthShortNM]				
	, FORMAT ( @LoopDate, 'MMMM' ) 				--[CalendarMonthNM]			
	, FORMAT ( @LoopDate, 'MMM' ) 				--[CalendarYearMonthID]			
	, FORMAT ( @LoopDate, 'MMMM' ) 				--[CalendarYearMonthNM]			
	, ( MONTH(@LoopDate) % 3 ) + 1 				--[CalendarQuarterID]		
	, CAST ( (MONTH(@LoopDate) % 3 ) + 1  AS VARCHAR(100) )  				--[CalendarQuarterNM]		
	, ( MONTH(@LoopDate) % 3 ) + 1 				--[CalendarYearQuarterID]		
	, ( MONTH(@LoopDate) % 3 ) + 1				--[CalendarYearQuarterNM]		
	,											--[CalendarYearID]			
	,											--[CalendarYearNM]			
	,											--[CalendarYearMonthNM]		
	,											--[CurrentDateFLG]			
	,											--[DefinedHolidayFLG]		
	,											--[WeekendFLG]				
	,											--[LastWeekFLG]				
   
 )  
 
 -- increment the LoopDate by 1 day before
 -- we start the loop again
 SET @LoopDate = DateAdd(d, 1, @LoopDate)
END

-- now we have inserted the data we can check how it appears in our table
SELECT TOP 100 * FROM Dates
RETURN 0
