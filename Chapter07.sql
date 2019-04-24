use sqlDB;

select distinct addr,
PERCENTILE_CONT(0.5) within group (order by height) over (partition by addr)
	-- PERCENTILE_CONT(�����) WITHIN GROUP(ORDER BY Į��) ORVER (PARTITION BY Į��)
from userTbl;

USE tempdb;
CREATE TABLE pivotTest
(uName NCHAR(3),
season NCHAR(2),
amount INT);

INSERT INTO pivotTest VALUES
('�����', '�ܿ�', 10), ('������', '����', 15), ('�����', '����', 25),
('�����', '��', 3), ('�����', '��', 37), ('������', '�ܿ�', 40),
('�����', '����', 14), ('�����', '�ܿ�', 22), ('������', '����', 64);
SELECT * FROM pivotTest;

SELECT * FROM pivotTest	-- pivot �Լ�
PIVOT (SUM(amount)
	FOR season
	IN ([��],[����],[����],[�ܿ�])) AS resultPivot;
GO

USE sqlDB;
SELECT name, height FROM userTbl	-- �� JSON���� ���
WHERE height >= 180
FOR JSON AUTO;
GO

DECLARE @json VARCHAR(MAX)
SET @json=N'{"userTBL" : 
	[
		{"name":"�����","height":182},
		{"name":"�̽±�","height":182},
		{"name":"���ð�","height":186}
	]
}'
SELECT ISJSON(@json);							-- ���� ������ JSON���� TURE 1 FALSE 0
SELECT JSON_QUERY(@json, '$.userTBL[0]');		-- JSON ������ �� �ϳ��� ���� ����
SELECT JSON_VALUE(@json, '$.userTBL[0].name');	-- �Ӽ� �� ����
SELECT * FROM OPENJSON(@json, '$.userTBL')		-- JSON�� ���̺�ó�� ��� ����
WITH(
	name NCHAR(8)	'$.name',
	height INT		'$.height');
GO

DECLARE @var1 INT	-- @var1 ��������
SET @var1 = 100		-- ������ �� ����

IF @var1 = 100		-- ���� @var1�� 100�̶��,
	BEGIN
		PRINT '@var1�� 100�̴�'
	END
ELSE
	BEGIN
		PRINT '@var1�� 100�� �ƴϴ�.'
	END
GO

USE AdventureWorks

DECLARE @hireDATE SMALLDATETIME	-- �Ի���
DECLARE @curDATE SMALLDATETIME	-- ����
DECLARE @years DECIMAL(5,2)	-- �ټ��� ���
DECLARE @days INT	-- �ٹ��� �ϼ�

SELECT @hireDATE = HireDATE	-- HireDATE ���� ����� @hireDATE�� ����
FROM HumanResources.Employee
WHERE BusinessEntityID = 111

SET	@curDATE = GETDATE()	-- ���� ��¥
SET @years = DATEDIFF(year, @hireDATE, @curDATE)	-- ��¥�� ����, �� ����
SET @days = DATEDIFF(day, @hireDATE, @curDATE)	-- ��¥�� ����, �� ����

IF (@years >= 5)
	BEGIN
		PRINT N'�Ի��� �� ' + CAST(@days AS NCHAR(5)) + N'���̳� �������ϴ�.'
		PRINT N'�����մϴ�.'
	END
ELSE
	BEGIN
		PRINT N'�Ի��� �� ' + CAST(@days AS NCHAR(5)) + N'�Ϲۿ� �ȉ�׿�.'
		PRINT N'������ ���ϼ���.'
	END