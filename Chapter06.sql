use AdventureWorks;
select top(5000) * from Sales.SalesOrderDetail tablesample(5 percent);	-- with ties는 마지막 출력값과 중복되는 값또 출력
GO 

use sqlDB;
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS	-- OFFSET은 지정된 행만큼 건너 뛴 후에 출력
	FETCH NEXT 3 ROWS ONLY;	-- FECTH는 지정된 행만큼 출력
GO

USE sqlDB;
GO
WITH cte_userTbl(addr, maxHeihgt)	-- 비재귀적 CTE절 예제
AS
(select addr, MAX(height) FROM userTbl GROUP BY addr)
SELECT AVG(maxHeihgt*1.0) AS [가가 지역별 최고키의 평균] FROM cte_userTbl;
GO

WITH	-- 비재귀적 중복 CTE절 예제
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

INSERT INTO empTbl VALUES('나사장', NULL, NULL);
INSERT INTO empTbl VALUES('김재무', '나사장', '재무부');
INSERT INTO empTbl VALUES('김부장', '김재무', '재무부');
INSERT INTO empTbl VALUES('이부장', '김재무', '재무부');
INSERT INTO empTbl VALUES('우대리', '이부장', '재무부');
INSERT INTO empTbl VALUES('지사원', '이부장', '재무부');
INSERT INTO empTbl VALUES('이영업', '나사장', '영업부');
INSERT INTO empTbl VALUES('한과장', '이영업', '영업부');
INSERT INTO empTbl VALUES('최정보', '나사장', '정보부');
INSERT INTO empTbl VALUES('윤차장', '최정보', '정보부');
INSERT INTO empTbl VALUES('이주임', '윤차장', '정보부');
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
SELECT replicate(' ㄴ', level) + empName AS [직원이름], dept [직원부서]
FROM empCTE ORDER BY dept, level;

EXECUTE sp_tables [@table_type = 'table'];