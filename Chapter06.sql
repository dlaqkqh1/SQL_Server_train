use AdventureWorks;
select top(5000) * from Sales.SalesOrderDetail tablesample(5 percent);	-- with ties�� ������ ��°��� �ߺ��Ǵ� ���� ���
GO 

use sqlDB;
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS	-- OFFSET�� ������ �ุŭ �ǳ� �� �Ŀ� ���
	FETCH NEXT 3 ROWS ONLY;	-- FECTH�� ������ �ุŭ ���
GO

USE sqlDB;
GO
WITH cte_userTbl(addr, maxHeihgt)	-- ������� CTE�� ����
AS
(select addr, MAX(height) FROM userTbl GROUP BY addr)
SELECT AVG(maxHeihgt*1.0) AS [���� ������ �ְ�Ű�� ���] FROM cte_userTbl;
GO

WITH	-- ������� �ߺ� CTE�� ����
AAA (userID, total)
	AS
		(SELECT userID, SUM(price*amount) FROM buyTbl GROUP BY userID),
BBB (sumtotal)
	AS
		(SELECT SUM(total) FROM AAA),
CCC(sumavg)
	AS
		(SELECT sumtotal / (SELECT COUNT(*) FROM buyTbl) FROM BBB)
SELECT * FROM CCC;
GO

CREATE TABLE empTbl (emp NCHAR(3), manager NCHAR(3), department NCHAR(3));
GO

INSERT INTO empTbl VALUES('������', NULL, NULL);
INSERT INTO empTbl VALUES('���繫', '������', '�繫��');
INSERT INTO empTbl VALUES('�����', '���繫', '�繫��');
INSERT INTO empTbl VALUES('�̺���', '���繫', '�繫��');
INSERT INTO empTbl VALUES('��븮', '�̺���', '�繫��');
INSERT INTO empTbl VALUES('�����', '�̺���', '�繫��');
INSERT INTO empTbl VALUES('�̿���', '������', '������');
INSERT INTO empTbl VALUES('�Ѱ���', '�̿���', '������');
INSERT INTO empTbl VALUES('������', '������', '������');
INSERT INTO empTbl VALUES('������', '������', '������');
INSERT INTO empTbl VALUES('������', '������', '������');
GO

WITH empCTE(empName, mgrName, dept, level)
AS
(
	SELECT emp, manager, department, 0
		FROM empTbl
		WHERE manager IS NULL
	UNION ALL
	SELECT	empTbl.emp, empTbl.manager, empTbl.department, empCTE.level+1
 	FROM empTbl INNER JOIN empCTE
		ON empTbl.manager = empCTE.empName
)
SELECT replicate(' ��', level) + empName AS [�����̸�], dept [�����μ�]
FROM empCTE ORDER BY dept, level;

EXECUTE sp_tables [@table_type = 'table'];