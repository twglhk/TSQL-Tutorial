

INSERT INTO [BaseballData].dbo.salaries 
VALUES (2021, 'ARS', 'PL', 'Humba', 10000)

INSERT INTO [BaseballData].dbo.salaries (teamID, yearID, lgID, playerID, salary)
VALUES ('LIV', 2021, 'PL', 'Humba', 10000)

UPDATE [BaseballData].dbo.salaries
SET salary = salary * 100
WHERE lgID = 'PL'

DELETE FROM BaseballData.dbo.salaries
WHERE lgID = 'PL'

SELECT *
FROM [BaseballData].dbo.salaries
ORDER BY yearID DESC
