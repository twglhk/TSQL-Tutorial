USE Northwind;

-- Hash Join

SELECT * INTO TestOrders FROM Orders;
SELECT * INTO TestCustomers FROM Customers;

SELECT * FROM TestOrders;		-- 830
SELECT * FROM TestCustomers;	-- 91

-- 실행 결과 : NL (inner table에 index가 없는 것이 문제)
SELECT *
FROM TestOrders AS o
	INNER JOIN TestCustomers AS c
	ON o.CustomerID = c.CustomerID
	OPTION (FORCE ORDER, LOOP JOIN);

-- 실행 결과 : Merge (outer, inner 모두 sort => many-to-many)
SELECT *
FROM TestOrders AS o
	INNER JOIN TestCustomers AS c
	ON o.CustomerID = c.CustomerID
	OPTION (FORCE ORDER, MERGE JOIN);

-- 실행 결과 : Hash Join
-- 데이터가 적은 쪽을 Hash table을 만드는 것이 좋음.
-- Hash table 만드는 것에서 오버헤드
SELECT *
FROM TestOrders AS o
	INNER JOIN TestCustomers AS c
	ON o.CustomerID = c.CustomerID;
