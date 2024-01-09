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

-- 중고거래 게시판 DB


-- 커뮤니티 게시판 DB


-- 좋아요 DB (커뮤니티, 모아모아)


-- 찜하기


-- 알림