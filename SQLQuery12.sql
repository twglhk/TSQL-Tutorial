
SELECT *
FROM [BaseballData].dbo.salaries

SELECT *
FROM [BaseballData].dbo.salaries
ORDER BY salary DESC

SELECT *
FROM BaseballData.dbo.salaryT

SELECT * 
FROM BaseballData.dbo.players
WHERE playerID IN (SELECT TOP(1) playerID FROM BaseballData.dbo.salaries ORDER BY salary DESC)

SELECT (SELECT TOP 1 salary FROM [BaseballData].dbo.salaries ORDER BY salary DESC) AS TopSalary

UPDATE BaseballData.dbo.salaries
SET salary = 50000000
WHERE playerID = 'LENO'

INSERT INTO BaseballData.dbo.salaryT
VALUES (2021, 'ARS', 'PL', 'LENO', 100000)

INSERT INTO BaseballData.dbo.salaries
VALUES (2021, 'ARS', 'PL', 'Sanchez', (SELECT MAX(salary) FROM BaseballData.dbo.salaries) * 2)

INSERT INTO BaseballData.dbo.salaryT
VALUES ('Ozil', 20000000)

DELETE FROM BaseballData.dbo.salaryTemp

INSERT INTO BaseballData.dbo.salaryT
SELECT yearId, teamID, lgID, playerID, salary FROM BaseballData.dbo.salaries

SELECT *
FROM BaseballData.dbo.players
WHERE playerID IN (SELECT playerID FROM BaseballData.dbo.salaries)

SELECT *
FROM BaseballData.dbo.players
WHERE EXISTS (SELECT playerID FROM BaseballData.dbo.salaries WHERE salaries.playerID = playerID)