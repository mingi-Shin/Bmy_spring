create table myboard(
	idx int not null auto_increment,
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default now(),
	count int default 0,
	primary key(idx)
);

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
	memAge INT,
	memGender VARCHAR(20),
	memEmail VARCHAR(50),
	memProfile VARCHAR(50)
);

SHOW COLUMNS FROM mem_tbl;

INSERT INTO mem_tbl (memID, memPassword, memName)VALUES('testID', 'testPassword1234', 'testUser');
SELECT * FROM mem_tbl;

SELECT * FROM mem_tbl WHERE memID = 'av';