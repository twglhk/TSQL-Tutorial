
SELECT COUNT (CASE WHEN weight IS NULL THEN 0 ELSE weight END)
FROM [BaseballData].[dbo].[players]