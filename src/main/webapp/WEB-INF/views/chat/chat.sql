show tables;

-- 채팅 이모티콘
create table emoticonS(
	idx int not null auto_increment primary key,
	img varchar(50) not null,
	eDate datetime default now()
);
select * from chatGroupS where (mid1 = 'admin' or mid2 = 'admin') and (mid1 = 'axdc1234' or mid2 = 'axdc1234')
-- 채팅 그룹
create table chatGroupS(
	idx int not null auto_increment primary key,
	usedIdx int not null default 0,
	mid1 varchar(17) not null,
	mid2 varchar(17) not null
);

drop table chatGroupS;

-- 채팅
create table chatS(
	idx int not null auto_increment primary key,
	chatIdx int not null,
	mid1 varchar(17) not null,
	mid2 varchar(17) not null,
	emoticonIdx int not null,
	chat varchar(101),
	alarm char(1) default 'Y',
	chatDate datetime default now(),
	whoChatMid varchar(17) not null,
	
	foreign key (chatIdx) references chatGroupS (idx)
);

drop table chatS;
