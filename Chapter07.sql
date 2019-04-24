use sqlDB;

select distinct addr,
PERCENTILE_CONT(0.5) within group (order by height) over (partition by addr)
	-- PERCENTILE_CONT(백분율) WITHIN GROUP(ORDER BY 칼럼) ORVER (PARTITION BY 칼럼)
from userTbl;

USE tempdb;
CREATE TABLE pivotTest
(uName NCHAR(3),
season NCHAR(2),
amount INT);

INSERT INTO pivotTest VALUES
('김범수', '겨울', 10), ('윤종신', '여름', 15), ('김범수', '가을', 25),
('김범수', '봄', 3), ('김범수', '봄', 37), ('윤종신', '겨울', 40),
('김범수', '여름', 14), ('김범수', '겨울', 22), ('윤종신', '여름', 64);
SELECT * FROM pivotTest;

SELECT * FROM pivotTest	-- pivot 함수
PIVOT (SUM(amount)
	FOR season
	IN ([봄],[여름],[가을],[겨울])) AS resultPivot;
GO

USE sqlDB;
SELECT name, height FROM userTbl	-- 값 JSON으로 출력
WHERE height >= 180
FOR JSON AUTO;
GO

DECLARE @json VARCHAR(MAX)
SET @json=N'{"userTBL" : 
	[
		{"name":"임재범","height":182},
		{"name":"이승기","height":182},
		{"name":"성시경","height":186}
	]
}'
SELECT ISJSON(@json);							-- 파일 형식이 JSON인지 TURE 1 FALSE 0
SELECT JSON_QUERY(@json, '$.userTBL[0]');		-- JSON 데이터 중 하나의 행을 추출
SELECT JSON_VALUE(@json, '$.userTBL[0].name');	-- 속성 값 추출
SELECT * FROM OPENJSON(@json, '$.userTBL')		-- JSON을 테이블처럼 사용 가능
WITH(
	name NCHAR(8)	'$.name',
	height INT		'$.height');
GO

DECLARE @var1 INT	-- @var1 변수선언
SET @var1 = 100		-- 변수에 값 대입

IF @var1 = 100		-- 만약 @var1이 100이라면,
	BEGIN
		PRINT '@var1이 100이다'
	END
ELSE
	BEGIN
		PRINT '@var1이 100이 아니다.'
	END
GO

USE AdventureWorks

DECLARE @hireDATE SMALLDATETIME	-- 입사일
DECLARE @curDATE SMALLDATETIME	-- 오늘
DECLARE @years DECIMAL(5,2)	-- 근속한 년수
DECLARE @days INT	-- 근무한 일수

SELECT @hireDATE = HireDATE	-- HireDATE 열의 결과를 @hireDATE에 대입
FROM HumanResources.Employee
WHERE BusinessEntityID = 111

SET	@curDATE = GETDATE()	-- 현재 날짜
SET @years = DATEDIFF(year, @hireDATE, @curDATE)	-- 날짜의 차이, 년 단위
SET @days = DATEDIFF(day, @hireDATE, @curDATE)	-- 날짜의 차이, 일 단위

IF (@years >= 5)
	BEGIN
		PRINT N'입사한 지 ' + CAST(@days AS NCHAR(5)) + N'일이나 지났습니다.'
		PRINT N'축하합니다.'
	END
ELSE
	BEGIN
		PRINT N'입사한 지 ' + CAST(@days AS NCHAR(5)) + N'일밖에 안됬네요.'
		PRINT N'열심히 일하세요.'
	END