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
	parentsReplyIdx int,
	userDel char(1) default 'N',
	
	foreign key (mid) references memberS (mid)
);