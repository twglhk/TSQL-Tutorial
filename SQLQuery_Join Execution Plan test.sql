USE BaseballData;

-- 실행 결과 : Merge Join
SELECT *
FROM players AS p
	INNER JOIN salaries AS s
    ON p.playerID = s.playerID;

-- 실행 결과 : NL, 추출 결과의 갯수가 한정되어 있으면 NL이 우수하게 동작
SELECT TOP 5 *
FROM players AS p
	INNER JOIN salaries AS s
    ON p.playerID = s.playerID;

-- 실행 결과 : Hash Join
SELECT *
FROM salaries AS s
	INNER JOIN teams AS t
    ON s.teamID = t.teamID;

-- 강제 NL 
SELECT *							-- DB 시스템이 빠른 플랜으로 실행
FROM players AS p					-- 내부 players, NonClustered Index Seek
	INNER JOIN salaries AS s		-- 외부 salaries, Clustered Index Scan
    ON p.playerID = s.playerID
	OPTION(LOOP JOIN);

-- JOIN의 내부, 외부 순서 강제. players가 외부, salaries가 내부
-- 실행 결과 : Salaries에서 Clustered Index Scan. 
-- 이유 : Index의 column 순서에서 PlayerId가 4번째이기 때문
SELECT *							
FROM players AS p					
	INNER JOIN salaries AS s		
    ON p.playerID = s.playerID
	OPTION(FORCE ORDER, LOOP JOIN);