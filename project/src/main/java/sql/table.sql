select * from U_USER
select * from B_BOARD


insert into u_user (userid, nickname, password, name, phoneno, email, gender, address) VALUES ('admin','권력의힘','12345','관리자','012-3456-7890','admin@kimlunch.com',1,'강남구');
insert into u_user (userid, nickname, password, name, phoneno, email, gender, address) VALUES ('test1','테스트1','12345','테스형1','012-3456-7891','test1@kimlunch.com',2,'강동구');
insert into u_user (userid, nickname, password, name, phoneno, email, gender, address) VALUES ('test2','테스트2','12345','테스형2','012-3456-7892','test2@kimlunch.com',1,'강북구');
insert into u_user (userid, nickname, password, name, phoneno, email, gender, address) VALUES ('test3','테스트3','12345','테스형3','012-3456-7893','test3@kimlunch.com',2,'강서구');
insert into u_user (userid, nickname, password, name, phoneno, email, gender, address) VALUES ('test4','테스트4','12345','테스형4','012-3456-7894','test4@kimlunch.com',1,'동대문구');
insert into u_user (userid, nickname, password, name, phoneno, email, gender, address) VALUES ('test5','테스트5','12345','테스형5','012-3456-7895','test5@kimlunch.com',2,'노원구');

insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (1, '1번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','admin');
insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (2, '2번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','admin');
insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (3, '3번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','admin');
insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (4, '4번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','test1');
insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (5, '5번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','test1');
insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (6, '6번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','test1');
insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (7, '7번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','test2');
insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (8, '8번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','test2');
insert into b_board (bno, article, subsistence, img, boardid, regdate, ip, readcnt, grade, heart, price, menu, map_a, map_b, pname, paddress, phone, userid)
VALUES (9, '9번글', '내용','1',3,sysdate, '0',0,5,0,8000,'미역국',37.4996327751,126.9789023578,'가게이름','가게주소','02-1234-5678','test2');

insert into c_comment (cno, content, wdate, userid, bno) values (1,'댓글',sysdate,'test3',8);
insert into c_comment (cno, content, wdate, userid, bno) values (2,'댓글',sysdate,'test3',9);
insert into c_comment (cno, content, wdate, userid, bno) values (3,'댓글',sysdate,'test4',8);
insert into c_comment (cno, content, wdate, userid, bno) values (4,'댓글',sysdate,'test4',9);
insert into c_comment (cno, content, wdate, userid, bno) values (5,'댓글',sysdate,'test4',9);
insert into c_comment (cno, content, wdate, userid, bno) values (6,'댓글',sysdate,'test3',9);
insert into c_comment (cno, content, wdate, userid, bno) values (7,'댓글',sysdate,'test3',8);
insert into c_comment (cno, content, wdate, userid, bno) values (8,'댓글',sysdate,'test4',8);
insert into c_comment (cno, content, wdate, userid, bno) values (9,'댓글',sysdate,'test4',8);
insert into c_comment (cno, content, wdate, userid, bno) values (10,'댓글',sysdate,'test4',9);




/* Drop Tables */

DROP TABLE c_comment CASCADE CONSTRAINTS;
DROP TABLE h_hash CASCADE CONSTRAINTS;
DROP TABLE likes CASCADE CONSTRAINTS;
DROP TABLE b_board CASCADE CONSTRAINTS;
DROP TABLE hash_pri CASCADE CONSTRAINTS;
DROP TABLE u_user CASCADE CONSTRAINTS;



/* Create Tables */

-- 게시글
CREATE TABLE b_board
(
	-- 게시물번호
	bno number NOT NULL,
	-- 제목
	article varchar2(100) NOT NULL,
	-- 내용
	subsistence varchar2(4000) NOT NULL,
	-- 이미지
	img varchar2(100),
	-- 게시판종류
	boardid varchar2(8) NOT NULL,
	-- 등록일시
	regdate date,
	-- 작성자 IP
	ip varchar2(20),
	-- 조회수
	readcnt number,
	-- 별점
	grade number NOT NULL,
	-- 좋아요
	heart number,
	-- 가격
	price number,
	-- 메뉴
	menu varchar2(100),
	-- 상호명
	pname varchar2(100),
	-- 주소
	paddress varchar2(100),
	-- 전화번호
	phone varchar2(20),
	-- 지도 위도 : 위도,경도
	map_a number(15,10) NOT NULL,
	-- 지도 경도
	map_b number(15,10) NOT NULL,
	-- 아이디
	userid varchar2(20) NOT NULL,
	PRIMARY KEY (bno)
);

-- 댓글
CREATE TABLE c_comment
(
	-- 댓글의 번호
	cno number NOT NULL,
	-- 댓글의 내용
	content varchar2(300) NOT NULL,
	-- 댓글이 작성된 시간
	wdate date,
	-- 아이디
	userid varchar2(20) NOT NULL,
	-- 게시물번호
	bno number NOT NULL,
	PRIMARY KEY (cno)
);


-- hash테이블
CREATE TABLE hash_pri
(
	-- hash번호
	hno number NOT NULL,
	-- 해쉬값
	hname varchar2(50),
	PRIMARY KEY (hno)
);


-- 등록번호
CREATE TABLE h_hash
(
	-- 등록번호
	seq number NOT NULL,
	-- hash번호
	hno number NOT NULL,
	-- 게시물번호
	bno number NOT NULL,
	-- 아이디
	userid varchar2(20) NOT NULL,
	PRIMARY KEY (seq)
);


-- 좋아요 테이블
CREATE TABLE likes
(
	-- 아이디
	userid varchar2(20) NOT NULL,
	-- 게시물번호
	bno number NOT NULL,
	-- 구분 : 1:즐겨찾기
	-- 2:좋아요
	-- 
	kbn varchar2(8) NOT NULL,
	PRIMARY KEY (userid, bno, kbn)
);


-- 회원정보
CREATE TABLE u_user
(
	-- 아이디
	userid varchar2(20) NOT NULL,
	-- 닉네임
	nickname varchar2(20) NOT NULL UNIQUE,
	-- 비밀번호
	password varchar2(20),
	-- 이름
	name varchar2(20) NOT NULL,
	-- 연락처
	phoneno varchar2(20),
	-- 이메일
	email varchar2(50) NOT NULL UNIQUE,
	-- 성별
	gender number,
	-- 직장
	address varchar2(20) NOT NULL,
	PRIMARY KEY (userid)
);

/* Create Foreign Keys */

ALTER TABLE c_comment
	ADD FOREIGN KEY (bno)
	REFERENCES b_board (bno)
	ON DELETE CASCADE
;


ALTER TABLE h_hash
	ADD FOREIGN KEY (bno)
	REFERENCES b_board (bno)
	ON DELETE CASCADE
;


ALTER TABLE likes
	ADD FOREIGN KEY (bno)
	REFERENCES b_board (bno)
	ON DELETE CASCADE
;


ALTER TABLE h_hash
	ADD FOREIGN KEY (hno)
	REFERENCES hash_pri (hno)
	ON DELETE CASCADE
;


ALTER TABLE b_board
	ADD FOREIGN KEY (userid)
	REFERENCES u_user (userid)
	ON DELETE CASCADE;


ALTER TABLE c_comment
	ADD FOREIGN KEY (userid)
	REFERENCES u_user (userid)
	ON DELETE CASCADE;


ALTER TABLE h_hash
	ADD FOREIGN KEY (userid)
	REFERENCES u_user (userid)
	ON DELETE CASCADE
;


ALTER TABLE likes
	ADD FOREIGN KEY (userid)
	REFERENCES u_user (userid)
	ON DELETE CASCADE
;


/* Comments */

COMMENT ON TABLE b_board IS '게시글';
COMMENT ON COLUMN b_board.bno IS '게시물번호';
COMMENT ON COLUMN b_board.article IS '제목';
COMMENT ON COLUMN b_board.subsistence IS '내용';
COMMENT ON COLUMN b_board.img IS '이미지';
COMMENT ON COLUMN b_board.boardid IS '게시판종류';
COMMENT ON COLUMN b_board.regdate IS '등록일시';
COMMENT ON COLUMN b_board.ip IS '작성자 IP';
COMMENT ON COLUMN b_board.readcnt IS '조회수';
COMMENT ON COLUMN b_board.grade IS '별점';
COMMENT ON COLUMN b_board.heart IS '좋아요';
COMMENT ON COLUMN b_board.price IS '가격';
COMMENT ON COLUMN b_board.menu IS '메뉴';
COMMENT ON COLUMN b_board.pname IS '상호명';
COMMENT ON COLUMN b_board.paddress IS '주소';
COMMENT ON COLUMN b_board.map_a IS '지도 위도 : 위도,경도';
COMMENT ON COLUMN b_board.map_b IS '지도 경도';
COMMENT ON COLUMN b_board.userid IS '아이디';
COMMENT ON TABLE c_comment IS '댓글';
COMMENT ON COLUMN c_comment.cno IS '댓글의 번호';
COMMENT ON COLUMN c_comment.content IS '댓글의 내용';
COMMENT ON COLUMN c_comment.wdate IS '댓글이 작성된 시간';
COMMENT ON COLUMN c_comment.grp IS '모댓글의 번호';
COMMENT ON COLUMN c_comment.grps IS '동일 모댓글내의 대댓글 순서';
COMMENT ON COLUMN c_comment.grpl IS '모댓글과 답글을 구분';
COMMENT ON COLUMN c_comment.userid IS '아이디';
COMMENT ON COLUMN c_comment.bno IS '게시물번호';
COMMENT ON TABLE hash_pri IS 'hash테이블';
COMMENT ON COLUMN hash_pri.hno IS 'hash번호';
COMMENT ON COLUMN hash_pri.hname IS '해쉬값';
COMMENT ON TABLE h_hash IS '등록번호';
COMMENT ON COLUMN h_hash.seq IS '등록번호';
COMMENT ON COLUMN h_hash.hno IS 'hash번호';
COMMENT ON COLUMN h_hash.bno IS '게시물번호';
COMMENT ON COLUMN h_hash.userid IS '아이디';
COMMENT ON TABLE likes IS '좋아요 테이블';
COMMENT ON COLUMN likes.userid IS '아이디';
COMMENT ON COLUMN likes.bno IS '게시물번호';
COMMENT ON COLUMN likes.kbn IS '구분 : 1:즐겨찾기 2:좋아요';
COMMENT ON TABLE u_user IS '회원정보';
COMMENT ON COLUMN u_user.userid IS '아이디';
COMMENT ON COLUMN u_user.nickname IS '닉네임';
COMMENT ON COLUMN u_user.password IS '비밀번호';
COMMENT ON COLUMN u_user.name IS '이름';
COMMENT ON COLUMN u_user.phoneno IS '연락처';
COMMENT ON COLUMN u_user.email IS '이메일';
COMMENT ON COLUMN u_user.gender IS '성별';
COMMENT ON COLUMN u_user.address IS '직장';