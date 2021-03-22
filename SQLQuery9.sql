-- 1) 역대 보스턴 선수들 리스트
SELECT *
FROM [BaseballData].[dbo].[batting]
WHERE teamID = 'BOS'


-- 2) 보스턴 소속 선수들 몇 명? (중복 제거)
SELECT DISTINCT playerID
FROM [BaseballData].[dbo].[batting]
WHERE teamID = 'BOS'

SELECT COUNT(DISTINCT playerID)
FROM [BaseballData].[dbo].[batting]
WHERE teamID = 'BOS'

-- 3) 보스턴 팀이 2004년도에 친 홈런 개수
SELECT SUM(HR)
FROM [BaseballData].[dbo].[batting]
WHERE yearID = '2004' AND teamID = 'BOS'

-- 4) 보스턴 소속으로 단일 년도 최다 홈런을 친 사람의 정보
SELECT TOP (1) *
FROM [BaseballData].[dbo].[batting]
WHERE HR IS NOT NULL AND teamID = 'BOS'
ORDER BY HR DESC