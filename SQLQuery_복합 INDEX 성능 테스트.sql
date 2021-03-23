-- 테이블 복사 생성
SELECT *
INTO TestOrders
FROM Orders;

-- 테스트 데이터 선언
DECLARE @i INT = 1;
DECLARE @emp INT;
SELECT @emp = MAX(EmployeeID) FROM Orders;

-- 더미 데이터 늘리기
WHILE (@i < 1000)
BEGIN 
	INSERT INTO TestOrders(CustomerID, EmployeeID, OrderDate)
    SELECT CustomerID, @emp + @i, OrderDate
    FROM Orders;
	SET @i = @i + 1;
END

-- 데이터 갯수 확인
SELECT COUNT(*)
FROM TestOrders;

-- NON-CLUSTERED INDEX1 생성
CREATE NONCLUSTERED INDEX idx_emp_ord
ON TestOrders(EmployeeID, OrderDate);

-- NON-CLUSTERED INDEX2 생성
CREATE NONCLUSTERED INDEX idx_ord_emp
ON TestOrders(OrderDate, EmployeeID);

-- 분석 ON
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- 인덱스1을 사용해서 서칭
SELECT *
FROM TestOrders WITH(INDEX(idx_emp_ord))
WHERE EmployeeID = 1 AND OrderDate = CONVERT(DATETIME, '19970101');

-- 인덱스2를 사용해서 서칭
SELECT *
FROM TestOrders WITH(INDEX(idx_ord_emp))
WHERE EmployeeID = 1 AND OrderDate = CONVERT(DATETIME, '19970101');

---- 실행 결과 퍼포먼스 동일


-- 범위 탐색
-- 인덱스 1을 사용해서 서칭
SELECT *
FROM TestOrders WITH(INDEX(idx_emp_ord))
WHERE EmployeeID = 1 AND OrderDate BETWEEN '19970101' AND '19970103'
 -- OrderDate >= '19970101' AND OrderDate <= '19970103';
 
 -- 인덱스 2를 사용해서 서칭
 SELECT *
FROM TestOrders WITH(INDEX(idx_ord_emp))
WHERE EmployeeID = 1 AND OrderDate BETWEEN '19970101' AND '19970103'
 -- OrderDate >= '19970101' AND OrderDate <= '19970103';
 
 -- 실행 결과, 인덱스1 논리적 읽기 5 < 인덱스2 논리적 읽기 16
 
 
-- 조회
-- EmployeeID가 1번 옵션으로 정렬, 서칭 순서에 영향
SELECT *
FROM TestOrders
ORDER BY EmployeeID, OrderDate;

-- OrderDate가 1번 옵션으로 정렬, 서칭 순서에 영향
SELECT *
FROM TestOrders
ORDER BY OrderDate, EmployeeID;

-- IN-LIST 
SELECT *
FROM TestOrders WITH(INDEX(idx_ord_emp))
WHERE EmployeeID = 1 AND OrderDate IN('19970101', '19970102', '19970103');