USE Northwind

EXEC sp_helpdb 'Northwind';

EXEC sp_helpdb 'Northwind';	-- DB 정보 얻기

-- 테이블 CREATE
CREATE TABLE Test
(
	EmployeeID INT NOT NULL,
  	LastName   NVARCHAR(20) NULL,
  	FirstName  NVARCHAR(20) NULL,
  	HireDate   DATETIME NULL
);
GO

-- 테이블에 데이터 INSERT
INSERT INTO Test
SELECT EmployeeID, LastName, FirstName, HireDate
FROM Employees;

SELECT *
FROM Test;

-- INDEX CREATE
-- FILLFACTOR (리프 페이지 공간 1%만 사용)
-- PAD_INDEX (FILLFACTOR 중간 페이지 적용)
CREATE INDEX Test_Index ON Test(LastName)
WITH (FILLFACTOR = 1, PAD_INDEX = ON)
GO

-- 인덱스 번호 찾기
SELECT index_id, name
FROM sys.indexes
WHERE object_id = object_id('Test');

-- 2번 INDEX 정보 살펴보기
-- 쿼리 결과 나오는 IndexLevel은 높을 수록 층이 높음. 
-- 가장 높은 Level이 root
DBCC IND('Northwind', 'Test', 2);

-- 인덱스 구조가 트리 구조이긴 하지만 INDEX가 가리키는 
-- 데이터가 물리적으로 저장된 방식은
-- Table[{Page}{Page}{Page}{Page}{Page}] 형태.
-- 쿼리 결과 나오는 HEAP RID([페이지주소(4)][파일ID(2)][슬롯번호(2)])의 8byte
-- 조합한 ROW 식별자. 테이블에서 정보 추출하기 위한 데이터. 
-- RID값이 실제 정보가 있는 주소
-- 따라서 INDEX를 통해 해당 정보를 찾고, 거기서 RID를 확인한 뒤 
-- 실제 저장된 정보에 접근하는 것이 INDEX가 동작하는 방식
DBCC PAGE('Northwind', 1/* 파일번호 */, 832 /*페이지번호*/, 3 /*출력옵션*/);
DBCC PAGE('Northwind', 1/* 파일번호 */, 840 /*페이지번호*/, 3 /*출력옵션*/);
DBCC PAGE('Northwind', 1/* 파일번호 */, 841 /*페이지번호*/, 3 /*출력옵션*/);

DBCC PAGE('Northwind', 1/* 파일번호 */, 872 /*페이지번호*/, 3 /*출력옵션*/);
DBCC PAGE('Northwind', 1/* 파일번호 */, 848 /*페이지번호*/, 3 /*출력옵션*/);
DBCC PAGE('Northwind', 1/* 파일번호 */, 849 /*페이지번호*/, 3 /*출력옵션*/);

-- INDEX로 서칭하는 것에는 크게 2가지 작업이 수행됨
-- Random Access (한 건 읽기 위해 한 페이지씩 접근. 
-- 				 INDEX를 통해 원하는 데이터에 접근)
-- Bookmark Lookup (RID를 통해 행을 찾는 것. RID를 통해 실제 행에 접근하는 것)