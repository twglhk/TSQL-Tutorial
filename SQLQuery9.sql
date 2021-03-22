-- 1) ���� ������ ������ ����Ʈ
SELECT *
FROM [BaseballData].[dbo].[batting]
WHERE teamID = 'BOS'


-- 2) ������ �Ҽ� ������ �� ��? (�ߺ� ����)
SELECT DISTINCT playerID
FROM [BaseballData].[dbo].[batting]
WHERE teamID = 'BOS'

SELECT COUNT(DISTINCT playerID)
FROM [BaseballData].[dbo].[batting]
WHERE teamID = 'BOS'

-- 3) ������ ���� 2004�⵵�� ģ Ȩ�� ����
SELECT SUM(HR)
FROM [BaseballData].[dbo].[batting]
WHERE yearID = '2004' AND teamID = 'BOS'

-- 4) ������ �Ҽ����� ���� �⵵ �ִ� Ȩ���� ģ ����� ����
SELECT TOP (1) *
FROM [BaseballData].[dbo].[batting]
WHERE HR IS NOT NULL AND teamID = 'BOS'
ORDER BY HR DESC