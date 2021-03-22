USE BaseballData

--CREATE INDEX PK_playerID ON dbo.salaryT(playerID)

--DROP INDEX dbo.salaryT.PK_playerID

--CREATE CLUSTERED INDEX PK_playerID ON dbo.salaryT(playerID)

ALTER TABLE dbo.salaryT 
ALTER COLUMN playerID varchar(9) NOT NULL 

ALTER TABLE dbo.salaryT
ADD CONSTRAINT PK_playerID PRIMARY KEY(playerID) 