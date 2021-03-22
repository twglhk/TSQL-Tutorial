SELECT teamID, yearID, SUM(HR) AS Homerun
FROM [BaseballData].[dbo].batting
GROUP BY teamID, yearID
HAVING SUM(HR) >= 200
ORDER BY Homerun DESC