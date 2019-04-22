INSERT INTO memberTBL VALUES ('Figure', '연아', '경기도 군포시 당정동');
SELECT * FROM memberTBL

DELETE memberTBL WHERE memberName = '연아';

CREATE TABLE deletedMemberTBL
(	memberID char(8),
	memberName nchar(5),
	memberAddress nchar(20),
	deletedDate date -- 삭제한 날짜
);

CREATE TRIGGER trg_deletedMemberTBL
ON memberTBL -- 트리거를 부착할 테이블
AFTER DELETE -- 삭제 후에 작동하게 지정
AS
	-- deleted 테이블의 내용을 백업테이블에 삽입
	INSERT INTO deletedMemberTBL
		SELECT memberID, memberName, memberAddress, GETDATE() FROM deleted;

SELECT * FROM memberTBL;

DELETE memberTBL WHERE memberName = '당탕이';

SELECT * FROM memberTBL;
SELECT * FROM deletedMemberTBL;