------- smgBoard --------

CREATE TABLE smgBoard(
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
	PRIMARY KEY(boardIdx),
	CONSTRAINT fk_member_board FOREIGN KEY (memID) REFERENCES smgMember(memID)
);



SELECT * FROM smgBoard;
--SELECT IFNULL(MAX(boardIdx)+1, 1) FROM tblBoard; --> MySql 방식 
SELECT COALESCE(MAX(boardIdx)+1, 1) FROM tblBoard; --postgresql 방식 
 
TRUNCATE TABLE tblBoard; --TURNCATE : 자르기
DELETE FROM tblBoard WHERE memID NOT IN (SELECT memID FROM smgMember);

-----------------------------------------------------------------------------------------------------------
------ smgMember -----------

CREATE TABLE smgMember(
	memIdx INT NOT NULL ,
	memID VARCHAR(50) NOT NULL UNIQUE,
	memPwd VARCHAR(50) NOT NULL,
	memName VARCHAR(50) NOT NULL,
	memEmail VARCHAR(50) DEFAULT NULL,
	memProfile VARCHAR(300) DEFAULT 'default_profile.png' NOT NULL,
	is_active BOOLEAN DEFAULT TRUE,
	memAddr VARCHAR(100) DEFAULT NULL,
	latitude DECIMAL (13,10), --위도 
	longitude DECIMAL (13,10), --경도 
	PRIMARY KEY(memIdx)
);

SELECT * FROM smgMember;
DELETE FROM smgMember WHERE memID = 'ningning';

ALTER TABLE smgMember ALTER COLUMN memPwd TYPE VARCHAR(200), ALTER COLUMN memPwd SET NOT NULL;
ALTER TABLE smgMember ALTER COLUMN memProfile TYPE VARCHAR(300), ALTER COLUMN memProfile SET DEFAULT 'default_profile.png';

------ authVO -----------

CREATE TABLE smgAuth(
	num SERIAL PRIMARY KEY NOT NULL,
	memID VARCHAR(50) NOT NULL,
	auth VARCHAR(50) DEFAULT 'ROLE_READ' NOT NULL,
	CONSTRAINT fk_smgAuth FOREIGN KEY (memID) REFERENCES smgMember(memID)
);

UPDATE smgAuth SET auth = 'ROLE_MANAGER' WHERE memID = 'ningning';
DELETE FROM smgAuth WHERE memID = 'ningning';
INSERT INTO smgAuth VALUES (DEFAULT, 'ningning', 'ROLE_MANAGER');

-- 임시 데이터 주입 ------------------------------------------------------------------------------------------
INSERT INTO smgMember
SELECT COALESCE(MAX(memIdx)+1, 1),'admin','ssy917','신민기','010-1111-1111'
FROM smgMember;
INSERT INTO smgMember
SELECT COALESCE(MAX(memIdx)+1, 1),'winter','ssy917','윈터','010-2222-2222'
FROM smgMember;
INSERT INTO smgMember
SELECT COALESCE(MAX(memIdx)+1, 1),'karina','ssy917','카리나','010-3333-3333'
FROM smgMember;


INSERT INTO smgBoard 
SELECT COALESCE(MAX(BoardIdx)+1, 1), 'admin', 'testTitle01', 'testContent123', '신민기', NOW(), 0,
COALESCE(MAX(boardGroup) +1, 0), 0, 0, 1
FROM smgBoard;
INSERT INTO smgBoard 
SELECT COALESCE(MAX(BoardIdx)+1, 1), 'winter', 'testTitle02', 'testContent456', '윈터', NOW(), 0,
COALESCE(MAX(boardGroup) +1, 0), 0, 0, 1
FROM smgBoard;
INSERT INTO smgBoard 
SELECT COALESCE(MAX(BoardIdx)+1, 1), 'karina', 'testTitle03', 'testContent789', '카리나', NOW(), 0,
COALESCE(MAX(boardGroup) +1, 0), 0, 0, 1
FROM smgBoard;
