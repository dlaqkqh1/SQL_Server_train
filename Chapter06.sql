use AdventureWorks;
select top(5000) * from Sales.SalesOrderDetail tablesample(5 percent);	-- with ties는 마지막 출력값과 중복되는 값또 출력 

use sqlDB;
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS	-- OFFSET은 지정된 행만큼 건너 뛴 후에 출력
	FETCH NEXT 3 ROWS ONLY;	-- FECTH는 지정된 행만큼 출력

SELECT * INTO buyTbl3 FROM buyTbl;
SELECT * FROM buyTbl3;
