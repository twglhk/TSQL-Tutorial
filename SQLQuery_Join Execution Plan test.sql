USE BaseballData;

-- ���� ��� : Merge Join
SELECT *
FROM players AS p
	INNER JOIN salaries AS s
    ON p.playerID = s.playerID;

-- ���� ��� : NL, ���� ����� ������ �����Ǿ� ������ NL�� ����ϰ� ����
SELECT TOP 5 *
FROM players AS p
	INNER JOIN salaries AS s
    ON p.playerID = s.playerID;

-- ���� ��� : Hash Join
SELECT *
FROM salaries AS s
	INNER JOIN teams AS t
    ON s.teamID = t.teamID;

-- ���� NL 
SELECT *							-- DB �ý����� ���� �÷����� ����
FROM players AS p					-- ���� players, NonClustered Index Seek
	INNER JOIN salaries AS s		-- �ܺ� salaries, Clustered Index Scan
    ON p.playerID = s.playerID
	OPTION(LOOP JOIN);

-- JOIN�� ����, �ܺ� ���� ����. players�� �ܺ�, salaries�� ����
-- ���� ��� : Salaries���� Clustered Index Scan. 
-- ���� : Index�� column �������� PlayerId�� 4��°�̱� ����
SELECT *							
FROM players AS p					
	INNER JOIN salaries AS s		
    ON p.playerID = s.playerID
	OPTION(FORCE ORDER, LOOP JOIN);