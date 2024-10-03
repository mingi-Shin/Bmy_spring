CREATE TABLE myboard(
	idx int not null auto_increment,
	memID varchar(50) not null,
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default now(),
	count int default 0,
	primary key(idx),
	CONSTRAINT fk_member_board FOREIGN KEY (memID) REFERENCES mem_stbl(memID)
);

CREATE TABLE mem_stbl(
	memIdx INT NOT NULL ,
	memID VARCHAR(50) NOT NULL PRIMARY KEY,
	memPassword VARCHAR(68) NOT NULL,
	memName VARCHAR(30) NOT NULL,
	memAge INT DEFAULT 0,
	memGender VARCHAR(20),
	memEmail VARCHAR(50),
	memProfile VARCHAR(300) DEFAULT NULL,
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE mem_auth(
	no INT PRIMARY KEY NOT NULL auto_increment,
	memID VARCHAR(50) NOT NULL,
	auth VARCHAR(50) NOT NULL,
	CONSTRAINT fk_member_auth FOREIGN KEY (memID) REFERENCES mem_stbl(memID)
);


