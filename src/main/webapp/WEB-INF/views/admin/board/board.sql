show tables;

-- 공지사항 DB
create table noticeS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	nickName varchar(11) not null,					/* 닉네임 */
	title varchar(41) not null,						/* 제목 */
	content text not null,							/* 내용 */
	nDate datetime default now(),					/* 작성일 */
	readNum int default 0,							/* 조회수 */
	openSw char(1) default 'Y'						/* 공개:Y 비공개:N */
);

-- 이벤트 DB
create table eventS(
	idx int not null auto_increment primary key,
	nickName varchar(11) not null,
	title varchar(41) not null,
	content text not null,
	startDate datetime default now(),
	endDate datetime default now(),
	readNum int default 0,
	openSw char(1) default 'Y'
);

desc eventS;
drop table eventS;

-- 자주하는 질문 DB
create table FAQS(
	idx int not null auto_increment primary key,
	category varchar(21) not null,
	question varchar(41) not null,
	answer text not null
);

-- 중고거래 게시판 DB


-- 커뮤니티 게시판 DB


-- 좋아요 DB (커뮤니티, 모아모아)


-- 찜하기


-- 알림