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
select usd.* from usedS usd, usedReportS usr where usd.idx = usr.usedIdx group by usd.idx;
select * from noticeS;
select *,(select title from usedS usd where usd.idx = usr.usedIdx ) as title from usedReportS usr order by usr.idx desc;

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
	idx int not null auto_increment primary key,	/* 고유번호 */
	category varchar(21) not null,					/* 유형(카테고리) */
	question varchar(41) not null,					/* 질문 */
	answer text not null							/* 답변 */
);

-- 중고거래 게시판 DB
create table usedS(
	idx int not null auto_increment primary key,
	imgs varchar(600) not null,
	title varchar(41) not null,
	topCategoryIdx int not null,
	midCategoryIdx int,
	btmCategoryIdx int,
	region varchar(20) not null,
	usedState varchar(20) not null,
	exchange char(2) not null,
	money int not null,
	delivery int not null default 0,
	content text not null,
	mid varchar(17) not null,
	viewCnt int default 0,
	totLike int default 0,
	state char(4) not null default '판매중',
	userDel char(1) default 'N',
	uploadDate datetime default now(),
	
	foreign key (mid) references memberS (mid)
);

-- 대분류
create table topCategoryS(
	idx int not null auto_increment primary key,
	topCategoryName varchar(16) not null
);

insert into topCategory values(default,'여성의류');
insert into topCategory values(default,'남성의류');
insert into topCategory values(default,'신발');
insert into topCategory values(default,'반려동물용품');
insert into topCategory values(default,'도서/티켓/문구');
insert into topCategory values(default,'스타굿즈');
insert into topCategory values(default,'키덜트');
insert into topCategory values(default,'뷰티/미용');

-- 중분류
create table midCategoryS(
	idx int not null auto_increment primary key,
	topCategoryIdx int not null,
	midCategoryName varchar(16) not null,
	
	foreign key (topCategoryIdx) references topCategory (idx)
);
insert into midCategory values(default,8,'스킨케어');
insert into midCategory values(default,8,'색조메이크업');
insert into midCategory values(default,8,'베이스메이크업');
insert into midCategory values(default,8,'바디/헤어케어');
insert into midCategory values(default,8,'향수/아로마');
insert into midCategory values(default,8,'네일아트/케어');
insert into midCategory values(default,8,'미용소품/기기');
insert into midCategory values(default,8,'다이어트/이너뷰티');
insert into midCategory values(default,8,'남성 화장품');

-- 소분류
create table btmCategoryS(
	idx int not null auto_increment primary key,
	topCategoryIdx int not null,
	midCategoryIdx int not null,
	btmCategoryName varchar(16) not null,
	
	foreign key (topCategoryIdx) references topCategory (idx),
	foreign key (midCategoryIdx) references midCategory (idx)
);

insert into btmCategoryS values(default,2,14,'');
insert into btmCategoryS values(default,2,14,'언더웨어');
insert into btmCategoryS values(default,2,14,'홈웨어');

drop table usedS;
drop table likeS;

-- 찜하기
create table likeS(
	idx int not null auto_increment primary key,
	usedIdx int not null,
	likeMid varchar(17) not null,
	alarm char(1) default 'Y',
	
	foreign key (usedIdx) references usedS (idx)
);

-- 상점
create table storeS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	mid varchar(17) not null,						/* 누구 상점인지 */
	storeIntroduce text,							/* 상점 소개 */
	userDel char(1) default 'N',					/* 탈퇴유무 */
	
	foreign key (mid) references memberS (mid)
);

drop table storeS;

-- 팔로우 리스트
create table followS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	followerMid varchar(17) not null,				/* 팔로우 누른 사람(로그인한 사람) */
	followingMid varchar(17) not null,				/* 누구를 팔로우 했는지 */
	alarm char(1) default 'Y',						/* 알림유무(Y:알림on / N:알림off) */
	followAlarm char(1) default 'Y',				/* ~~님이 당신을 팔로우 했습니다. 알림을 위한 알림유무(Y:알림on / N:알림off) (알림 클릭시 N로 업데이트처리) */
	
	unique key(followingMid),
	foreign key (followerMid) references memberS (mid)
);
select * from usedS where mid = 'admin' order by idx desc limit 1
drop  table followS;

-- 팔로우 알림이 Y 일시 추가되는 게시물 알림 리스트
create table followUsedAlarmS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	usedIdx int not null,							/* 올린 게시글 알림 */
	UpUsedMid varchar(17) not null,					/* 게시물 올린 사람(팔로잉한 사람) */
	alarmMid varchar(17) not null,					/* 알림 받는 사람(로그인한 사람) */
	
	foreign key (usedIdx) references usedS (idx),
	foreign key (alarmMid) references followS (followerMid)
);

drop table followUsedAlarm;

-- 중고거래 신고 들어온 거 확인 (신고 들어오고 관리자가 문제 있다고 생각하면 userreports에 추가)
create table usedReportS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	usedIdx int not null,							/* 신고된 게시글 idx */
	usedMid varchar(17) not null,					/* 신고된 게시글 작성자 */
	reportMid varchar(17) not null,					/* 신고자 */
	rDate datetime default now(),					/* 신고날 */
	reason varchar(301) not null,					/* 신고 이유 */
	
	foreign key (usedIdx) references usedS (idx)
);


-- 알림


-- 커뮤니티 게시판 DB


-- 좋아요 DB (커뮤니티, 모아모아)

