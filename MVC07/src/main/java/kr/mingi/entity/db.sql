-- tblBoard --

CREATE TABLE tblBoard(
	boardIdx INT NOT NULL, --1씩 증가할거임 
	memID VARCHAR(50) NOT NULL,
	title VARCHAR(200) NOT NULL,
	content VARCHAR(2000) NOT NULL,
	writer VARCHAR(30) NOT NULL,
	indate TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
	count INT DEFAULT 0,
	-- 댓글기능 추가 --
	boardGroup INT, --원글과 댓글 묶기, 1씩 증가할거임 
	boardSequence INT, --댓글 순
	boardLevel INT, --들여쓰기 속성 
	boardAvailable INT, --원글이 삭제되었는지 여부 
	PRIMARY KEY(boardIdx)
);

SELECT * FROM tblBoard;
--SELECT IFNULL(MAX(boardIdx)+1, 1) FROM mem_stbl; --> MySql 방식 
SELECT COALESCE(MAX(boardIdx)+1, 1) FROM tblBoard; --postgresql 방식 
 
TRUNCATE TABLE tblBoard; --TURNCATE : 자르기

SELECT * FROM tblBoard;
-----------------------------------------------------------------------------------------------------------
CREATE TABLE tblMember(
	memID VARCHAR(50) NOT NULL,
	memPwd VARCHAR(50) NOT NULL,
	memName VARCHAR(50) NOT NULL,
	memPhone VARCHAR(50) NOT NULL,
	memAddr VARCHAR(100),
	latitude DECIMAL (13,10), --위도 
	longitude DECIMAL (13,10), --경도 
	PRIMARY KEY(memID)
);

SELECT * FROM tblMember;

-- 임시 데이터 주입 ------------------------------------------------------------------------------------------
INSERT INTO tblMember(memID, memPwd, memName, memPhone) VALUES('admin','ssy917','신민기','010-1111-1111');
INSERT INTO tblMember(memID, memPwd, memName, memPhone) VALUES('winter','ssy917','윈터','010-2222-2222');
INSERT INTO tblMember(memID, memPwd, memName, memPhone) VALUES('karina','ssy917','카리나','010-3333-3333');

INSERT INTO tblBoard 
SELECT COALESCE(MAX(BoardIdx)+1, 1), 'admin', 'testTitle01', 'testContent123', '신민기', NOW(), 0,
COALESCE(MAX(boardGroup) +1, 0), 0, 0, 1
FROM tblBoard;
INSERT INTO tblBoard 
SELECT COALESCE(MAX(BoardIdx)+1, 1), 'winter', 'testTitle02', 'testContent456', '윈터', NOW(), 0,
COALESCE(MAX(boardGroup) +1, 0), 0, 0, 1
FROM tblBoard;
INSERT INTO tblBoard 
SELECT COALESCE(MAX(BoardIdx)+1, 1), 'karina', 'testTitle03', 'testContent789', '카리나', NOW(), 0,
COALESCE(MAX(boardGroup) +1, 0), 0, 0, 1
FROM tblBoard;