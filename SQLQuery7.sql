
SELECT *,
	CASE 
		
		WHEN birthMonth < 6 THEN N'겨울'
		
		ELSE N'모름'
		END AS birthSeason
FROM players