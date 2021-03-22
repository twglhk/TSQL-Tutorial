USE Northwind

EXEC sp_helpdb 'Northwind';

EXEC sp_helpdb 'Northwind';	-- DB ���� ���

-- ���̺� CREATE
CREATE TABLE Test
(
	EmployeeID INT NOT NULL,
  	LastName   NVARCHAR(20) NULL,
  	FirstName  NVARCHAR(20) NULL,
  	HireDate   DATETIME NULL
);
GO

-- ���̺� ������ INSERT
INSERT INTO Test
SELECT EmployeeID, LastName, FirstName, HireDate
FROM Employees;

SELECT *
FROM Test;

-- INDEX CREATE
-- FILLFACTOR (���� ������ ���� 1%�� ���)
-- PAD_INDEX (FILLFACTOR �߰� ������ ����)
CREATE INDEX Test_Index ON Test(LastName)
WITH (FILLFACTOR = 1, PAD_INDEX = ON)
GO

-- �ε��� ��ȣ ã��
SELECT index_id, name
FROM sys.indexes
WHERE object_id = object_id('Test');

-- 2�� INDEX ���� ���캸��
-- ���� ��� ������ IndexLevel�� ���� ���� ���� ����. 
-- ���� ���� Level�� root
DBCC IND('Northwind', 'Test', 2);

-- �ε��� ������ Ʈ�� �����̱� ������ INDEX�� ����Ű�� 
-- �����Ͱ� ���������� ����� �����
-- Table[{Page}{Page}{Page}{Page}{Page}] ����.
-- ���� ��� ������ HEAP RID([�������ּ�(4)][����ID(2)][���Թ�ȣ(2)])�� 8byte
-- ������ ROW �ĺ���. ���̺��� ���� �����ϱ� ���� ������. 
-- RID���� ���� ������ �ִ� �ּ�
-- ���� INDEX�� ���� �ش� ������ ã��, �ű⼭ RID�� Ȯ���� �� 
-- ���� ����� ������ �����ϴ� ���� INDEX�� �����ϴ� ���
DBCC PAGE('Northwind', 1/* ���Ϲ�ȣ */, 832 /*��������ȣ*/, 3 /*��¿ɼ�*/);
DBCC PAGE('Northwind', 1/* ���Ϲ�ȣ */, 840 /*��������ȣ*/, 3 /*��¿ɼ�*/);
DBCC PAGE('Northwind', 1/* ���Ϲ�ȣ */, 841 /*��������ȣ*/, 3 /*��¿ɼ�*/);

DBCC PAGE('Northwind', 1/* ���Ϲ�ȣ */, 872 /*��������ȣ*/, 3 /*��¿ɼ�*/);
DBCC PAGE('Northwind', 1/* ���Ϲ�ȣ */, 848 /*��������ȣ*/, 3 /*��¿ɼ�*/);
DBCC PAGE('Northwind', 1/* ���Ϲ�ȣ */, 849 /*��������ȣ*/, 3 /*��¿ɼ�*/);

-- INDEX�� ��Ī�ϴ� �Ϳ��� ũ�� 2���� �۾��� �����
-- Random Access (�� �� �б� ���� �� �������� ����. 
-- 				 INDEX�� ���� ���ϴ� �����Ϳ� ����)
-- Bookmark Lookup (RID�� ���� ���� ã�� ��. RID�� ���� ���� �࿡ �����ϴ� ��)