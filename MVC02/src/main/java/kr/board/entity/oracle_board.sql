create table myboard(
idx number not null,
title varchar2(100) not null,
content varchar2(2000) not null,
writer varchar2(30) not null,
indate date default sysdate,
count number default 0,
primary key(idx)
);

create sequence myboard_idx;


insert into myboard(idx, title, content, writer)
values(myboard_idx.nextval, '스프링게시판','스프링게시판','관리자');
insert into myboard(idx, title, content, writer)
values(myboard_idx.nextval, '스프링게시판','스프링게시판','박매일');
