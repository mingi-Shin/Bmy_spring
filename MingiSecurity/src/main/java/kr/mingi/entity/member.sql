SELECT * FROM member;
INSERT INTO member (username, password, name) 
VALUES ('shinmingi', '123456', '신민기');

ROLLBACK;
COMMIT;

SELECT * FROM member WHERE username = 'zz';

