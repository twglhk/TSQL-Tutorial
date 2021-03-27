USE BaseballData;

-- ORDER BY
SELECT * 
FROM players
ORDER BY college;

-- INDEX�� Ȱ���ϱ� ������ SORTING X
SELECT *
FROM batting
ORDER BY playerID, yearID;

-- GROUP BY
SELECT college, COUNT(college)
FROM players
WHERE college LIKE 'C%'
GROUP BY college;

-- INDEX�� Ȱ���ϱ� ������ SORTING X
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

-- �ߺ� ���Ű� �ʿ� ���ٸ� SORTING ���� ����
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
