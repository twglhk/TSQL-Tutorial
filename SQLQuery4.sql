-- SELECT weight / POWER(height, 2) AS BMI


SELECT weight * 1.0 / POWER((height), 2.0) AS BMI
FROM [BaseballData].[dbo].[players]
WHERE weight IS NOT NULL AND height IS NOT NULL
ORDER BY BMI ASC

SELECT '안녕' + 'SQL'

SELECT TRIM('          안녕하세요  문재인입니다   ');