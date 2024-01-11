-- 메인 광고 DB
create table mainAdvertisementS(
	idx int not null auto_increment primary key,
	mainImg varchar(200) not null,
	url varchar(300) not null,
	mDate datetime default now(),
	openSw char(1) default 'N'
);

-- 기본 값 설정
insert into mainAdvertisementS values (default,'광고준비.png','',now(),default);
select * from mainAdvertisementS;

-- 메인 광고 유저 화면에 보이도록 처리 DB (join시 이 테이블로 같이 insert 할 것)
create table UserShowAdvertisementS(
	idx int not null auto_increment primary key,
	adIdx int not null default 1,
	mid varchar(17) not null,
	loginDate datetime default now(),
	alarm char(1) default 'Y',
	alarmNDate datetime default now(),
	foreign key(adIdx) references mainAdvertisementS (idx),
	foreign key(mid) references memberS (mid)
);

insert into UserShowAdvertisementS values (default,default,'admin',default,default,default);
select * from UserShowAdvertisementS;
drop table UserShowAdvertisementS;

-- 이벤트 메일 전송 DB
create table eventMailS(
	idx int not null auto_increment primary key,
	title varchar(51) not null,
	content text not null,
	mDate datetime default now()
	fName varchar(200) default '',
);