
SELECT *,
	CASE 
		
		WHEN birthMonth < 6 THEN N'�ܿ�'
		
		ELSE N'��'
		END AS birthSeason
FROM players