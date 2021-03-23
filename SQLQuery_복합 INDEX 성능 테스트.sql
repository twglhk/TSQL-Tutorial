-- ���̺� ���� ����
SELECT *
INTO TestOrders
FROM Orders;

-- �׽�Ʈ ������ ����
DECLARE @i INT = 1;
DECLARE @emp INT;
SELECT @emp = MAX(EmployeeID) FROM Orders;

-- ���� ������ �ø���
WHILE (@i < 1000)
BEGIN 
	INSERT INTO TestOrders(CustomerID, EmployeeID, OrderDate)
    SELECT CustomerID, @emp + @i, OrderDate
    FROM Orders;
	SET @i = @i + 1;
END

-- ������ ���� Ȯ��
SELECT COUNT(*)
FROM TestOrders;

-- NON-CLUSTERED INDEX1 ����
CREATE NONCLUSTERED INDEX idx_emp_ord
ON TestOrders(EmployeeID, OrderDate);

-- NON-CLUSTERED INDEX2 ����
CREATE NONCLUSTERED INDEX idx_ord_emp
ON TestOrders(OrderDate, EmployeeID);

-- �м� ON
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- �ε���1�� ����ؼ� ��Ī
SELECT *
FROM TestOrders WITH(INDEX(idx_emp_ord))
WHERE EmployeeID = 1 AND OrderDate = CONVERT(DATETIME, '19970101');

-- �ε���2�� ����ؼ� ��Ī
SELECT *
FROM TestOrders WITH(INDEX(idx_ord_emp))
WHERE EmployeeID = 1 AND OrderDate = CONVERT(DATETIME, '19970101');

---- ���� ��� �����ս� ����


-- ���� Ž��
-- �ε��� 1�� ����ؼ� ��Ī
SELECT *
FROM TestOrders WITH(INDEX(idx_emp_ord))
WHERE EmployeeID = 1 AND OrderDate BETWEEN '19970101' AND '19970103'
 -- OrderDate >= '19970101' AND OrderDate <= '19970103';
 
 -- �ε��� 2�� ����ؼ� ��Ī
 SELECT *
FROM TestOrders WITH(INDEX(idx_ord_emp))
WHERE EmployeeID = 1 AND OrderDate BETWEEN '19970101' AND '19970103'
 -- OrderDate >= '19970101' AND OrderDate <= '19970103';
 
 -- ���� ���, �ε���1 ���� �б� 5 < �ε���2 ���� �б� 16
 
 
-- ��ȸ
-- EmployeeID�� 1�� �ɼ����� ����, ��Ī ������ ����
SELECT *
FROM TestOrders
ORDER BY EmployeeID, OrderDate;

-- OrderDate�� 1�� �ɼ����� ����, ��Ī ������ ����
SELECT *
FROM TestOrders
ORDER BY OrderDate, EmployeeID;

-- IN-LIST 
SELECT *
FROM TestOrders WITH(INDEX(idx_ord_emp))
WHERE EmployeeID = 1 AND OrderDate IN('19970101', '19970102', '19970103');