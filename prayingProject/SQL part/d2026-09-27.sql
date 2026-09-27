
--CREATE DATABASE project12;
--GO
USE project12;

--------------------------------------------------------------------------------
DROP TABLE IF EXISTS all_records;
GO

	
CREATE TABLE all_records ([date] DATE, 
					[weekday] VARCHAR(50),
					[bomdod] VARCHAR(50),
					[peshin] VARCHAR(50), 
					[asr] VARCHAR(50),
					[shom] VARCHAR(50), 
					[xufton] VARCHAR(50),
					[vitr] VARCHAR(50),
					[extra bomdod] INT,
					[extra peshin] INT,
					[extra asr] INT,
					[extra shom] INT,
					[extra xufton] INT,
					)

--SELECT * FROM all_records;

--------------------------------------------------------------------------------
BULK INSERT all_records
FROM 'D:\rebuilding\praying 2.0 - praying.csv'
WITH
	(
	FIRSTROW= 2,
	ROWTERMINATOR= '\n',
	FIELDTERMINATOR= ','
	)

--SELECT * FROM all_records;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
DECLARE @current_date DATE = (SELECT GETDATE())

--SELECT @current_date

DELETE FROM all_records
WHERE [date] > @current_date;


SELECT * FROM all_records
ORDER BY [date] DESC;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

SELECT COUNT(*) FROM all_records;

--------------------------------------------------------------------------------
drop table if exists new_all_records;
go

SELECT *,
		IIF([bomdod] IS NULL, 0, 1) [bomdod 01],
		IIF([peshin] IS NULL, 0, 1) [peshin 01],
		IIF([asr] IS NULL, 0, 1) [asr 01],
		IIF([shom] IS NULL, 0, 1) [shom 01],
		IIF([xufton] IS NULL, 0, 1) [xufton 01],
		IIF([bomdod] IS NULL, 0, 1) + IIF([peshin] IS NULL, 0, 1) + IIF([asr] IS NULL, 0, 1) + 
		IIF([shom] IS NULL, 0, 1) + IIF([xufton] IS NULL, 0, 1) + 
		IIF([extra bomdod] IS NULL, 0, 1) + IIF([extra peshin] IS NULL, 0, 1) + IIF([extra asr] IS NULL, 0, 1) + 
		IIF([extra shom] IS NULL, 0, 1) + IIF([extra xufton] IS NULL, 0, 1) [daily total]
INTO new_all_records
FROM all_records
--ORDER BY [date] DESC;

select * from new_all_records
order by [date] desc;
