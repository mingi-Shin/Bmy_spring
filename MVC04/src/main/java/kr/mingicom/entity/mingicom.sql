create table myboard(
	idx int not null auto_increment,
	memID varchar(100) not null,
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default now(),
	count int default 0,
	primary key(idx)
);

drop table myboard;

insert into myboard(title,content,writer)
values('게시판 연습','게시판 연습','관리자');

insert into myboard(title,content,writer)
values('게시판 연습','게시판 연습','박매일');

insert into myboard(title,content,writer)
values('게시판 연습','게시판 연습','선생님');

select * from myboard order by idx desc;

DELETE FROM myboard WHERE idx >= 13;

SELECT * FROM news;


CREATE TABLE mem_tbl(
	memIdx INT auto_increment PRIMARY KEY,
	memID VARCHAR(20) NOT NULL,
	memPassword VARCHAR(20) NOT NULL,
	memName VARCHAR(20) NOT NULL,
	memAge INT DEFAULT 0,
	memGender VARCHAR(20),
	memEmail VARCHAR(50),
	memProfile VARCHAR(300)
);

ALTER TABLE mem_tbl MODIFY COLUMN memProfile VARCHAR(300);

TRUNCATE TABLE mem_tbl;

INSERT INTO mem_tbl (memID, memPassword, memName)VALUES('testID', 'testPassword1234', 'testUser');

SELECT * FROM mem_tbl WHERE memProfile = '%E1%84%8F%E1%85%A1%E1%84%85%E1%85%B5%E1%84%82%E1%85%A1.jpeg';

SELECT * FROM mem_tbl WHERE memID = 'shinmingi01' AND memPassword = 'tlsalsrl4260!';

TRUNCATE TABLE mem_tbl;

SELECT M.memID, M.memName, M.memEmail, B.title, B.writer, B.indate FROM mem_tbl M JOIN myboard B ON M.memID = B.memID WHERE M.memID = 'test02'; 

UPDATE mem_tbl M SET memProfile = "";
