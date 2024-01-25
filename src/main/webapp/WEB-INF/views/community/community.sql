show tables;

-- 커뮤니티 글 올리기
create table communityS(
	idx int not null auto_increment primary key,
	mid varchar(17) not null,
	content varchar(141) not null,
	imgs varchar(400) not null,
	cDate datetime default now(),
	region varchar(20) not null,
	userDel char(1) default 'N',
	
	foreign key (mid) references memberS (mid)
);

drop table communityS;


-- 좋아요
create table goodS(
	idx int not null auto_increment primary key,
	part varchar(10) not null,
	partIdx int not null,
	goodMid varchar(17) not null,
	alarm char(1) default 'Y',
	userDel char(1) default 'N',
	
	foreign key (goodMid) references memberS (mid)
);

-- 북마크
create table bookmarkS(
	idx int not null auto_increment primary key,
	part varchar(10) not null,
	partIdx int not null,
	bookmarkMid varchar(17) not null,
	userDel char(1) default 'N',
	
	foreign key (bookmarkMid) references memberS (mid)
);

-- 댓글
create table replyS(
	idx int not null auto_increment primary key,
	part varchar(10) not null,
	partIdx int not null,
	mid varchar(17) not null,
	content varchar(141) not null,
	rDate datetime default now(),
	parentsReplyIdx int default 0,
	userDel char(1) default 'N',
	
	foreign key (mid) references memberS (mid)
);

-- 커뮤니티 글,댓글 신고 리스트
create table communityReportS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	part varchar(10) not null,						/* 신고된 곳 (community/reply) */
	partIdx int not null,							/* 신고된 게시글 idx */
	mid varchar(17) not null,						/* 신고된 게시글 작성자 */
	reportMid varchar(17) not null,					/* 신고자 */
	rDate datetime default now(),					/* 신고날 */
	reason varchar(30) not null						/* 신고 이유 */
);