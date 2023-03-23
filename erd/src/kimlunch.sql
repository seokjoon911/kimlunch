
/* Drop Tables */

DROP TABLE c_comment CASCADE CONSTRAINTS;
DROP TABLE h_hash CASCADE CONSTRAINTS;
DROP TABLE likes CASCADE CONSTRAINTS;
DROP TABLE b_board CASCADE CONSTRAINTS;
DROP TABLE hash_pri CASCADE CONSTRAINTS;
DROP TABLE u_user CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE b_board
(
	bno number NOT NULL,
	article varchar2(100) NOT NULL,
	tiltle_clean varchar2(4000) NOT NULL,
	img varchar2(100),
	boardid varchar2(8) NOT NULL,
	regdate date,
	ip varchar2(20),
	readcnt number,
	grade number NOT NULL,
	heart number,
	price number,
	menu varchar2(20),
	-- 위도,경도
	map number(15,10) NOT NULL,
	userid varchar2(20) NOT NULL,
	PRIMARY KEY (bno)
);


CREATE TABLE c_comment
(
	no number NOT NULL,
	content varchar2(300) NOT NULL,
	wdate date,
	grp number,
	grps number,
	grpl number,
	userid varchar2(20) NOT NULL,
	bno number NOT NULL,
	PRIMARY KEY (no)
);


CREATE TABLE hash_pri
(
	hno number NOT NULL,
	hname varchar2(50),
	PRIMARY KEY (hno)
);


CREATE TABLE h_hash
(
	seq number NOT NULL,
	hno number NOT NULL,
	bno number NOT NULL,
	userid varchar2(20) NOT NULL,
	PRIMARY KEY (seq)
);


CREATE TABLE likes
(
	userid varchar2(20) NOT NULL,
	bno number NOT NULL,
	-- 1:즐겨찾기
	-- 2:좋아요
	-- 
	kbn varchar2(8) NOT NULL,
	PRIMARY KEY (userid, bno, kbn)
);


CREATE TABLE u_user
(
	userid varchar2(20) NOT NULL,
	nickname varchar2(20) NOT NULL UNIQUE,
	password varchar2(20),
	name varchar2(20) NOT NULL,
	phoneno varchar2(20),
	email varchar2(50) NOT NULL,
	gender number,
	address varchar2(20) NOT NULL,
	PRIMARY KEY (userid)
);



/* Create Foreign Keys */

ALTER TABLE c_comment
	ADD FOREIGN KEY (bno)
	REFERENCES b_board (bno)
;


ALTER TABLE h_hash
	ADD FOREIGN KEY (bno)
	REFERENCES b_board (bno)
;


ALTER TABLE likes
	ADD FOREIGN KEY (bno)
	REFERENCES b_board (bno)
;


ALTER TABLE h_hash
	ADD FOREIGN KEY (hno)
	REFERENCES hash_pri (hno)
;


ALTER TABLE b_board
	ADD FOREIGN KEY (userid)
	REFERENCES u_user (userid)
;


ALTER TABLE c_comment
	ADD FOREIGN KEY (userid)
	REFERENCES u_user (userid)
;


ALTER TABLE h_hash
	ADD FOREIGN KEY (userid)
	REFERENCES u_user (userid)
;


ALTER TABLE likes
	ADD FOREIGN KEY (userid)
	REFERENCES u_user (userid)
;



/* Comments */

COMMENT ON COLUMN b_board.map IS '위도,경도';
COMMENT ON COLUMN likes.kbn IS '1:즐겨찾기
2:좋아요
';



