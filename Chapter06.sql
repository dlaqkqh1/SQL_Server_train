use AdventureWorks;
select top(5000) * from Sales.SalesOrderDetail tablesample(5 percent);	-- with ties�� ������ ��°��� �ߺ��Ǵ� ���� ��� 

use sqlDB;
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS	-- OFFSET�� ������ �ุŭ �ǳ� �� �Ŀ� ���
	FETCH NEXT 3 ROWS ONLY;	-- FECTH�� ������ �ุŭ ���

SELECT * INTO buyTbl3 FROM buyTbl;
SELECT * FROM buyTbl3;
