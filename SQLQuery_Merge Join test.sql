USE BaseballData;

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SET STATISTICS PROFILE ON;

-- 실행 결과 : 
-- Clustered Index Scan -> Sort -> Merge Join(Many-To-Many On)
SELECT *
FROM players AS p
	INNER JOIN salaries AS s
    ON p.playerID = s.playerID;

-- 실행 결과 :
-- Merge Join <- Clustered Index Scan
--			  <- Sort <- NonClustered Index Scan 
--						(Index 순서가 playerId, schoolId) 
SELECT *
FROM schools AS s
	INNER JOIN schoolsplayers AS p
	ON s.schoolID = p.schoolID;