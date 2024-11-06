------- smgBoard --------

CREATE TABLE smgBoard(
	boardIdx INT PRIMARY KEY, --1씩 증가할거임: COALSCE..
	memID VARCHAR(50) NOT NULL,
	title VARCHAR(200) NOT NULL,
	content VARCHAR(2000) NOT NULL,
	writer VARCHAR(30) NOT NULL,
	indate TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP, -- 작성 시각 (타임존 포함) --TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
	count INT DEFAULT 0,
	boardAvailable BOOLEAN DEFAULT TRUE, --원글이 삭제되었는지 여부 
	CONSTRAINT fk_member_board FOREIGN KEY (memID) REFERENCES smgMember(memID) ON DELETE CASCADE
);
-- 최적화: 그룹과 시퀀스를 기준으로 정렬하는 인덱스
CREATE INDEX idx_board_group_seq ON smgBoard (boardGroup, boardSequence);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--좋아요 테이블(좋/싫)
CREATE TABLE boardLike(
	likeIdx SERIAL PRIMARY KEY,
	boardIdx INT REFERENCES smgBoard(boardIdx) ON DELETE CASCADE,
	memIdx INT REFERENCES smgMember(memIdx) ON DELETE CASCADE,
	reaction VARCHAR(10) CHECK (reaction IN ('like', 'dislike')),
	UNIQUE (boardIdx, memIdx)
);

--댓글 테이블
CREATE TABLE smgComment(
	commentIdx SERIAL PRIMARY KEY,
	memID VARCHAR(50) NOT NULL,
	memName VARCHAR(50) NOT NULL,
	comment VARCHAR(500) NOT NULL,
	boardIdx INT NOT NULL,
	commentGroup INT NOT NULL,
	parentIdx INT DEFAULT NULL, -- 대댓글일 경우 부모 댓글 ID (자신과의 관계)
	indate TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	commentAvailable BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_member_comment FOREIGN KEY (memID) REFERENCES smgMember(memID) ON DELETE SET DEFAULT, --댓글단 회원 탈퇴시, 댓글은 기본값으로.. (0, "탈퇴한 회원") 
	CONSTRAINT fk_board_comment FOREIGN KEY (boardIdx) REFERENCES smgBoard(boardIdx) ON DELETE CASCADE,
	CONSTRAINT fk_parent_comment FOREIGN KEY (parentIdx) REFERENCES smgComment(commentIdx) ON DELETE CASCADE -- 부모 댓글 외래 키
);

ALTER TABLE smgComment ADD COLUMN memName VARCHAR(50) NOT NULL;




--SELECT IFNULL(MAX(boardIdx)+1, 1) FROM tblBoard; --> MySql 방식 
SELECT COALESCE(MAX(boardIdx)+1, 1) FROM tblBoard; --postgresql 방식 
 
-----------------------------------------------------------------------------------------------------------
------ smgMember -----------

CREATE TABLE smgMember(
	memIdx INT NOT NULL ,
	memID VARCHAR(50) DEFAULT 'deleted' NOT NULL UNIQUE,
	memPwd VARCHAR(200) NOT NULL,
	memName VARCHAR(50) NOT NULL,
	memEmail VARCHAR(50) DEFAULT NULL,
	memProfile VARCHAR(300) DEFAULT 'defaultProfile.jpg' NOT NULL,
	is_active BOOLEAN DEFAULT TRUE,
	memAddr VARCHAR(100) DEFAULT NULL,
	latitude DECIMAL (13,10), --위도 
	longitude DECIMAL (13,10), --경도 
	PRIMARY KEY(memIdx)
);

INSERT INTO smgMember (memIdx, memID, memPwd, memName, memEmail, memProfile, is_active, memAddr, latitude, longitude) 
VALUES (0, 'deleted', 'ssy917', '탈퇴한 회원', NULL, 'defaultProfile.jpg', FALSE, NULL, 0, 0);

ALTER TABLE smgMember ALTER COLUMN memPwd TYPE VARCHAR(200), ALTER COLUMN memPwd SET NOT NULL;

------ authVO -----------

CREATE TABLE smgAuth(
	num SERIAL PRIMARY KEY NOT NULL,
	memID VARCHAR(50) NOT NULL,
	auth VARCHAR(50) DEFAULT 'ROLE_READ' NOT NULL,
	CONSTRAINT fk_smgAuth FOREIGN KEY (memID) REFERENCES smgMember(memID) ON DELETE CASCADE
);

UPDATE smgAuth SET auth = 'ROLE_MANAGER' WHERE memID = 'ningning';
INSERT INTO smgAuth VALUES (DEFAULT, 'winter', 'ROLE_WRITE');

-- 임시 데이터 주입 ------------------------------------------------------------------------------------------

SELECT * FROM smgBoard ORDER BY indate LIMIT 10 OFFSET 0;
SELECT * FROM smgBoard ORDER BY indate LIMIT 10 OFFSET 10;

