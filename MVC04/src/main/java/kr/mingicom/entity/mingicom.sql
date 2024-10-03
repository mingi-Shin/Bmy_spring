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

select * from myboard order by idx desc;
UPDATE myboard SET memID = 'shinmingi01' WHERE writer = '윈터';
UPDATE myboard SET memID = 'shinmingi02' WHERE writer = '카리나';
UPDATE myboard SET memID = 'shinmingi03' WHERE writer = '닝닝';

CREATE TABLE mem_tbl(
	memIdx INT auto_increment PRIMARY KEY,
	memID VARCHAR(20) NOT NULL,
	memPassword VARCHAR(20) NOT NULL,
	memName VARCHAR(20) NOT NULL,
	memAge INT DEFAULT 0,
	memGender VARCHAR(20),
	memEmail VARCHAR(50),
	memProfile VARCHAR(300) DEFAULT NULL
);
INSERT INTO mem_tbl (memID, memPassword, memName, memAge, memGender, memEmail) VALUES (
	'shinmingi01', 'tlsalsrl4260!', '윈터', 20, 'female', 's1@gmail.com'	
);

ALTER TABLE mem_tbl MODIFY COLUMN memProfile VARCHAR(300);

SELECT * FROM mem_tbl;

DELETE FROM mem_tbl WHERE memIdx = 2;

TRUNCATE TABLE mem_tbl;

SELECT M.memID, M.memName, M.memEmail, B.title, B.writer, B.indate FROM mem_tbl M JOIN myboard B ON M.memID = B.memID WHERE M.memID = 'test02'; 

UPDATE mem_tbl M SET memProfile = "";
