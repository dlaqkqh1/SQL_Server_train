INSERT INTO memberTBL VALUES ('Figure', '����', '��⵵ ������ ������');
SELECT * FROM memberTBL

DELETE memberTBL WHERE memberName = '����';

CREATE TABLE deletedMemberTBL
(	memberID char(8),
	memberName nchar(5),
	memberAddress nchar(20),
	deletedDate date -- ������ ��¥
);

CREATE TRIGGER trg_deletedMemberTBL
ON memberTBL -- Ʈ���Ÿ� ������ ���̺�
AFTER DELETE -- ���� �Ŀ� �۵��ϰ� ����
AS
	-- deleted ���̺��� ������ ������̺� ����
	INSERT INTO deletedMemberTBL
		SELECT memberID, memberName, memberAddress, GETDATE() FROM deleted;

SELECT * FROM memberTBL;

DELETE memberTBL WHERE memberName = '������';

SELECT * FROM memberTBL;
SELECT * FROM deletedMemberTBL;