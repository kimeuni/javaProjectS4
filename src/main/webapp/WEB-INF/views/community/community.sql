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

select *,timestampdiff(second,cDate,now()) as second_diff,
		timestampdiff(minute,cDate,now()) as minute_diff,
		timestampdiff(hour,cDate,now()) as hour_diff,
		(select profile from memberS mem where comu.mid = mem.mid ) as profile,
		(select nickName from memberS mem where comu.mid = mem.mid ) as nickName,
		(select count(*) from goodS gds where gds.part = 'community' and gds.partIdx = comu.idx and gds.goodMid = 'muni12' ) as midGoodCheck,
		(select count(*) from goods gds where gds.part = 'community' and gds.partIdx = comu.idx and gds.userDel = 'N') as goodCnt,
		(select count(*) from replyS rps where rps.part = 'community' and rps.partIdx = comu.idx and rps.userDel = 'N') as replyCnt,
		(select count(*) from bookmarkS bms where bms.part = 'community' and bms.partIdx = comu.idx and bms.bookmarkMid = 'muni12' ) as midBookmarkCheck,
		(select count(*) from bookmarkS bms where bms.part = 'community' and bms.partIdx = comu.idx and bms.userDel = 'N') as bookmarkCnt
		from communityS comu where userDel = 'N' and comu.mid = 'admin' order by idx desc ;

select * from communityS comu where mid =(select bookmarkMid from bookmarkS b where bookmarkMid = 'admin' and b.part = 'community' and comu.idx = b.partIdx ) and comu.userDel = 'N';		

select bookmarkMid,comu.* from communityS comu, bookmarkS b where bookmarkMid = 'admin' and b.part = 'community' and comu.idx = b.partIdx

select count(*) from communityS comu, bookmarkS b where b.bookmarkMid = 'admin' and comu.userDel = 'N' and b.part = 'community' and comu.idx = b.partIdx;

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
	alarm char(1) default 'Y',
	
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

-- 커뮤니티 프로필
create table communityProfileS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	mid varchar(17) not null,						/* 누구 상점인지 */
	communityIntroduce text,						/* 커뮤니티 소개 */
	headerImg varchar(80) default '기본헤더.png',		/* 헤더 이미지 */
	
	foreign key (mid) references memberS (mid)
);

drop table communityProfileS