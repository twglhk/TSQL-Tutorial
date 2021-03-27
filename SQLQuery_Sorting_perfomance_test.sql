USE BaseballData;

-- ORDER BY
SELECT * 
FROM players
ORDER BY college;

-- INDEX를 활용하기 떄문에 SORTING X
SELECT *
FROM batting
ORDER BY playerID, yearID;

-- GROUP BY
SELECT college, COUNT(college)
FROM players
WHERE college LIKE 'C%'
GROUP BY college;

-- INDEX를 활용하기 떄문에 SORTING X
SELECT playerID, COUNT(playerID)
FROM players
WHERE playerID LIKE 'C%'
GROUP BY playerID;

-- DISTINCT
SELECT DISTINCT college
FROM players
WHERE college LIKE 'C%';

-- UNION
SELECT college
FROM players
WHERE college LIKE 'B%'
UNION
SELECT college
FROM players
WHERE college LIKE 'C%' 

-- 중복 제거가 필요 없다면 SORTING 제거 가능
SELECT college
FROM players
WHERE college LIKE 'B%'
UNION ALL
SELECT college
FROM players
WHERE college LIKE 'C%' 

-- RANKING Windows func
SELECT ROW_NUMBER() OVER (ORDER BY college)
FROM players;
