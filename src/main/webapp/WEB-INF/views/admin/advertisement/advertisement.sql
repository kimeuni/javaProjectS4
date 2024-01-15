-- 메인 광고 DB
create table mainAdvertisementS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	mainImg varchar(200) not null,					/* 메인이미지 */
	url varchar(300) not null,						/* url 주소 */
	mDate datetime default now(),					/* 등록일 */
	openSw char(1) default 'N'						/* 공개여부(공개 :Y / 비공개 :N) */
);

-- 기본 값 설정
insert into mainAdvertisementS values (default,'광고준비.png','',now(),default);
select * from mainAdvertisementS;

-- 메인 광고 유저 화면에 보이도록 처리 DB (join시 이 테이블로 같이 insert 할 것)
create table UserShowAdvertisementS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	mid varchar(17) not null,						/* 유저 아이디 */
	loginDate datetime default now(),				/* 로그인한 날짜 */
	alarm char(1) default 'Y',						/* 광고보기 유무(오늘 하루 안보기에서 사용) */
	alarmNDate datetime default now(),				/* 알람을 N로 처리한 날짜(오늘 하루 안보기에서 사용) */
	foreign key(mid) references memberS (mid)
);

insert into UserShowAdvertisementS values (default,default,'admin',default,default,default);
select * from UserShowAdvertisementS;
drop table UserShowAdvertisementS;

-- 이벤트 메일 전송 DB
create table eventMailS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	title varchar(51) not null,						/* 제목 */
	content text not null,							/* 내용 */
	mDate datetime default now()					/* 메일 보낸 날짜 */
	fName varchar(200) default '',					/* 보낸 이미지 */
);